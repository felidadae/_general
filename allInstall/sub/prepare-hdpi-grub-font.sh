#!/bin/bash -e
sudo grub-mkfont --output=/boot/grub/fonts/DejaVuSansMono24.pf2 --size=34 /usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf

echo "Paste into file /etc/default/grub:"
# More readable font on high dpi screen, generated with
# # sudo grub-mkfont --output=/boot/grub/fonts/DejaVuSansMono24.pf2 \
	# #    --size=24 /usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf
echo "GRUB_FONT=/boot/grub/fonts/DejaVuSansMono24.pf2"
read

sudo vim /etc/default/grub
sudo update-grub
