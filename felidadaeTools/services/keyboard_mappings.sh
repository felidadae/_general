#!/bin/bash -e

# caps lock as enter
setxkbmap -option caps:none 
xmodmap -e 'keycode 66 = Return'    #caps lock as enter

# others
xmodmap -e 'keycode 73 = BackSpace' #F7
xmodmap -e 'keycode 74 = Tab' #F7
# xmodmap -e 'keycode 22 = NoSymbol'  #remove backspace as backspace to learn not to use that stupid shit
# xmodmap -e 'keycode 36 = NoSymbol'  #remove enter as enter to learn not to use that shit

#right alt and right super
xmodmap -e 'remove mod5 = ISO_Level3_Shift' 
xmodmap -e 'add shift = ISO_Level3_Shift'
xmodmap -e 'remove mod5 = ISO_Level3_Shift'  
xmodmap -e 'add shift = ISO_Level3_Shift' 
