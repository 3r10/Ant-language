#!/bin/sh

for file in samples/*.ant
do
  echo $file
  output=`echo $file | rev | cut -c 5- | rev`.s
  ./antcc < $file > $output
done
