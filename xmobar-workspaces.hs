Config { font = "rissole Bold 8"
       , bgColor = "#111827"
       , fgColor = "#00ffff"
--       , position = TopW L 19 TopH 18 TopP 2 2
       , position = Static { xpos = 4 , ypos = 2, width = 265, height = 18 }
       , lowerOnStart = True

--                    ]
        , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader%"
       }
