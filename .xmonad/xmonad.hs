import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Util.EZConfig
import System.Exit
import Graphics.X11.Xlib
import System.IO


-- actions
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import qualified XMonad.Actions.Search as S
import XMonad.Actions.Search
import qualified XMonad.Actions.Submap as SM

-- utils
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.Prompt          as P
import XMonad.Prompt.Shell
import XMonad.Prompt


-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.FadeInactive

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.IM
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Grid

import Control.Monad (liftM2)

import XMonad.Hooks.ICCCMFocus

-- Data.Ratio for IM layout
import Data.Ratio ((%))

--import List

import qualified XMonad.Hooks.ManageHelpers as HMH

isKDEOverride = do
    isover <- HMH.isInProperty "_NET_WM_WINDOW_TYPE" "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE"
    isfs <- HMH.isFullscreen
    return $! isover && (not isfs)

myLayoutHook = avoidStruts $  onWorkspace "5:im" (withIM (1%7) (Title "Buddy List") Grid) $ smartBorders (resizableTile ||| Mirror resizableTile ||| Full)
    where
      resizableTile = ResizableTall nmaster delta ratio []
      nmaster = 1
      ratio = toRational (2/(1+sqrt(5)::Double))
      delta = 3/100

myManageHook = composeAll . concat $
               [[ HMH.composeOne [ isKDEOverride HMH.-?> doFloat ] ]
                ,[isFullscreen                          --> doFullFloat
                , className =? "OpenOffice.org 3.1"    --> viewShift "6:office"
                , className =? "Xmessage"              --> doCenterFloat
                , className =? "Pidgin"                --> viewShift "5:im"
                , className =? "Emacs"                 --> viewShift "2:text"
                , className =? "Shiretoko"             --> viewShift "1:web"
                , className =? "Chromium-browser"      --> viewShift "1:web"
                , className =? "Konsole"               --> viewShift "3:console"
                , className =? "Mail"                  --> viewShift "4:mail"
		]
                , [className =? c --> doFloat          | c <- myFloats]
                ]

                where
                        myIgnores = ["trayer"]
                        myFloats  = ["Tilda"]
                        myOtherFloats = []
                        viewShift = doF . liftM2 (.) W.greedyView W.shift

myWorkspaces = ["1:web", "2:text", "3:console", "4:mail", "5:im", "6:office", "7:media", "8:misc", "9:misc"]

myKeys =  [
           ("M-S-l", spawn "xscreensaver-command --lock")
          ]
          ++
          [
           (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
               | (key, scr)  <- zip "wer" [0,1,2] -- was [0..] *** change to match your screen order ***
               , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
          ]

myUrgencyHook = NoUrgencyHook

myConfig = defaultConfig
        { manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ smartBorders $ myLayoutHook
        , startupHook = return () >> checkKeymap myConfig myKeys
        , modMask = mod4Mask     -- Rebind Mod to the Caps Lock key
        , workspaces = myWorkspaces
        , terminal = "konsole"
        }
        `additionalKeysP` myKeys

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar $HOME/.xmobarrc"
    konsole <- spawnPipe "/usr/bin/konsole"
    xmonad $ withUrgencyHook myUrgencyHook $ myConfig
        { logHook = do
            (dynamicLogWithPP $ xmobarPP
                { ppOutput = hPutStrLn xmproc
                , ppTitle = xmobarColor "gray" "" . shorten 100
                , ppUrgent = xmobarColor "yellow" "red" . myXmobarStrip
                }) >> fadeInactiveLogHook 0xdddddddd
            takeTopFocus
        }

-- Helpers

-- | Strip xmobar markup.
myXmobarStrip :: String -> String
myXmobarStrip = strip [] where
    strip keep x
      | null x                 = keep
      | "<fc="  `isPrefixOf` x = strip keep (drop 1 . dropWhile (/= '>') $ x)
      | "</fc>" `isPrefixOf` x = strip keep (drop 5  x)
      | '<' == head x          = strip (keep ++ "<") (tail x)
      | otherwise              = let (good,x') = span (/= '<') x
                                 in strip (keep ++ good) x'
