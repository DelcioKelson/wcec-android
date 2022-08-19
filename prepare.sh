#!/bin/sh

DIR="sootOutput/"

while [ ! -d "$DIR" ] && rm -f sootOutput 
do
    java -cp sootclasses-trunk-jar-with-dependencies.jar soot.tools.CFGViewer -w -allow-phantom-refs -android-jars "/home/ferramenta/Android/Sdk/platforms" -process-multiple-dex -output-format jimple -src-prec apk -process-dir apk/*.apk
    clear
done
java -cp soot-infoflow-cmd-jar-with-dependencies.jar  CFG.java apk/app-debug.apk > cg.txt

# get *.dot files (or any pattern you like) into one place
find sootOutput/ -name "androidx.*" -print0 | xargs -0 rm
find sootOutput/ -name "android.*" -print0 | xargs -0 rm
find sootOutput/ -name "com.google.*" -print0 | xargs -0 rm
find sootOutput/ -name "*.R.*" -print0 | xargs -0 rm
find sootOutput/ -name "*.BuildConfig*" -print0 | xargs -0 rm
find sootOutput/ -name "*.jimple" -print0 | xargs -0 rm

sed -i '/->/d' sootOutput/*.dot
sed -i '/specialinvoke/d' sootOutput/*.dot
sed -i '/style/d' sootOutput/*.dot
sed -i '/node/d' sootOutput/*.dot
sed -i '/\@/d' sootOutput/*.dot
sed -i '/\\\"/d' sootOutput/*.dot
sed -i '/\"if/d' sootOutput/*.dot
sed -i '/new/d' sootOutput/*.dot
sed -i '/\./d' sootOutput/*.dot
sed -i -e '/{/d' sootOutput/*.dot
sed -i -e '/}/d' sootOutput/*.dot
sed -i '/[^\[]label=/d' sootOutput/*.dot
sed -i -E '/r[0-9]+/d' sootOutput/*.dot

sed -i 's/;//g' sootOutput/*.dot
sed -i -E 's/"[0-9]+"//g' sootOutput/*.dot
sed -i -E 's/"//g' sootOutput/*.dot
sed -i 's/label=//g' sootOutput/*.dot
sed -i 's/\[//g' sootOutput/*.dot
sed -i 's/]//g' sootOutput/*.dot
sed -i 's/,//g' sootOutput/*.dot


find sootOutput/ -size 0 -print -delete

clear