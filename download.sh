# This script automate the download of every subject of 42 school and commit it

IFS=$'\n' # make newlines the only seperator

file=projects.txt # the path of the file to extract data from

for i in $(cat $file); do # loop through each line
	if [ "$( echo $i | awk '{ print $1 }' )" = "#" ] # Check if it's a directory
	then
		DIR=$(echo $i | awk '{ print $2 }')
	    mkdir  -p $DIR # Create directories
	else
		SUBDIR=$(echo $i | awk '{ print $1 }')
		mkdir -p "$DIR/$SUBDIR" # Create subdirectories
		NF=$(echo $i | awk -v FS=" " "{ print NF }")
		#echo $NF $i
		for ((j=2 ; j <= NF ; j++)); do
		 	echo $i | awk -v j=$j '{ print $j }' | xargs wget --directory-prefix "$DIR/$SUBDIR"
		# 	# echo $i | awk '{ print $j }' # | xargs wget --directory-prefix "$DIR/$SUBDIR"
		done
	fi

done
