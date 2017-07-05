#!/bin/bash
# Written by Rangsiman Ketkaew, CompChem TU, June, 2017
# Usage: $ chmod +x ./calc_bsse.sh
#      : $ ./calc_bsse.sh

read -p "Enter Your Gaussian Output: " file
who=`whoami`
node=`hostname`
now=`date`
where=`pwd`

if [ -e $file ]; then
echo "
---------------------------------------- BSSE Energy Extraction -----------------------------------------
Run by $who at $node on $now
---------------------------------------------------------------------------------------------------------
" > $where/results.BSSE.$file.txt
#echo "We are at $where"
#for f in `find ./ -name "*bsse*.log"`
bs=`grep 'Standard basis' $file|tail -1`
for f in $file
	do
		echo "File Name: $f   $bs" >> $where/results.BSSE.$file.txt
		E_AB_AB=`grep 'SCF D' $f | awk '{print $5}'|tail -5|sed -n '1p'`
		E_AB_A=`grep 'SCF D' $f | awk '{print $5}'|tail -5|sed -n '2p'`
		E_AB_B=`grep 'SCF D' $f | awk '{print $5}'|tail -5|sed -n '3p'`
		E_A_A=`grep 'SCF D' $f | awk '{print $5}'|tail -5|sed -n '4p'`
		E_B_B=`grep 'SCF D' $f | awk '{print $5}'|tail -5|sed -n '5p'`
		echo -e "E(AB|AB)  =  $E_AB_AB  A.U.\n" \
			"E(AB|A)  =  $E_AB_A  A.U.\n" \
			"E(AB|B)  =  $E_AB_B  A.U.\n" \
			"E(A|A)   =  $E_A_A  A.U.\n" \
			"E(B|B)   =  $E_B_B  A.U." >> $where/results.BSSE.$file.txt
		deltaE_bsse=`echo $E_AB_AB - $E_AB_A - $E_AB_B | bc -l` ; deltaE_bsse_con=`expr $deltaE_bsse*627.503 | bc -l`
		deltaE_norm=`echo $E_AB_AB - $E_A_A - $E_B_B |bc -l` ; deltaE_norm_con=`expr $deltaE_norm*627.503 | bc -l`
		cp_bsse=`echo $deltaE_bsse - $deltaE_norm | bc -l` ; cp_bsse_con=`expr $cp_bsse*627.503 | bc -l`
		echo "Diff Energy with BSSE     =  E(AB|AB) - E(AB|A) - E(AB|B) =  $deltaE_bsse  A.U.  =  $deltaE_bsse_con  kcal/mol" \
		>> $where/results.BSSE.$file.txt
		echo "Diff Energy without BSSE  =  E(AB|AB) - E(A|A) - E(B|B)   =  $deltaE_norm  A.U.  =  $deltaE_norm_con  kcal/mol" \
		>> $where/results.BSSE.$file.txt
		echo "Counterpoise BSSE = $cp_bsse  A.U.  =  $cp_bsse_con  kcal/mol" \
		>> $where/results.BSSE.$file.txt
		#echo $E_AB_AB - $E_AB_A - $E_AB_B | bc -l
		echo -e "---------------------------------------------------------------------------------------------------------\n" \
		>> $where/results.BSSE.$file.txt
	done
	echo "Congrats !!! Please check file results.BSSE.$file.txt"

else
	echo "Error !!! File $file does not exist."
fi

