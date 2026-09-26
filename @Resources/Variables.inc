[Variables]
; -------------------------------------------------------------------
; FluentTaskbarWidget - Minimalist Taskbar Media & Audio Visualizer
; -------------------------------------------------------------------

; === Scale / Size Controller ===
; Scales the overall widget (1.0, 1.15, 1.25, 1.35, 1.5)
Scale=1.15

; === PFP Anime GIF Size Ratio ===
; Higher number makes the GIF bigger in ratio to text (Default: 38)
PfpBaseSize=38
PfpRadius=7
GifTotalFrames=50

; === Taskbar Positioning ===
; Right (before WiFi / Tray) or Left (Start / Widgets)
TaskbarPosition=Right
TaskbarRightOffset=250
TaskbarLeftOffset=20
TaskbarBottomMargin=2

; === Background & Theme ===
; 1 = 100% Transparent, 0 = Frosted Glass
TransparentMode=1
BgColor=0,0,0,1
BorderColor=0,0,0,0
FrostedBgColor=18,18,24,140
FrostedBorderColor=255,255,255,22

; === Typography & Text Colors ===
FontFace=Segoe UI Variable Display
FontFaceText=Segoe UI Variable Text
TextColorPrimary=255,255,255,255
TextColorSecondary=175,175,185,210

; Idle Display Text (Shown when no track is playing)
IdleTitle=Nothing Playing
IdleArtist=Windows Audio

; === Visualizer Colors (White or Black) ===
BarTheme=White
BarColor=255,255,255,240

; === AudioLevel FFT Settings ===
FFTSize=1024
FFTOverlap=512
FFTAttack=18
FFTDecay=130
Sensitivity=40
FreqMin=40
FreqMax=16000

; === Media Player Settings ===
PlayerType=CAD
UseWebNowPlaying=1

; === SMTC Windows Fallback Values ===
SMTCTitle=Nothing Playing
SMTCArtist=Windows Audio
SMTCActive=0
