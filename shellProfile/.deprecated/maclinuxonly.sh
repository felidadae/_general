function mbpfan__logs {
	sudo cat /var/log/upstart/mbpfan.log
}
function mbpfan__settings_get {
	sudo cat /etc/mbpfan.conf 
}
function mbpfan__settings_set {
	sudo gedit /etc/mbpfan.conf
}