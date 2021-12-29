-- requires xmonad 0.17 & xmonad-contrib 0.17

import XMonad
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.SpawnOnce
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import Graphics.X11.ExtraTypes.XF86

modm = mod4Mask

main = xmonad $ docks $ ewmhFullscreen $ ewmh def
	{ terminal = "kitty"
	, modMask = modm
	, focusFollowsMouse = False
	, borderWidth = 3
    	--, layoutHook=lessBorders OnlyScreenFloat $ smartBorders $ avoidStruts $ spacingRaw True (Border 4 4 4 4) True (Border 4 4 4 4) True $ layoutHook def
    	, layoutHook= lessBorders OnlyScreenFloat $ avoidStruts $ spacingRaw False (Border 4 4 4 4) True (Border 4 4 4 4) True $ layoutHook def
    	, manageHook=manageHook def <+> manageDocks
	, startupHook        = myStartupHook
	, normalBorderColor  = "#282828"
	, focusedBorderColor = "#fe8019"
	}
	`additionalKeys`
  	[ ((modm,            xK_p     	), spawn "rofi -show run")
  	 ,((0,               xK_Print 	), spawn "import -window root ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H:%M:%S).png")
  	 ,((0,               xF86XK_AudioRaiseVolume 	), spawn "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +4%")
  	 ,((0,               xF86XK_AudioLowerVolume 	), spawn "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -5%")
  	 ,((0,               xF86XK_AudioMute 		), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  	 ,((0,               xF86XK_AudioPlay 		), spawn "playerctl play-pause")
  	 ,((0,               xF86XK_AudioPause 		), spawn "playerctl pause")
  	 ,((0,               xF86XK_AudioPrev		), spawn "playerctl previous")
  	 ,((0,               xF86XK_AudioNext		), spawn "playerctl next")
	 ,((modm, 	     xK_Escape), spawn "loginctl lock-session")
	]

-- Startup
myStartupHook = do
	spawnOnce "picom"
	spawnOnce "hsetroot -cover ~/Downloads/91124215_p0.png"
	spawn "xrdb ~/.Xresources"
	spawnOnce "polybar -r mainbar0"
	spawnOnce "dunst"
	spawnOnce "discord --start-minimized"
	spawnOnce "kdeconnect-indicator"
	spawnOnce "ibus-daemon -drx"
	spawnOnce "xidlehook --not-when-fullscreen --not-when-audio --timer 1800 'systemctl suspend' ''"
	spawnOnce "env XSECURELOCK_SAVER=saver_xscreensaver XSECURELOCK_SWITCH_USER_COMMAND='dm-tool switch-to-greeter' xss-lock -- xsecurelock"
