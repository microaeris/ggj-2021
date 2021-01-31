#!/usr/bin/env sh

INPUT=$1
BASE=`echo $INPUT | cut -f1 -d"."`
OGG=$BASE.ogg
echo Converting...
ffmpeg -hide_banner -loglevel panic -y -i $1 -strict -2 -acodec vorbis -ac 2 -aq 50 $OGG
echo Wrote $OGG
