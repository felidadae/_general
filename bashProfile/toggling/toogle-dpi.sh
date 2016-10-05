function all_dpi_setRetina {
	gsettings set org.gnome.desktop.interface scaling-factor 2
	gsettings set org.gnome.desktop.interface text-scaling-factor 1.2
	gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <2>}]"
}

function all_dpi_set2560External {
	gsettings set org.gnome.desktop.interface scaling-factor 1
	gsettings set org.gnome.desktop.interface text-scaling-factor 1.2
	gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <1>}]"
}

function all_extensions {
	gsettings set org.gnome.shell enabled-extensions ['freon@UshakovVasilii_Github.yahoo.com', 'dash-to-dock@micxgx.gmail.com', 'CoverflowAltTab@palatis.blogspot.com']
}