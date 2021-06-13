#!/bin/bash

link="https://source.unsplash.com/random/?"
dir="/home/${USER}/Documents/Wallpapers/"

topic=$1

mkdir $dir$topic
cd $dir$topic

if [[ $topic == '' ]]; then
	echo "Usage: ./getWallpaper.sh TOPIC [-r]"
	exit 1
fi

for (( i = 0; i < 30; i++ )); do
	echo "$i / 29"
	wget -q -O "$i.jpg" -P "$dir$topic" "$link$topic"
	
	if [[ $2 != '-r' ]]; then
		width=$(identify -format '%w' "$dir$topic/$i.jpg")
		height=$(identify -format '%h' "$dir$topic/$i.jpg")

		if [[ $width -lt $height ]]; then
			convert "$dir$topic/$i.jpg" -rotate 90 "$dir$topic/$i.jpg"	
		fi
	fi
done
