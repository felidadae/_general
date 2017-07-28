#!/bin/bash -e

############################################
##### @Description
# Join E2E Offline and Sel;
# additional add device logs and deepserver logs columns, if value unknown add N/A

##### @Author
# s.bugaj@samsung.com
############################################


function get_unique_column {
    source=$1 #must contain header
    column_name=$2
    destiny=$3
    $scripts/cut_by_column_name -f"$column_name" "$source" | sed '1d' | sort -u > $destiny
}
function fill_lacking_items {
    # to implement join with N/A
    to_fill=$1
    column_full=$2
    column_name=$3
    local tmp=$(mktemp)

    export N=$(head -1 $to_fill | perl -F'\t' -lane 'print scalar(@F)-1;')
    cat $to_fill > $tmp
    comm -13 <($scripts/cut_by_column_name -f"$column_name" $to_fill | sed '1d' | sort -u ) <(sort -u $column_full) | \
        perl -ne 'chomp; print "$_" . "\tN/A"x$ENV{N} . "\n";' >> $tmp
    mv $tmp $to_fill
}
function squash_unique_by_column {
    input=${1}
    export colname=${2}

    export col_num=$(head -1 $input | perl -F'\t' -lane '$i=0; foreach $col (@F) { print $i if $col eq $ENV{colname}; ++$i; }') #1 indexed
    perl -i -F'\t' -lane 'print unless $h{$F[$ENV{col_num}]}++ || $.==0;' $input #linear usage of memory
}


E2E=${1}
O=${2}
Sel=${3}
#-----
DL=${4}
SL=${5}

sed -i 's/\r//g' $DL

tmp=$(mktemp)
tmp2=$(mktemp)
UUID_unique=$(mktemp)

get_unique_column "$E2E" "tc_id" "$UUID_unique"
fill_lacking_items "$DL" "$UUID_unique" "uuid"
fill_lacking_items "$SL" "$UUID_unique" "uuid"
squash_unique_by_column "$DL" "uuid"
squash_unique_by_column "$Sel" "uuid"
squash_unique_by_column "$SL" "uuid"
$scripts/join_with_header "$E2E" "tc_id" "$O" "#tc_id" > "$tmp"
# >&2 wc -l "$tmp"  #E2E.O
$scripts/join_with_header "$tmp" "tc_id" "$Sel" "sel_uuid" > "$tmp2"
# >&2 wc -l $tmp2 #E2E.O.Sel
$scripts/join_with_header "$tmp2" "tc_id" "$DL" "uuid" > "$tmp"
# >&2 wc -l "$tmp"  #
$scripts/join_with_header "$tmp" "tc_id" "$SL" "uuid" > "$tmp2"
# >&2 wc -l "$tmp2"
cat "$tmp2"
rm "$tmp" "$tmp2" "$UUID_unique"
