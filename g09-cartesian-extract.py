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
