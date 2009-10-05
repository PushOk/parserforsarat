#!/bin/sh

cd /home/pushok/www/sarat/littmanbros/
rm index.html*
rm clear.*
rm tmpdata.*
rm -r ./tmp

wget http://www.littmanbros.com/
unix2dos index.html
#recode UTF-8/..CP-1251 index.html
tr '\r' '\n' < index.html > conv.index.html
rm index.html
mv conv.index.html index.html

cat index.html | ./crop.pl
cat clear.data.txt | ./read.cats.pl
mkdir tmp
cp urls.txt ./tmp
cd ./tmp
#wget -i ./urls.txt
for i in $(seq 1 2 100)
do
wget "http://www.littmanbros.com/mm5/merchant.mvc?Screen=SEARCH&Store_Code=LBL&Sort=&Search=+&filters[4]=&Page=$i" -Oproduct.list$i.html
done
for file in `ls -1 *.html`;do  `tr '\r' '\n' < $file > $file.conv` ;done
rm *.html
mkdir products
mkdir products_detail
cd ..
cat ./tmp/product.list* | ./generate.product.file.pl 
#cat ./tmp/product.list* | ./crop.product.list.pl
cat product.data.csv | ./convert.pl
clear;
echo "Хозяин я все сделал";