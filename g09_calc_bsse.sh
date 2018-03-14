#!/bin/bash
# Written by Rangsiman Ketkaew, CompChem TU, June, 2017
# Usage: $ chmod +x ./calc_bsse.sh
#      : $ ./calc_bsse.sh
# or use the executable file:
#        $ chmod +x ./g09_calc_bsse
#        $ ./g09_calc_bsse

echo "
 ---------------------------------------------------------------
      .. Basis Set Superposition Error (BSSE) Analysis ..

 + Rangsiman Ketkaew
   Computational Chemistry Research Unit (CCRU)
   Department of Chemistry, Faculty of Science and Technology
   Thammasat University, Thailand

 + website: github.com/rangsimanketkaew/library-g09
   E-mail: rangsiman1993@gmail.com

 + v.1.2.0 : supports gaussian output file
   v.1.2.1 : save results as txt file
   v.1.3.1 : supports orca & q-chem output files
   v.1.3.2 : Automatically search BSSE output file
 ---------------------------------------------------------------
"
read -p "Please Enter ... "

clear

echo "Enter the program that you used: 
     Gaussian = 1
     ORCA     = 2
     Q-Chem   = 3"
read -p "Which program did you use ?: " number
if [ $number == 1 ]; then
echo "=> You chose Gaussian"
elif [ $number == 2 ]; then
echo "=> You chose ORCA"
elif [ $number == 3 ]; then
echo "=> You chose Q-Chem"
else
echo "=> Your answer is not correct.
   ... Bye Bye ..."
exit
fi

read -p "Enter Your Gaussian Output (ex. water.out): " file
echo "=> You submitted $file"
who=`whoami`
node=`hostname`
now=`date`
where=`pwd`

if [ -e $file ]; then
	if [ -n "`grep "Normal termination" $file`" ]; then

echo "
---------------------------------------- BSSE Energy Extraction -----------------------------------------
Run by $who at $node on $now
---------------------------------------------------------------------------------------------------------
" > $where/results.BSSE.$file.txt
#echo "We are at $where"
#for f in `find ./ -name "*bsse*.log"`
bs=`grep 'Standard basis' $file|tail -1`
	for f in $file; do
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
	echo "Congrats!!! Please check this file ==> results.BSSE.$file.txt"

	else
		echo "Error in your gaussian output file. Make sure that you've entered a correct file."
	fi

else
	echo "Oops!!! File $file does not exist."
fi

