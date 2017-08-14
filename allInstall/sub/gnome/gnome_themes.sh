#!/bin/bash -e
sudo apt-add-repository ppa:tista/adapta
sudo apt update && sudo apt install adapta-gtk-theme
mkdir -p ~/.themes
cp -r /usr/share/themes/Adapta-Nokto ~/.themes/Adapta-Nokto-My
cd ~/.themes/Adapta-Nokto-My

#apply path
perl -i -pe 'if (/^stage/) {s/font-family:.*?;/font-family: Ubuntu Condensed;/g;}' gnome-shell.css 
perl -i -pe 'if (/^stage/) {s/font-size:.*?;/font-size: 11pt;/g;}' gnome-shell.css 
exit 0





diff --git a/gnome-shell.css b/gnome-shell.css
index da380e1..13eaaac 100644
--- a/gnome-shell.css
+++ b/gnome-shell.css
@@ -3,7 +3,7 @@
 /*********** Globals * **********/
 * { transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1); transition-duration: 0.2s; }
 
-stage { font-family: Ubuntu Condensed; font-weight: 400; font-size: 11pt; color: #ECEFF1; }
+stage { font-family: Noto Sans, Cantarell, Sans-Serif; font-weight: 400; font-size: 10pt; color: #ECEFF1; }
 
 /*********** Widgets * **********/
 /*********** Buttons * **********/
@@ -256,7 +256,7 @@ StScrollBar StButton#vhandle:active, StScrollBar StButton#hhandle:active { backg
 .tile-preview-left.tile-preview-right.on-primary { border-radius: 0 0 0 0; }
 
 /*********** Top Bar * **********/
-#panel { height: 30px; font-weight: 700; background-color: #13191c; }
+#panel { height: 25px; font-weight: 700; background-color: #13191c; }
 #panel:overview, #panel.unlock-screen, #panel.login-screen, #panel.lock-screen { background-color: rgba(0, 0, 0, 0.01); box-shadow: inset 0 2px 0 #13191c; }
 #panel #panelLeft, #panel #panelCenter { spacing: 0; }
 #panel .panel-corner { -panel-corner-radius: 0; -panel-corner-background-color: #13191c; -panel-corner-border-width: 2px; -panel-corner-border-color: transparent; }
@@ -269,7 +269,7 @@ StScrollBar StButton#vhandle:active, StScrollBar StButton#hhandle:active { backg
 #panel .panel-button:hover { color: #FFFFFF; background-color: rgba(0, 0, 0, 0.01); box-shadow: inset 0 2px 0 rgba(236, 239, 241, 0.4); }
 #panel .panel-button:active, #panel .panel-button:focus, #panel .panel-button:checked, #panel .panel-button:overview { background-color: rgba(0, 0, 0, 0.01); box-shadow: inset 0 2px 0 #00BCD4; color: #FFFFFF; }
 #panel .panel-button:active > .system-status-icon, #panel .panel-button:focus > .system-status-icon, #panel .panel-button:checked > .system-status-icon, #panel .panel-button:overview > .system-status-icon { icon-shadow: none; }
-/* #panel .panel-button .system-status-icon { icon-size: 16px; padding: 0 3px; } */
+#panel .panel-button .system-status-icon { icon-size: 16px; padding: 0 3px; }
 #panel .panel-button StLabel { padding: 0 2px 1px; }
 #panel .panel-button .popup-menu-arrow { width: 0; }
 #panel.unlock-screen .panel-corner, #panel.unlock-screen .panel-button, #panel.login-screen .panel-corner, #panel.login-screen .panel-button, #panel.lock-screen .panel-corner, #panel.lock-screen .panel-button { color: #ECEFF1; }
@@ -492,7 +492,7 @@ StScrollBar StButton#vhandle:active, StScrollBar StButton#hhandle:active { backg
 .search-provider-icon-more { width: 16px; height: 16px; background-image: url("assets/more-results.svg"); -st-background-image-shadow: 0 1px 3px rgba(0, 0, 0, 0.24), 0 1px 2px rgba(0, 0, 0, 0.48); }
 
 /************* Dashboard * ************/
-#dash { font-size: 9pt; padding: 4px 0; border: none; border-radius: 0; color: #30393e; background-color: rgba(36,51,59, 1); box-shadow: inset 0 0 0 rgbargba(36,51,59, 1); }
+#dash { font-size: 9pt; padding: 4px 0; border: none; border-radius: 0; color: #ECEFF1; background-color: rgba(19, 25, 28, 0.01); box-shadow: inset -1px 0 0 rgba(236, 239, 241, 0.2); }
 #dash:rtl { box-shadow: inset 1px 0 0 rgba(236, 239, 241, 0.2); }
 #dash .placeholder { background-image: url("assets/dash-placeholder.svg"); background-size: contain; height: 24px; }
 #dash .empty-dash-drop-target { width: 24px; height: 24px; }
@@ -501,55 +501,55 @@ StScrollBar StButton#vhandle:active, StScrollBar StButton#hhandle:active { backg
 
 .dash-label { padding: 4px 12px; border-radius: 2px; color: #ECEFF1; background-color: rgba(42, 55, 62, 0.9); box-shadow: 0 3px 4px rgba(0, 0, 0, 0.32), 0 3px 2px rgba(0, 0, 0, 0.24); text-align: center; -x-offset: 8px; }
 
-/* #dashtodockContainer #dash, #dashtodockContainer:overview #dash, #dashtodockContainer.extended #dash, #dashtodockContainer.extended:overview #dash { padding: 0; border-radius: 0; box-shadow: none; } */
-/* #dashtodockContainer.top:overview #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 0 -1px 0 rgba(236, 239, 241, 0.2); } */
-/* #dashtodockContainer.top #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 0 2px 0 #13191c; } */
-/* #dashtodockContainer.bottom:overview #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 0 1px 0 rgba(236, 239, 241, 0.2); } */
-/* #dashtodockContainer.bottom #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 0 -2px 0 #13191c; } */
-/* #dashtodockContainer.left:overview #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset -1px 0 0 rgba(236, 239, 241, 0.2); } */
-/* #dashtodockContainer.left #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 2px 0 0 #13191c; } */
-/* #dashtodockContainer.right:overview #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 1px 0 0 rgba(236, 239, 241, 0.2); } */
-/* #dashtodockContainer.right #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset -2px 0 0 #13191c; } */
-/* #dashtodockContainer .app-well-app-running-dot { background: transparent; } */
-/* #dashtodockContainer .app-well-app .overview-icon { padding: 7px; background-size: contain; } */
-/* #dashtodockContainer .show-apps .overview-icon { padding: 7px; } */
-/* #dashtodockContainer .dash-item-container > StWidget { margin: 2px; background-size: contain; } */
-
-/* #dashtodockContainer.top .dash-item-container > StWidget.running1, #dashtodockContainer.extended.top .dash-item-container > StWidget.running1 { background-image: url("assets/dot/running1-top.svg"); } */
-/* #dashtodockContainer.top .dash-item-container > StWidget.running1.focused, #dashtodockContainer.extended.top .dash-item-container > StWidget.running1.focused { background-image: url("assets/dot/running1-top-focused.svg"); } */
-/* #dashtodockContainer.top .dash-item-container > StWidget.running2, #dashtodockContainer.extended.top .dash-item-container > StWidget.running2 { background-image: url("assets/dot/running2-top.svg"); } */
-/* #dashtodockContainer.top .dash-item-container > StWidget.running2.focused, #dashtodockContainer.extended.top .dash-item-container > StWidget.running2.focused { background-image: url("assets/dot/running2-top-focused.svg"); } */
-/* #dashtodockContainer.top .dash-item-container > StWidget.running3, #dashtodockContainer.extended.top .dash-item-container > StWidget.running3 { background-image: url("assets/dot/running3-top.svg"); } */
-/* #dashtodockContainer.top .dash-item-container > StWidget.running3.focused, #dashtodockContainer.extended.top .dash-item-container > StWidget.running3.focused { background-image: url("assets/dot/running3-top-focused.svg"); } */
-/* #dashtodockContainer.top .dash-item-container > StWidget.running4, #dashtodockContainer.extended.top .dash-item-container > StWidget.running4 { background-image: url("assets/dot/running4-top.svg"); } */
-/* #dashtodockContainer.top .dash-item-container > StWidget.running4.focused, #dashtodockContainer.extended.top .dash-item-container > StWidget.running4.focused { background-image: url("assets/dot/running4-top-focused.svg"); } */
-
-/* #dashtodockContainer.bottom .dash-item-container > StWidget.running1, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running1 { background-image: url("assets/dot/running1-bottom.svg"); } */
-/* #dashtodockContainer.bottom .dash-item-container > StWidget.running1.focused, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running1.focused { background-image: url("assets/dot/running1-bottom-focused.svg"); } */
-/* #dashtodockContainer.bottom .dash-item-container > StWidget.running2, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running2 { background-image: url("assets/dot/running2-bottom.svg"); } */
-/* #dashtodockContainer.bottom .dash-item-container > StWidget.running2.focused, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running2.focused { background-image: url("assets/dot/running2-bottom-focused.svg"); } */
-/* #dashtodockContainer.bottom .dash-item-container > StWidget.running3, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running3 { background-image: url("assets/dot/running3-bottom.svg"); } */
-/* #dashtodockContainer.bottom .dash-item-container > StWidget.running3.focused, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running3.focused { background-image: url("assets/dot/running3-bottom-focused.svg"); } */
-/* #dashtodockContainer.bottom .dash-item-container > StWidget.running4, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running4 { background-image: url("assets/dot/running4-bottom.svg"); } */
-/* #dashtodockContainer.bottom .dash-item-container > StWidget.running4.focused, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running4.focused { background-image: url("assets/dot/running4-bottom-focused.svg"); } */
-
-/* #dashtodockContainer.left .dash-item-container > StWidget.running1, #dashtodockContainer.extended.left .dash-item-container > StWidget.running1 { background-image: url("assets/dot/running1-left.svg"); } */
-/* #dashtodockContainer.left .dash-item-container > StWidget.running1.focused, #dashtodockContainer.extended.left .dash-item-container > StWidget.running1.focused { background-image: url("assets/dot/running1-left-focused.svg"); } */
-/* #dashtodockContainer.left .dash-item-container > StWidget.running2, #dashtodockContainer.extended.left .dash-item-container > StWidget.running2 { background-image: url("assets/dot/running2-left.svg"); } */
-/* #dashtodockContainer.left .dash-item-container > StWidget.running2.focused, #dashtodockContainer.extended.left .dash-item-container > StWidget.running2.focused { background-image: url("assets/dot/running2-left-focused.svg"); } */
-/* #dashtodockContainer.left .dash-item-container > StWidget.running3, #dashtodockContainer.extended.left .dash-item-container > StWidget.running3 { background-image: url("assets/dot/running3-left.svg"); } */
-/* #dashtodockContainer.left .dash-item-container > StWidget.running3.focused, #dashtodockContainer.extended.left .dash-item-container > StWidget.running3.focused { background-image: url("assets/dot/running3-left-focused.svg"); } */
-/* #dashtodockContainer.left .dash-item-container > StWidget.running4, #dashtodockContainer.extended.left .dash-item-container > StWidget.running4 { background-image: url("assets/dot/running4-left.svg"); } */
-/* #dashtodockContainer.left .dash-item-container > StWidget.running4.focused, #dashtodockContainer.extended.left .dash-item-container > StWidget.running4.focused { background-image: url("assets/dot/running4-left-focused.svg"); } */
-
-/* #dashtodockContainer.right .dash-item-container > StWidget.running1, #dashtodockContainer.extended.right .dash-item-container > StWidget.running1 { background-image: url("assets/dot/running1-right.svg"); } */
-/* #dashtodockContainer.right .dash-item-container > StWidget.running1.focused, #dashtodockContainer.extended.right .dash-item-container > StWidget.running1.focused { background-image: url("assets/dot/running1-right-focused.svg"); } */
-/* #dashtodockContainer.right .dash-item-container > StWidget.running2, #dashtodockContainer.extended.right .dash-item-container > StWidget.running2 { background-image: url("assets/dot/running2-right.svg"); } */
-/* #dashtodockContainer.right .dash-item-container > StWidget.running2.focused, #dashtodockContainer.extended.right .dash-item-container > StWidget.running2.focused { background-image: url("assets/dot/running2-right-focused.svg"); } */
-/* #dashtodockContainer.right .dash-item-container > StWidget.running3, #dashtodockContainer.extended.right .dash-item-container > StWidget.running3 { background-image: url("assets/dot/running3-right.svg"); } */
-/* #dashtodockContainer.right .dash-item-container > StWidget.running3.focused, #dashtodockContainer.extended.right .dash-item-container > StWidget.running3.focused { background-image: url("assets/dot/running3-right-focused.svg"); } */
-/* #dashtodockContainer.right .dash-item-container > StWidget.running4, #dashtodockContainer.extended.right .dash-item-container > StWidget.running4 { background-image: url("assets/dot/running4-right.svg"); } */
-/* #dashtodockContainer.right .dash-item-container > StWidget.running4.focused, #dashtodockContainer.extended.right .dash-item-container > StWidget.running4.focused { background-image: url("assets/dot/running4-right-focused.svg"); } */
+#dashtodockContainer #dash, #dashtodockContainer:overview #dash, #dashtodockContainer.extended #dash, #dashtodockContainer.extended:overview #dash { padding: 0; border-radius: 0; box-shadow: none; }
+#dashtodockContainer.top:overview #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 0 -1px 0 rgba(236, 239, 241, 0.2); }
+#dashtodockContainer.top #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 0 2px 0 #13191c; }
+#dashtodockContainer.bottom:overview #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 0 1px 0 rgba(236, 239, 241, 0.2); }
+#dashtodockContainer.bottom #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 0 -2px 0 #13191c; }
+#dashtodockContainer.left:overview #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset -1px 0 0 rgba(236, 239, 241, 0.2); }
+#dashtodockContainer.left #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 2px 0 0 #13191c; }
+#dashtodockContainer.right:overview #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset 1px 0 0 rgba(236, 239, 241, 0.2); }
+#dashtodockContainer.right #dash { background-color: rgba(19, 25, 28, 0.01); box-shadow: inset -2px 0 0 #13191c; }
+#dashtodockContainer .app-well-app-running-dot { background: transparent; }
+#dashtodockContainer .app-well-app .overview-icon { padding: 7px; background-size: contain; }
+#dashtodockContainer .show-apps .overview-icon { padding: 7px; }
+#dashtodockContainer .dash-item-container > StWidget { margin: 2px; background-size: contain; }
+
+#dashtodockContainer.top .dash-item-container > StWidget.running1, #dashtodockContainer.extended.top .dash-item-container > StWidget.running1 { background-image: url("assets/dot/running1-top.svg"); }
+#dashtodockContainer.top .dash-item-container > StWidget.running1.focused, #dashtodockContainer.extended.top .dash-item-container > StWidget.running1.focused { background-image: url("assets/dot/running1-top-focused.svg"); }
+#dashtodockContainer.top .dash-item-container > StWidget.running2, #dashtodockContainer.extended.top .dash-item-container > StWidget.running2 { background-image: url("assets/dot/running2-top.svg"); }
+#dashtodockContainer.top .dash-item-container > StWidget.running2.focused, #dashtodockContainer.extended.top .dash-item-container > StWidget.running2.focused { background-image: url("assets/dot/running2-top-focused.svg"); }
+#dashtodockContainer.top .dash-item-container > StWidget.running3, #dashtodockContainer.extended.top .dash-item-container > StWidget.running3 { background-image: url("assets/dot/running3-top.svg"); }
+#dashtodockContainer.top .dash-item-container > StWidget.running3.focused, #dashtodockContainer.extended.top .dash-item-container > StWidget.running3.focused { background-image: url("assets/dot/running3-top-focused.svg"); }
+#dashtodockContainer.top .dash-item-container > StWidget.running4, #dashtodockContainer.extended.top .dash-item-container > StWidget.running4 { background-image: url("assets/dot/running4-top.svg"); }
+#dashtodockContainer.top .dash-item-container > StWidget.running4.focused, #dashtodockContainer.extended.top .dash-item-container > StWidget.running4.focused { background-image: url("assets/dot/running4-top-focused.svg"); }
+
+#dashtodockContainer.bottom .dash-item-container > StWidget.running1, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running1 { background-image: url("assets/dot/running1-bottom.svg"); }
+#dashtodockContainer.bottom .dash-item-container > StWidget.running1.focused, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running1.focused { background-image: url("assets/dot/running1-bottom-focused.svg"); }
+#dashtodockContainer.bottom .dash-item-container > StWidget.running2, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running2 { background-image: url("assets/dot/running2-bottom.svg"); }
+#dashtodockContainer.bottom .dash-item-container > StWidget.running2.focused, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running2.focused { background-image: url("assets/dot/running2-bottom-focused.svg"); }
+#dashtodockContainer.bottom .dash-item-container > StWidget.running3, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running3 { background-image: url("assets/dot/running3-bottom.svg"); }
+#dashtodockContainer.bottom .dash-item-container > StWidget.running3.focused, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running3.focused { background-image: url("assets/dot/running3-bottom-focused.svg"); }
+#dashtodockContainer.bottom .dash-item-container > StWidget.running4, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running4 { background-image: url("assets/dot/running4-bottom.svg"); }
+#dashtodockContainer.bottom .dash-item-container > StWidget.running4.focused, #dashtodockContainer.extended.bottom .dash-item-container > StWidget.running4.focused { background-image: url("assets/dot/running4-bottom-focused.svg"); }
+
+#dashtodockContainer.left .dash-item-container > StWidget.running1, #dashtodockContainer.extended.left .dash-item-container > StWidget.running1 { background-image: url("assets/dot/running1-left.svg"); }
+#dashtodockContainer.left .dash-item-container > StWidget.running1.focused, #dashtodockContainer.extended.left .dash-item-container > StWidget.running1.focused { background-image: url("assets/dot/running1-left-focused.svg"); }
+#dashtodockContainer.left .dash-item-container > StWidget.running2, #dashtodockContainer.extended.left .dash-item-container > StWidget.running2 { background-image: url("assets/dot/running2-left.svg"); }
+#dashtodockContainer.left .dash-item-container > StWidget.running2.focused, #dashtodockContainer.extended.left .dash-item-container > StWidget.running2.focused { background-image: url("assets/dot/running2-left-focused.svg"); }
+#dashtodockContainer.left .dash-item-container > StWidget.running3, #dashtodockContainer.extended.left .dash-item-container > StWidget.running3 { background-image: url("assets/dot/running3-left.svg"); }
+#dashtodockContainer.left .dash-item-container > StWidget.running3.focused, #dashtodockContainer.extended.left .dash-item-container > StWidget.running3.focused { background-image: url("assets/dot/running3-left-focused.svg"); }
+#dashtodockContainer.left .dash-item-container > StWidget.running4, #dashtodockContainer.extended.left .dash-item-container > StWidget.running4 { background-image: url("assets/dot/running4-left.svg"); }
+#dashtodockContainer.left .dash-item-container > StWidget.running4.focused, #dashtodockContainer.extended.left .dash-item-container > StWidget.running4.focused { background-image: url("assets/dot/running4-left-focused.svg"); }
+
+#dashtodockContainer.right .dash-item-container > StWidget.running1, #dashtodockContainer.extended.right .dash-item-container > StWidget.running1 { background-image: url("assets/dot/running1-right.svg"); }
+#dashtodockContainer.right .dash-item-container > StWidget.running1.focused, #dashtodockContainer.extended.right .dash-item-container > StWidget.running1.focused { background-image: url("assets/dot/running1-right-focused.svg"); }
+#dashtodockContainer.right .dash-item-container > StWidget.running2, #dashtodockContainer.extended.right .dash-item-container > StWidget.running2 { background-image: url("assets/dot/running2-right.svg"); }
+#dashtodockContainer.right .dash-item-container > StWidget.running2.focused, #dashtodockContainer.extended.right .dash-item-container > StWidget.running2.focused { background-image: url("assets/dot/running2-right-focused.svg"); }
+#dashtodockContainer.right .dash-item-container > StWidget.running3, #dashtodockContainer.extended.right .dash-item-container > StWidget.running3 { background-image: url("assets/dot/running3-right.svg"); }
+#dashtodockContainer.right .dash-item-container > StWidget.running3.focused, #dashtodockContainer.extended.right .dash-item-container > StWidget.running3.focused { background-image: url("assets/dot/running3-right-focused.svg"); }
+#dashtodockContainer.right .dash-item-container > StWidget.running4, #dashtodockContainer.extended.right .dash-item-container > StWidget.running4 { background-image: url("assets/dot/running4-right.svg"); }
+#dashtodockContainer.right .dash-item-container > StWidget.running4.focused, #dashtodockContainer.extended.right .dash-item-container > StWidget.running4.focused { background-image: url("assets/dot/running4-right-focused.svg"); }
 
 #dash:desktop { background-color: #2a373e; }
 
@@ -571,8 +571,8 @@ StScrollBar StButton#vhandle:active, StScrollBar StButton#hhandle:active { backg
 .app-well-app:hover .overview-icon, .app-well-app:focus .overview-icon, .app-well-app:selected .overview-icon, .app-well-app.app-folder:hover .overview-icon, .app-well-app.app-folder:focus .overview-icon, .app-well-app.app-folder:selected .overview-icon, .show-apps:hover .overview-icon, .show-apps:focus .overview-icon, .show-apps:selected .overview-icon, .grid-search-result:hover .overview-icon, .grid-search-result:focus .overview-icon, .grid-search-result:selected .overview-icon { border-image: none; background-color: rgba(236, 239, 241, 0.2); background-image: none; color: #ECEFF1; transition-duration: 0s; }
 .app-well-app:active .overview-icon, .app-well-app:checked .overview-icon, .app-well-app.app-folder:active .overview-icon, .app-well-app.app-folder:checked .overview-icon, .show-apps:active .overview-icon, .show-apps:checked .overview-icon, .grid-search-result:active .overview-icon, .grid-search-result:checked .overview-icon { background-color: #00BCD4; color: #ECEFF1; box-shadow: 0 0 transparent; transition-duration: 0.2s; }
 
-#dash .app-well-app .overview-icon, #dash .show-apps .overview-icon { border-radius: 5px; margin:2px; }
-#dash .app-well-app:hover .overview-icon, #dash .show-apps:hover .overview-icon { background-color: rgba(39,55,61, 1); transition-duration: 0.2s;}
+#dash .app-well-app .overview-icon, #dash .show-apps .overview-icon { border-radius: 100px; }
+#dash .app-well-app:hover .overview-icon, #dash .show-apps:hover .overview-icon { background-color: rgba(236, 239, 241, 0.12); }
 #dash .app-well-app:active .overview-icon, #dash .app-well-app:focus .overview-icon, #dash .app-well-app:checked .overview-icon, #dash .show-apps:active .overview-icon, #dash .show-apps:focus .overview-icon, #dash .show-apps:checked .overview-icon { background-color: #00BCD4; }
 
 .app-well-app-running-dot { width: 32px; height: 2px; background-color: #00BCD4; margin-bottom: 0; }
