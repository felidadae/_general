import os

# ls = os.listdir(".")
# for l in ls:
# 	if "@2x" in l:
# 		print l
# exit

toDO = [
	"spinner8@2x.png",
	"spinner11@2x.png",
	"folder_opened--hover-7@2x.png",
	"folder_opened--hover-6@2x.png",
	"spinner4@2x.png",
	"use_buffer--hover@2x.png",
	"normal_thumb_horizontal@2x.png",
	"folder_dup--hover@2x.png",
	"find_reverse--hover@2x.png",
	# "panel_separator@2x.png",
	"overflow_menu--hover@2x.png",
	"close_icon--hover@2x.png",
	"spinner7@2x.png",
	"dirty_icon--hover@2x.png",
	"normal_thumb_vertical@2x.png",
	"folder_opened--hover-2@2x.png",
	"spinner6@2x.png",
	"fold_down--hover@2x.png",
	"arrow_right--hover@2x.png",
	"spinner@2x.png",
	"find_context--hover@2x.png",
	"spinner3@2x.png",
	# "tab_separator@2x.png",
	"spinner1@2x.png",
	"arrow_left--hover@2x.png",
	# "panel_separator@2x.gif",
	"folder_opened--hover-3@2x.png",
	"fold_right@2x.png",
	"folder_opened--hover-1@2x.png",
	"replace_preserve_case--hover@2x.png",
	"folder--hover@2x.png",
	"tree_highlight@2x.png",
	"arrow_down--hover@2x.png",
	"find_word--hover@2x.png",
	"folder_opened--hover-0@2x.png",
	"arrow_down@2x.png",
	"spinner10@2x.png",
	"folder_opened--hover-4@2x.png",
	"find_regex--hover@2x.png",
	"spinner5@2x.png",
	"find_wrap--hover@2x.png",
	"find_inselection--hover@2x.png",
	"spinner9@2x.png",
	"find_case--hover@2x.png",
	"folder_opened--hover@2x.png",
	"spinner2@2x.png",
	"folder_opened--hover-5@2x.png",
	"fold_right--hover@2x.png",
	"find_highlight--hover@2x.png",
]

for l in toDO:
	if os.path.isfile(l):
		l2 = l.replace("@2x", "")
		os.remove(l2)
		os.rename(l, l2)
		