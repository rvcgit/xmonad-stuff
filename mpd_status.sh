#!/usr/bin/env bash

# Define the iconic font

i='' i_fa_music=$i
i='' i_fa_backward=$i
i='' i_fa_play=$i
i='' i_fa_pause=$i
i='' i_fa_stop=$i
i='' i_fa_forward=$i
i='' i_fa_temp=$i
i='' i_fa_mem=$i

dzen_fg=#fff5ee
dzen_bg=#1a1110

# Directory for temperary files 
TMP="/tmp/simplepanel"

# update interval
UPD_INT=3

SP="%{O4}"		# small space

# define cmd and other functions used in the mpd module

rofi_cmd() {	# 1 parameter: menu_width. The rest of parameters is passed to rofi
	menu_width="$1"	# width in pixels
	shift
	eval "$(xdotool search --limit 1 --maxdepth 0 --class '' getwindowgeometry --shell)"	# get screen size
	eval "$(xdotool getmouselocation --shell)"

	if [ $X -lt $(( $WIDTH - $menu_width )) ] ; then
		x_anchor="west"
	else
		x_anchor="east"
		X="$WIDTH"
	fi

	if [ "$SP_BOTTOM" ] ; then	# panel at the bottom
		y_anchor="south"
		Y="$(( $HEIGHT - $SP_HEIGHT ))"
	else				# panel at the top
		y_anchor="north"
		Y="$SP_HEIGHT"
	fi

	rofi $@ \
		-i \
		-no-custom \
		-theme-str "
			#window {
				location: northwest;
				anchor: $y_anchor$x_anchor;
				x-offset: $X;
				y-offset: $Y;
				width: $menu_width;
				}
			#listview {
				fixed-height: false;
				scrollbar: false;
			}"
}

print_module() {	# 2 parameters: module_index module_string
	IFS='
	'
	line="$1:"
	for i in $2; do
		line="$line$i"
	done
	echo "$line"
}


print_status_module() {	# 1 parameter: module_string
	IFS='
	'
	line=""
	for i in $1; do
		line="$line$i"
	done
	echo "$line"
}

update_now() {	# 1 parameter: module_index
	echo "$1" > "${TMP}/update_status_now"
}

toggle_flag() {	# 1 parameter: flag_name
	if [ -f "${TMP}/${1}" ] ; then
		rm "${TMP}/${1}"
	else
		touch "${TMP}/${1}"
	fi
}

check_flag() {	# 1 parameter: flag_name
	[ -f "${TMP}/${1}" ]
}


# mpd panel module

mpd_hide_song_toggle() {
	toggle_flag "mpd_hide_song"
	mpc sendmessage update now
}

mpd_menu() {
	mpc playlist \
	| rofi_cmd 400 -format d -dmenu -p "Play:" \
	| xargs mpc play
}

sp_mpd() {
	ICON_MPD="${SP}${i_fa_music}${SP}"
	ICON_PREV=" ${i_fa_backward}"
	ICON_NEXT=" ${i_fa_forward}"
	ICON_PLAY=" ${i_fa_play}%{O1}"
	ICON_PAUSE=" ${i_fa_pause}"
	MAX_LENGTH=20

	pkill -x mpc >/dev/null 2>&1	# prevent spawning mpc on panel restart

	while true ; do
		if mpc > /dev/null 2>&1 ; then	# check if mpd is running
			echo "start"				# force update on panel start
			mpc idleloop player &		# get updates on player events
			while mpc waitmessage update ; do true ; done	# get updates on messages
		fi \
		| while read line ; do
			if check_flag "mpd_hide_song" ; then
				song="…"
			else
				song="$(mpc current)"
				if [ ${#song} -gt $MAX_LENGTH ] ; then	# trim long names
					song="$(echo $song|cut -c -$MAX_LENGTH)…"
				fi
			fi
			state="$(mpc|sed -n '2s/ .*$//p')"
			if [ "$state" = "[playing]" ] ; then
				icon_toggle="$ICON_PAUSE"
			else
				icon_toggle="$ICON_PLAY"
			fi

			print_module "$1" \
				"%{A1:mpd_hide_song_toggle:}
					%{A3:mpd_menu:}
						$ICO$ICON_MPD
						$TXT$song
					%{A3}
				%{A1}
				%{A1:mpc prev:}
					$ICO$ICON_PREV
				%{A1}
				%{A1:mpc toggle:}
					$icon_toggle
				%{A1}
				%{A1:mpc next:}
					$ICON_NEXT
				%{A1}"
		done
		# mpd does not respond, show (re)start button
		button	"$1" \
			"1" \
			"killall -q mpd mpc; mpd" \
			"$ICON_MPD" \
			"(re)start mpd"
		until mpc > /dev/null 2>&1 ; do	# wait until mpd starts
			sleep $UPD_INT
		done
	done
} 

echo $sp_mpd

