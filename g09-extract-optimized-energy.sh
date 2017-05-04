#!/bin/bash

for file in *.log
do
 echo ${file}
 sed -n '/SCF D/{n;p;}' ${file}
 printf "######################\n" > ${file}.Min.Energy
done
echo 'Jobe done'
