# getWallpapers
Script to download random Wallpapers based on a specified search term.

## Installation

git clone https://github.com/NiTE97/getWallpapers
cd getWallpapers
./getWallpapers.sh

##Usage

./getWallpapers.sh [topic] [-r]

	topic: Search for specified topic
	-r:    Rotate images to landscape

Images are stored in ~/Documents/Wallpapers/

###Notes
Images are downloaded from unsplash.com. Unfortunately I haven't found an easy way to prevent downloading the same image multiple times. I found depending on your search term it happes more or less often. So you have to manually go through your images and look for duplicates if it bothers you.
