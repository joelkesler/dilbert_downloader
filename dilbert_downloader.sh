#!/bin/sh

# Inspired by https://github.com/ondrg/dilbert-downloader



# Edit the variables below to choose your the dates you wish to download

date_start='2015-01-01' # FYI the first comic was in 1989-04-16
date_end="2016-01-01"
url='http://dilbert.com'


START=`date -j -f %Y-%m-%d:%H.%M $date_start:0.0 +%s`
END=`date -j -f %Y-%m-%d:%H.%M $date_end:0.0 +%s`
for (( i=$START; i<=$END; i+=86400 )); do # seconds/day
		
	date_current=$(date -j -f %s "$i" +%Y-%m-%d)
	echo $date_current
	echo " "
	
	if [ ! -f "dilbert_${date_current}.gif" ]; then
		link=$(wget -q -O - ${url}/strip/${date_current} | grep 'comic-item-container' | sed 's/^\(.*\) data-image="//;s/" data-date=\(.*\)$//;')
		wget -nv -O "dilbert_${date_current}.gif" "$link" 2>&1
		echo " "
	fi
	
done;  


exit 0
doi
