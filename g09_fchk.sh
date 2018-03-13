#!/bin/bash

cd .
for f in *chk
formchk $f
done
echo "Transform done"

mkdir ./ori_chk
wait
mv *.chk ./ori_chk
wait
echo "Move done"
