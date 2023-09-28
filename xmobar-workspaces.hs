Config { font = "Inconsolata Nerd Font 8"
        , additionalFonts = [ "Monofur NF 8", "waffle 9", "rissole 12" ]
        , borderColor = "lightgreen"
--        , border = BottomB
        --, position = TopW L 95,
        , position = Static { xpos = 5 , ypos = 2, width = 261, height = 18 }
        , bgColor = "#111827" -- cool gray
        , fgColor = "#e5e4e2" -- platinum
        --, position = TopW L 100
        , commands = [ 
                      Run UnsafeStdinReader
                        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%UnsafeStdinReader%"
   }
