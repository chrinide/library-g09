#!/usr/bin/env python
## Modified by Rangsiman Ketkaew, Master student in computationl chemsitry
## Computational Chemistry Research Unit, Thammasat University, Thailand
## https://github.com/rangsimanketkaew
## 20170403 updated.
## Support only Python 2.x
##
## ------------------Usage---------------------
##   $ python script.py output.log  <enter>
## --------------------------------------------

import sys
import re
import numpy

start = 0
end = 0

filename = sys.argv[1]

## nutt: updated 03 March
newfile = str(filename) + ".final.opt.xyz"

openold = open(filename,"r")
opennew = open(newfile,"w")

rline = openold.readlines()

for i in range (len(rline)):
    if "Standard orientation:" in rline[i]:
        start = i

for m in range (start + 5, len(rline)):
    if "---" in rline[m]:
        end = m
        break

## Convert to Cartesian coordinates format
## convert atomic number to atomic symbol

for line in rline[start+5 : end] :
    words = line.split()
    word1 = int(words[1])
    word3 = str(words[3])

## Periodic table supported -------------------------

    if   word1 ==   1 : word1 = "H"
    elif word1 ==   2 : word1 = "He"
    elif word1 ==   3 : word1 = "Li"
    elif word1 ==   4 : word1 = "Be"
    elif word1 ==   5 : word1 = "B"
    elif word1 ==   6 : word1 = "C"
    elif word1 ==   7 : word1 = "N"
    elif word1 ==   8 : word1 = "O"
    elif word1 ==   9 : word1 = "F"
    elif word1 ==  10 : word1 = "Ne"
    elif word1 ==  11 : word1 = "Na"
    elif word1 ==  12 : word1 = "Mg"
    elif word1 ==  13 : word1 = "Al"
    elif word1 ==  14 : word1 = "Si"
    elif word1 ==  15 : word1 = "P"
    elif word1 ==  16 : word1 = "S"
    elif word1 ==  17 : word1 = "Cl"
    elif word1 ==  18 : word1 = "Ar"
    elif word1 ==  19 : word1 = "K"
    elif word1 ==  20 : word1 = "Ca"
    elif word1 ==  21 : word1 = "Sc"
    elif word1 ==  22 : word1 = "Ti"
    elif word1 ==  23 : word1 = "V"
    elif word1 ==  24 : word1 = "Cr"
    elif word1 ==  25 : word1 = "Mn"
    elif word1 ==  26 : word1 = "Fe"
    elif word1 ==  27 : word1 = "Co"
    elif word1 ==  28 : word1 = "Ni"
    elif word1 ==  29 : word1 = "Cu"
    elif word1 ==  30 : word1 = "Zn"
    elif word1 ==  31 : word1 = "Ga"
    elif word1 ==  32 : word1 = "Ge"
    elif word1 ==  33 : word1 = "As"
    elif word1 ==  34 : word1 = "Se"
    elif word1 ==  35 : word1 = "Br"
    elif word1 ==  36 : word1 = "Kr"
    elif word1 ==  37 : word1 = "Rb"
    elif word1 ==  38 : word1 = "Sr"
    elif word1 ==  39 : word1 = "Y"
    elif word1 ==  40 : word1 = "Zr"
    elif word1 ==  41 : word1 = "Nb"
    elif word1 ==  42 : word1 = "Mo"
    elif word1 ==  43 : word1 = "Tc"
    elif word1 ==  44 : word1 = "Ru"
    elif word1 ==  45 : word1 = "Rh"
    elif word1 ==  46 : word1 = "Pd"
    elif word1 ==  47 : word1 = "Ag"
    elif word1 ==  48 : word1 = "Cd"
    elif word1 ==  49 : word1 = "In"
    elif word1 ==  50 : word1 = "Sn"
    elif word1 ==  51 : word1 = "Sb"
    elif word1 ==  52 : word1 = "Te"
    elif word1 ==  53 : word1 = "I"
    elif word1 ==  54 : word1 = "Xe"
    elif word1 ==  55 : word1 = "Cs"
    elif word1 ==  56 : word1 = "Ba"
    elif word1 ==  57 : word1 = "La"
    elif word1 ==  58 : word1 = "Ce"
    elif word1 ==  59 : word1 = "Pr"
    elif word1 ==  60 : word1 = "Nd"
    elif word1 ==  61 : word1 = "Pm"
    elif word1 ==  62 : word1 = "Sm"
    elif word1 ==  63 : word1 = "Eu"
    elif word1 ==  64 : word1 = "Gd"
    elif word1 ==  65 : word1 = "Tb"
    elif word1 ==  66 : word1 = "Dy"
    elif word1 ==  67 : word1 = "Ho"
    elif word1 ==  68 : word1 = "Er"
    elif word1 ==  69 : word1 = "Tm"
    elif word1 ==  70 : word1 = "Yb"
    elif word1 ==  71 : word1 = "Lu"
    elif word1 ==  72 : word1 = "Hf"
    elif word1 ==  73 : word1 = "Ta"
    elif word1 ==  74 : word1 = "W"
    elif word1 ==  75 : word1 = "Re"
    elif word1 ==  76 : word1 = "Os"
    elif word1 ==  77 : word1 = "Ir"
    elif word1 ==  78 : word1 = "Pt"
    elif word1 ==  79 : word1 = "Au"
    elif word1 ==  80 : word1 = "Hg"
    elif word1 ==  81 : word1 = "Tl"
    elif word1 ==  82 : word1 = "Pb"
    elif word1 ==  83 : word1 = "Bi"
    elif word1 ==  84 : word1 = "Po"
    elif word1 ==  85 : word1 = "At"
    elif word1 ==  86 : word1 = "Rn"
    elif word1 ==  87 : word1 = "Fe"
    elif word1 ==  88 : word1 = "Ra"
    elif word1 ==  89 : word1 = "Ac"
    elif word1 ==  90 : word1 = "Th"

## Your sturcture should comprise the atom between 1-90 -----------------

## copy from atom list.

    print >>opennew, "%s%s" % (word1,line[30:-1])

openold.close()
opennew.close()

print "######################## Job Done ############################"
      
