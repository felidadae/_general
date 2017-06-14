#	Naming scheme:
#		jira_issues			 											J
#		offline_eval_reports 											O
#		jira_issues joined with offline                                 JO
#		jira_issues joined with offline filtered only successes         JOs
#		jira_issues joined with offline filtered only failed            JOf
#		jira_issues joined with offline filtered only NOT_MATCED        JOnm
#		jira_issues joined with offline filtered failed and NOT_MATCHED JOfnm
#
#		results directory												R
#		deepserver version 												DSv
#		date															D

SHELL := /bin/bash
R := results
subtools := subtools
configuration := configuration
MNT_M=/mnt/m

DSv := $(shell ls -1t $(MNT_M)/delivery/t0/deepserver/ | \
   	grep tar.gz | head -1 | \
	perl -ne 'print "$$1" if /es-us-(.*?)-/;')
D := $(shell date +%Y%m%d)
Cv:= 

.PHONY: configuration clean prepare_JOs resolve_issues



configuration:
	@echo DSv=$(DSv); echo D=$(D); echo config_file=$(configuration)/config.json


# @issues which do not match domain spec
$(R)/$(D)__recomponent_issues.tsv: $(R)/$(D)__J.tsv
	@bash reblame_issue 




# @resolve issues on JIRA which pass in offline-DT
resolve_issues: $(R)/$(D)__$(DSv)__resolved_issues.tsv
$(R)/$(D)__$(DSv)__resolved_issues.tsv: $(R)/$(D)__$(DSv)__JOs.tsv
	@python3 resolve_jira_issues.py <(cut -f1 $^) $(configuration)/config.json $(DSv) $@



# @Simple filtering %__JO.tsv into categories
prepare_JOs: $(R)/$(D)__$(DSv)__JOs.tsv $(R)/$(D)__$(DSv)__JOf.tsv $(R)/$(D)__$(DSv)__JOnm.tsv $(R)/$(D)__$(DSv)__JOfnm.tsv
	@echo main

$(R)/$(D)__$(DSv)__JOs.tsv: $(R)/$(D)__$(DSv)__JO.tsv
	perl -F'\t' -lane 'print if $$F[-1] eq "O";' $^ > $@; 
$(R)/$(D)__$(DSv)__JOf.tsv: $(R)/$(D)__$(DSv)__JO.tsv
	perl -F'\t' -lane 'print if $$F[-1] eq "X";' $^ > $@; 
$(R)/$(D)__$(DSv)__JOnm.tsv: $(R)/$(D)__$(DSv)__JO.tsv
	perl -F'\t' -lane 'print if $$F[-1] eq "NOT_MATCHED";' $^ > $@; 
$(R)/$(D)__$(DSv)__JOfnm.tsv: $(R)/$(D)__$(DSv)__JO.tsv
	perl -F'\t' -lane 'print if ($$F[-1] eq "NOT_MATCHED") or ($$F[-1] eq "X");' $^ > $@; 



# @Fetching data and joining
$(R)/$(D)__$(DSv)__JO.tsv: $(R)/$(D)__J.tsv $(R)/$(DSv)__O.tsv
	@bash -e join_jira_offline.sh $@ $^

$(R)/$(D)__J.tsv: $(configuration)/config.json 
	@python3 fetch_jira_issues.py $(configuration)/config.json $@; bash $(subtools)/unique_rows_tsv.sh $@;

$(R)/$(DSv)__O.tsv.ingredients: $(R)/$(DSv)__O.tsv
$(R)/$(DSv)__O.tsv:
	@export MNT_M=$(MNT_M) && bash fetch_offline_results.sh $@ $(DSv) $@.ingredients; bash $(subtools)/unique_rows_tsv.sh $@;



clean:
	rm $(R)/*
