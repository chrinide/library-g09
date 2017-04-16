#!/bin/bash

cd ./

read file1
for f in file1
do
 echo "Processing generate cube file from $f"
 wait
 cubegen 0 mo=homo $f {$f}.cub 0 h
 wait
 mv {f1}.fchk.cub {f1}.cub
done

echo "----- Job Done -----"
