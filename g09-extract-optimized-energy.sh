#!/bin/bash
# Extract energy from gaussian output with Searching keyword "SCF D"
for out in *0.out
do
 echo $out
 sed -n '/SCF D/{n;p;}' $out
 # print all energy convereged
 printf "--------\n" > {$out}.energy
 
done
echo 'Jobe done'
