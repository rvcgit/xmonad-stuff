Config { font = "rissole Bold 8"
       , bgColor = "#111827"
       , fgColor = "#00ffff"
--       , position = TopW L 19 TopH 18 TopP 2 2
       , position = Static { xpos = 4 , ypos = 2, width = 265, height = 18 }
       , lowerOnStart = True
--       , commands = [ Run Weather "VASU" ["-t","<station>: <tempC>C","-L","18","-H","25","--normal","green","--high","red","--low","lightblue"] 36000
--                    , Run Network "eth0" ["-L","0","-H","32","--normal","green","--high","red"] 10
--                    , Run Network "eth1" ["-L","0","-H","32","--normal","green","--high","red"] 10
--                    , Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10
--                    , Run Memory ["-t","Mem: <usedratio>%"] 10
--                    , Run Swap [] 10
--                    , Run Com "uname" ["-s","-r"] "" 36000
--    		    , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
--                    ]
        , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader%"
       }
