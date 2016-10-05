source $general/myLibraries/bash/replaceWithRegexInFile.sh

function all_setToDark {
	if [[ "$OS_KERNEL__" == "linux" && "$DESKTOP_SESSION__" == "gnome" ]]; then
		gnome-shell-theme_changeToDark
		gnome-terminal_changeToDark
	fi
	vim_changeToDark
	subl_changeToDark
}
function all_setToLight {
	if [[ "$OS_KERNEL__" == "linux" && "$DESKTOP_SESSION__" == "gnome" ]]; then
		gnome-shell-theme_changeToLight
		gnome-terminal_changeToLight
	fi
	vim_changeToLight
	subl_changeToLight
}
function all_setToMonokai {
	if [[ "$OS_KERNEL__" == "linux" && "$DESKTOP_SESSION__" == "gnome" ]]; then
		gnome-shell-theme_changeToDark
		gnome-terminal_changeToMonokai
	fi
	subl_changeToMonokai
	vim_changeToMonokai
}

#gnome-shell-theme
function gnome-shell-theme_changeToDark {
	# gsettings set org.gnome.desktop.interface gtk-color-scheme 'Numix'
	gsettings set org.gnome.desktop.interface gtk-theme 'Adapta-Nokto'
	# gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/Lockscreen_by_EstebanMitnick.jpg'
	
	gtkpref=~/.config/gtk-3.0/settings.ini
	replaceWithRegexInFile "$gtkpref" "gtk-application-prefer-dark-theme=0" "gtk-application-prefer-dark-theme=1"
}
function gnome-shell-theme_changeToLight {
	# gsettings set org.gnome.desktop.interface gtk-color-scheme 'Adwaita'
	gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
	# gsettings set org.gnome.desktop.background picture-uri 'file:///home/felidadae/Pictures/Wallpapers/skyrim-mountains-winter-snow-shine-glare-2880x1800.jpg'

	replaceWithRegexInFile "$gtkpref" "gtk-application-prefer-dark-theme=0" "gtk-application-prefer-dark-theme=0"
}

#gnome-terminal
function gnome-terminal_changeToDark {
	bash $general/tools/gnome-terminal-colors-solarized/set_dark.sh
}
function gnome-terminal_changeToLight {
	bash $general/tools/gnome-terminal-colors-solarized/set_light.sh
}
function gnome-terminal_changeToMonokai {
	bash $general/tools/gnome-terminal-colors-monokai/install.sh
}

#VIM
function vim_changeToDark {
	vim_pref=~/.vimrc
	replaceWithRegexInFile "$vim_pref" "set background=light" "set background=dark"
}
function vim_changeToLight {
	vim_pref=~/.vimrc
	replaceWithRegexInFile "$vim_pref" "set background=dark" "set background=light"
}
function vim_changeToMonokai {
	vim_pref=~/.vimrc
	replaceWithRegexInFile "$vim_pref" "colorscheme .*$" "colorscheme monokai"
}


#Sublime
function subl_changeToDark {
	replaceWithRegexInFile "$sublime3_mainpref" \
		"\"color_scheme\"\:.*$" \
		"\"color_scheme\": \"Packages\/Solarized Color Scheme\/Solarized (dark).tmTheme\","
	replaceWithRegexInFile "$sublime3_mainpref" \
		"\"theme\"\:.*$" \
		"\"theme\": \"Material-Theme.sublime-theme\","

	replaceWithRegexInFile "$general/configurationFiles/sublime-text/Material-Theme-Lighter.sublime-theme" \
		"\"color\"\:.*$" \
		"\"color\": [160,160,160],"
}
function subl_changeToLight {
	replaceWithRegexInFile "$sublime3_mainpref" \
		"\"color_scheme\"\:.*$" \
		"\"color_scheme\": \"Packages\/Solarized Color Scheme\/Solarized (light).tmTheme\","
	# replaceWithRegexInFile "$sublime3_mainpref" \
	# 	"Dark" \
	# 	"Light"

	replaceWithRegexInFile "$sublime3_mainpref" \
		"\"theme\"\:.*$" \
		"\"theme\": \"Material-Theme-Lighter.sublime-theme\","

	replaceWithRegexInFile "$general/configurationFiles/sublime-text/Material-Theme-Lighter.sublime-theme" \
		"\"color\"\:.*$" \
		"\"color\": [50,50,50],"
}
function subl_changeToMonokai {
	replaceWithRegexInFile "$sublime3_mainpref" \
		"\"color_scheme\"\:.*$" \
		"\"color_scheme\": \"Packages\/Colorcoder\/Monokai (Colorcoded).tmTheme\","
	# replaceWithRegexInFile "$sublime3_mainpref" \
	# 	"Light" \
	# 	"Dark"
	replaceWithRegexInFile "$sublime3_mainpref" \
		"\"theme\"\:.*$" \
		"\"theme\": \"Material-Theme.sublime-theme\","

	replaceWithRegexInFile "$general/configurationFiles/sublime-text/Material-Theme-Lighter.sublime-theme" \
		"\"color\"\:.*$" \
		"\"color\": [160,160,160],"
}
