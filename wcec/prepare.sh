#!/bin/sh

mkdir /tmp/sootOutput
mkdir /tmp/files_to_analyse
clear

java -cp soot-infoflow-cmd-jar-with-dependencies.jar CFG.java $1 > /tmp/cg.txt
if [ -s /tmp/cg.txt ]; then
    clear
    while [ -z  "$(ls -A /tmp/sootOutput/)" ]
    do
        java -cp soot-infoflow-cmd-jar-with-dependencies.jar soot.tools.CFGViewer -w -allow-phantom-refs -android-jars "/opt/android-sdk/platforms" -process-multiple-dex  -output-dir /tmp/sootOutput -output-format jimple -src-prec apk -process-dir $1
        clear
    done

    #Call graph refinements

    #echo '|-->                  |'

    sed -i '/Exception/d' /tmp/cg.txt
    # cg refine
    sed -i 's/.*\sin\s//g' /tmp/cg.txt
    sed -i 's/ ==> /=/g' /tmp/cg.txt
    sed -i 's/\$\$/../g' /tmp/cg.txt
    sed -i 's/://g' /tmp/cg.txt
    sed -i 's/\$1/.1/g' /tmp/cg.txt
    #Replace <> in text
    sed -i 's/<init>/init/g' /tmp/cg.txt
    sed -i 's/<clinit>/clinit/g' /tmp/cg.txt
    sed -i 's/<//g' /tmp/cg.txt
    sed -i 's/>//g' /tmp/cg.txt
    sed -i 's/\sclinit/ <clinit>/g' /tmp/cg.txt
    sed -i 's/\sinit/ <init>/g' /tmp/cg.txt

    #################

    # get *.dot files (or any pattern you like) into one place
    find /tmp/sootOutput/ -name "androidx.*" -print0 | xargs -0 rm
    find /tmp/sootOutput/ -name "org.*" -print0 | xargs -0 rm
    find /tmp/sootOutput/ -name "android.*" -print0 | xargs -0 rm
    find /tmp/sootOutput/ -name "com.google.*" -print0 | xargs -0 rm
    find /tmp/sootOutput/ -name "*.R.*" -print0 | xargs -0 rm
    find /tmp/sootOutput/ -name "*.BuildConfig*" -print0 | xargs -0 rm
    find /tmp/sootOutput/ -name "*.jimple" -print0 | xargs -0 rm
    find /tmp/sootOutput/ -name "kotlin.*" -print0 | xargs -0 rm
    find /tmp/sootOutput/ -name "kotlinx.*" -print0 | xargs -0 rm
    find /tmp/sootOutput/ -name "*.sun.*" -print0 | xargs -0 rm
    clear
    
    #delete lines
    find /tmp/sootOutput/ -type f  -exec  sed -i '/->/d' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i '/specialinvoke/d' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i '/style/d' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i '/node/d' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i '/\@/d' {} \;
    
    clear   

    find /tmp/sootOutput/ -type f  -exec  sed -i '/[^\[]label=/d' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i '/\"if/d' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i -e '/{/d' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i -e '/}/d' {} \;

    #replace strings
    find /tmp/sootOutput/ -type f  -exec  sed -i 's/,//g' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i 's/]//g' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i 's/\[//g' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i 's/label=//g' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i 's/;//g' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i -E 's/"[0-9]+"//g' {} \;
    find /tmp/sootOutput/ -type f  -exec  sed -i -E 's/"//g' {} \;

    #move /tmp/sootOutput files to files_to_analyse folder
    find /tmp/sootOutput/ -type f -name "*.dot" -exec cp {} /tmp/files_to_analyse/ \;

    #delete more lines
    find /tmp/files_to_analyse/ -type f  -exec  sed -i '/(/d' {} \;
    find /tmp/files_to_analyse/ -type f  -exec  sed -i '/&/d' {} \;
    find /tmp/files_to_analyse/ -type f  -exec  sed -i '/)/d' {} \;
    find /tmp/files_to_analyse/ -type f  -exec  sed -i '/\./d' {} \;
    find /tmp/files_to_analyse/ -type f  -exec  sed -i '/cmp/d' {} \;
    find /tmp/files_to_analyse/ -type f  -exec  sed -i '/\|/d' {} \;
    find /tmp/files_to_analyse/ -type f  -exec  sed -i '/\^/d' {} \;
    find /tmp/files_to_analyse/ -type f  -exec  sed -i '/\\\"/d' {} \;
    find /tmp/files_to_analyse/ -type f  -exec  sed -i '/new/d' {} \;
    find /tmp/files_to_analyse/ -type f  -exec  sed -i -E '/r[0-9]+/d' {} \;
    clear
    
    #delete empty files
    find /tmp/files_to_analyse/ -size 0 -print -delete
    find /tmp/sootOutput/ -size 0 -print -delete
    clear

else 
    echo 'soot error. Try again'
fi