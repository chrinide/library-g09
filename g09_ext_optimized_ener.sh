#!/bin/bash

cd /home/$USER/
mkdir -r extract_energy
cd ./extract_energy

for logfile in *.log; do
 echo ${logfile}
 sed -n '/SCF Done/{n;p;}' ${logfile}
 printf "------------------------------------------\n" > ${logfile}_extracted_energy
 echo '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n' > ${logfile}_extracted_energy
done
echo 'Jobe done'
