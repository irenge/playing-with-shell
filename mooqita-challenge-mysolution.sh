#!/bin/bash

>file
siz=0
# Create a series of random numbers and strings of characters and write them to a file, no more than 15 characters for each line. As characters assume the Latin Alphabet, [A-Za-z], without special characters and the numbers 0,1,2,3,4,5,6,7,8,9.
while [ $siz -le 1024000 ] ; #Control the size of the file. If the file reaches the size of 1 MiB interrupt the creation of more random lines.
do
	echo $(< /dev/urandom tr -dc A-Z-a-z0-9 | head -c${1:-15};echo) >> file # create a randome series using urandom because it faster option, tr replace the created string with letter and integer, head take only 15 characters of the string , echo ensure there is a return to the first line it s like pressing enter key
	siz=$(ls -l file | awk -F ' ' '{print $5}') # ls l gives some characteristics of the file awk ensure to select only the size from the column 5
done

sort file | uniq > file1 # sort the file in alaphabetic order 

# remove all lines that start with a small or capital letter 'a'
grep -vi ^a file1 >file2

# calculate how many files removed
dif=$(diff file1 file2 | grep '<'| wc -l)

echo "$dif lines was removed when removing the word starting with letter 'a'"
echo "The file size is now `du -sh --block-size M file`"
