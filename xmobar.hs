Config { font = "FiraCode Nerd Font 6.5"
        , additionalFonts = [ "Monofur NF 9", "waffle 9", "rissole 12" ]
        , borderColor = "#b6fffe" --prev springgreen, current flourescent blue
        , border = BottomB
        --, position = TopW L 95,
        , position = Static { xpos = 9 , ypos = 1, width = 1346, height = 19 }
        , bgColor = "#111827" -- cool gray
        , fgColor = "#e5e4e2" -- platinum
        --, position = TopW L 100
        , commands = [ --Run Weather "VASU" ["-t","<tempC>°C ","-L","19","-H","38",
                       --                   "--normal","#8ae234","--high","#ef2929","--low","#8cc4ff"] 3600
                        Run Com "/home/rvc/scripts/openweather" ["-s", "-L","19","-H","38",
                                                                 "--normal","lightcyan","--high","crimson","--low","azure"] "weather" 1500
--                        , Run Network "wlp6s0" ["-t","<rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10
--                      , Run Com "/home/rvc/scripts/netinfo.sh" [] "netinfo" 50
                        , Run Com "/home/rvc/bin/wifi-status" [] "wifi" 20
                        , Run Com "/home/rvc/.xmonad/get_vol.sh" [] "vol" 10
--                        , Run MultiCpu ["-t", "<autototal>", "-p", "2", "-L","10","-H","50","--normal","#8ae234","--high","#ef2929"] 10
                        , Run Memory ["-t","<usedratio>%"] 10
                        --, Run Swap [] 10
                        --, Run Com "uname" ["-r"] "" 36000
                        , Run Date "%a,%_d %b; %H:%M:%S" "date" 10
                       , Run MPD ["-t", " <fc=greenyellow> </fc> <title>... ","-w", "20", "-c", "  "] 10
--			, Run PipeReader "/tmp/.volume-pipe" "vol_pipe"
--			, Run PipeReader "/tmp/.mpd-pipe" "mpd_pipe"
                      , Run Com "/home/rvc/.xmonad/mpdstatus" [] "mpdstatus" 10
--                        , Run UnsafeStdinReader
                        , Run CoreTemp ["-t", "<core0>°C & <core1>°C",
                                    "-L", "40", "-H", "60",
                                    "-l", "lightblue", "-n", "gold", "-h", "crimson"] 20
                        , Run Battery [
                    "-t", "<acstatus> , <left>% - <timeleft>",
                    "--",
                    --"-c", "charge_full",
                    "-O", "AC",
                    "-o", "Bat",
                    "-h", "green",
                    "-l", "red"
                    ] 10
                    , Run UnsafeStdinReader
                        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%UnsafeStdinReader% }{<fc=slateblue>[ </fc><fc=dodgerblue>  </fc><fc=plum>%mpdstatus%</fc> <fc=olivedrab>*</fc> <fc=lightseagreen>  </fc>%battery% <fc=olivedrab>*</fc> <fc=salmon> </fc>%coretemp% <fc=olivedrab>*</fc> <fc=limegreen> </fc>%memory% <fc=olivedrab>*</fc> <fc=forestgreen>%wifi%</fc><fc=olivedrab>*</fc> <fc=dodgerblue>  </fc>%vol% <fc=olivedrab>*</fc> <fc=hotpink> </fc><fc=yellowgreen>%weather%</fc>; <fc=springgreen>%date%</fc> <fc=slateblue>]</fc>                 "
   }
