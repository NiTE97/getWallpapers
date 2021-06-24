#!/bin/bash

#Method declarations
function createDirs(){
	for (( i = 0; i < 30; i++ )); do
		if [ ! -d "$dir$i" ]; then
			dir=${dir}${i}
			mkdir -p "$dir";
			cd "$dir" || exit;
			break;
		fi
	done
}

function usage(){
	echo "Usage: getWallpaper.sh TOPIC [-r]";
	exit 1;
}

parseArguments(){
	if [[ $1 == '' ]]; then
		echo "Looking for random wallpapers...";
		createDirs;
	elif [[ $1 == '-r' ]]; then
		echo "Looking for random wallpapers and rotating them...";
		createDirs;
		rotate="true"
	elif [[ $2 == '-r' ]]; then
		topic=$1;
		echo "Looking for $topic wallpapers and rotating them..."
		link=${link}"?"$topic;
		mkdir -p "$dir""$topic";
		cd "$dir""$topic" || exit;
		rotate="true"
	elif [[ $1 == '--help' ]]; then
		usage;
	else
		topic=$1;
		echo "Looking for $topic wallpapers...";
		link=${link}"?$topic";
		mkdir -p "$dir""$topic";
		cd "$dir""$topic" || exit;
		
	fi
}

#Variables for target directory and unsplash link
link="https://source.unsplash.com/random/"
dir="/home/${USER}/Documents/Wallpapers/"
rotate="false"

#Check if Arguments are valid
parseArguments "$1" "$2";

#Create imgsid array
declare -A imgsid

for (( i = 0; i < 30; i++ )); do
	echo "$i / 29;"

    #Get download link and picture id
	dllink=`curl -s $link | grep -oP 'href="\K[^"]+' | sed -e 's/\(ixlib.*\)*$//g'`
	id=`echo "$dllink" | sed -n 's:.*photo\-\(.*\)?.*:\1:p'`

    #If array "knows" the id continue, else add it into the array
	if [[ "${imgsid[@]}" =~ "${id}" ]]; then
        continue
    else
	    imgsid[$i]=$id
    fi

	wget -q -O "$i.jpg" -P "$dir$topic" "$dllink$";
	
	if [[ $rotate == 'true' ]]; then
		width=$(identify -format '%w' "$dir$topic/$i.jpg");
		height=$(identify -format '%h' "$dir$topic/$i.jpg");

		if [[ $width -lt $height ]]; then
			convert "$dir$topic/$i.jpg" -rotate 90 "$dir$topic/$i.jpg";	
		fi
	fi
done

