import os
# ls = os.listdir(".")
# for l in ls:
# 	if "@2x" in l:
# 		print l
# exit

toDO = [
	"tab_current@2x.png",
	"fold_down@2x.png",
	"tab_animation6@2x.png",
	"dirty_icon@2x.png",
	"find_wrap@2x.png",
	"tab_animation1@2x.png",
	"tab_animation8@2x.png",
	"find_regex@2x.png",
	"thumb_horizontal@2x.png",
	"folder_dup--hover@2x.png",
	"replace_preserve_case@2x.png",
	"find_case@2x.png",
	"tab_animation12@2x.png",
	"find_context@2x.png",
	"close_icon@2x.png",
	# "input_field_border@2x.png",
	"arrow_right@2x.png",
	"tab_animation9@2x.png",
	"tab_animation3@2x.png",
	"thumb_vertical@2x.png",
	"tab_animation5@2x.png",
	"tab_animation11@2x.png",
	"tab_animation10@2x.png",
	"find_inselection@2x.png",
	"overflow_menu@2x.png",
	"tab_animation13@2x.png",
	"find_word@2x.png",
	"find_reverse@2x.png",
	"tab_animation2@2x.png",
	"arrow_left@2x.png",
	"folder_dup@2x.png",
	# "input_field_bar@2x.png",
	"blue_highlight@2x.png",
	"tab_animation7@2x.png",
	"folder@2x.png",
	"find_highlight@2x.png",
	# "overlay-bg@2x.png",
	"use_buffer@2x.png",
	"tab_animation4@2x.png",
]

for l in toDO:
	if os.path.isfile(l):
		l2 = l.replace("@2x", "")
		os.remove(l2)
		os.rename(l, l2)
		
		