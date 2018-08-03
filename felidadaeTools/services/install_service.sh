#!/bin/bash -e
sudo cp keyboard_mappings.service /etc/systemd/system 
sudo cp tmux_clipboard.service /etc/systemd/system 
sudo systemctl start keyboard_mappings
sudo systemctl start tmux_clipboard
