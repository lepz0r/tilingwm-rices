-- copy to ~/.xmonad/xmonad.hs

import XMonad
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.SpawnOnce
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.SpawnOn (spawnOn)


modm = mod4Mask

main = xmonad $ docks $ ewmhFullscreen $ ewmh def
	{ terminal = "urxvt"
	, modMask = modm
	, focusFollowsMouse = False
	, borderWidth = 3
    	--, layoutHook=lessBorders OnlyScreenFloat $ smartBorders $ avoidStruts $ spacingRaw True (Border 4 4 4 4) True (Border 4 4 4 4) True $ layoutHook def
    	, layoutHook= lessBorders OnlyScreenFloat $ avoidStruts $ spacingRaw False (Border 2 4 4 4 ) True (Border 4 4 4 4) True $ layoutHook def
    	, manageHook=manageHook def <+> manageDocks
	, startupHook        = myStartupHook
	, normalBorderColor  = "#5a5475"
	, focusedBorderColor = "#ffb8d1"
	}
	`additionalKeys`
  	[ ((modm,            xK_p     	), spawn "rofi -show run")
	 ,((modm,            xK_g     	), spawn "xprop >> ~/xprop.log")
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
	spawnOnce "picom --experimental-backend"
	spawnOnce "hsetroot -cover ~/Pictures/92290065_p0-waifu2x.png"
	spawn "xrdb ~/.Xresources"
	spawnOnce "x11bell pw-play /usr/share/sounds/freedesktop/stereo/bell.oga"
	spawnOnce "polybar -r mainbar0"
	spawnOnce "dunst"
	spawnOnce "discord --start-minimized"
	spawnOnce "kdeconnect-indicator"
	spawnOnce "arch-audit-gtk"
	spawnOnce "ibus-daemon -drx"
	spawnOnce "autorestart-nfancurve"
	spawnOnce "xidlehook --not-when-fullscreen --not-when-audio --timer 1800 'systemctl suspend' ''"
	spawnOnce "env XSECURELOCK_SAVER=saver_xscreensaver XSECURELOCK_FONT='FiraMono Nerd Font' XSECURELOCK_PASSWORD_PROMPT='kaomoji' XSECURELOCK_SWITCH_USER_COMMAND='dm-tool switch-to-greeter' XSECURELOCK_AUTH_BACKGROUND_COLOR='#282828' XSECURELOCK_AUTH_FOREGROUND_COLOR='#ebdbb2' xss-lock -- xsecurelock"
