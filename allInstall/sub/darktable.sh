#!/bin/bash -e
cd "$_sources"
if [[ ! -d darktable ]]; then
	git clone https://github.com/darktable-org/darktable.git
	cd darktable
	git tag
fi

sudo apt-get install -y gcc g++ cmake intltool xsltproc libgtk-3-dev libxml2-utils libxml2-dev liblensfun-dev librsvg2-dev libsqlite3-dev libcurl4-gnutls-dev libjpeg-dev libtiff5-dev liblcms2-dev libjson-glib-dev libexiv2-dev libpugixml-dev
sudo apt-get install -y libgphoto2-dev libsoup2.4-dev libopenexr-dev libwebp-dev libflickcurl-dev libopenjpeg-dev libsecret-1-dev libgraphicsmagick1-dev libcolord-dev libcolord-gtk-dev libcups2-dev libsdl1.2-dev libsdl-image1.2-dev libgl1-mesa-dev libosmgpsmap-1.0-dev
sudo apt-get install -y default-jdk gnome-doc-utils libsaxon-java fop imagemagick docbook-xml docbook-xsl
