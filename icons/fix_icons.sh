#!/bin/bash -e

sudo perl -i.backup -pe 's/^Icon=.*$/Icon=\/home\/felidadae\/Programming\/_General\/icons\/terminal.png/' \
    /usr/share/applications/gnome-terminal.desktop
