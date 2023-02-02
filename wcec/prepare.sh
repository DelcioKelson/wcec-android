#!/bin/sh

mkdir sootOutput
mkdir resources
mkdir resources/files_to_analyse/
clear

java -cp soot-infoflow-cmd-jar-with-dependencies.jar CFG.java $1 > resources/cg.txt
if [ -s resources/cg.txt ]; then
    clear
    while [ -z  "$(ls -A sootOutput/)" ]
    do
        java -cp soot-infoflow-cmd-jar-with-dependencies.jar soot.tools.CFGViewer -w -allow-phantom-refs -android-jars "/opt/android-sdk/platforms" -process-multiple-dex -output-format jimple -src-prec apk -process-dir $1
        clear
    done

    #Call graph refinements

    #echo '|-->                  |'

    sed -i '/Exception/d' resources/cg.txt
    # cg refine
    sed -i 's/.*\sin\s//g' resources/cg.txt
    sed -i 's/ ==> /=/g' resources/cg.txt
    sed -i 's/\$\$/../g' resources/cg.txt
    sed -i 's/://g' resources/cg.txt
    sed -i 's/\$1/.1/g' resources/cg.txt
    #Replace <> in text
    sed -i 's/<init>/init/g' resources/cg.txt
    sed -i 's/<clinit>/clinit/g' resources/cg.txt
    sed -i 's/<//g' resources/cg.txt
    sed -i 's/>//g' resources/cg.txt
    sed -i 's/\sclinit/ <clinit>/g' resources/cg.txt
    sed -i 's/\sinit/ <init>/g' resources/cg.txt

    #################

    # get *.dot files (or any pattern you like) into one place
    find sootOutput/ -name "androidx.*" -print0 | xargs -0 rm
    find sootOutput/ -name "org.*" -print0 | xargs -0 rm
    find sootOutput/ -name "android.*" -print0 | xargs -0 rm
    find sootOutput/ -name "com.google.*" -print0 | xargs -0 rm
    find sootOutput/ -name "*.R.*" -print0 | xargs -0 rm
    find sootOutput/ -name "*.BuildConfig*" -print0 | xargs -0 rm
    find sootOutput/ -name "*.jimple" -print0 | xargs -0 rm
    find sootOutput/ -name "kotlin.*" -print0 | xargs -0 rm
    find sootOutput/ -name "kotlinx.*" -print0 | xargs -0 rm
    find sootOutput/ -name "*.sun.*" -print0 | xargs -0 rm
    clear
    
    #delete lines
    find sootOutput/ -type f  -exec  sed -i '/->/d' {} \;
    find sootOutput/ -type f  -exec  sed -i '/specialinvoke/d' {} \;
    find sootOutput/ -type f  -exec  sed -i '/style/d' {} \;
    find sootOutput/ -type f  -exec  sed -i '/node/d' {} \;
    find sootOutput/ -type f  -exec  sed -i '/\@/d' {} \;
    
    clear   

    find sootOutput/ -type f  -exec  sed -i '/[^\[]label=/d' {} \;
    find sootOutput/ -type f  -exec  sed -i '/\"if/d' {} \;
    find sootOutput/ -type f  -exec  sed -i -e '/{/d' {} \;
    find sootOutput/ -type f  -exec  sed -i -e '/}/d' {} \;

    #replace strings
    find sootOutput/ -type f  -exec  sed -i 's/,//g' {} \;
    find sootOutput/ -type f  -exec  sed -i 's/]//g' {} \;
    find sootOutput/ -type f  -exec  sed -i 's/\[//g' {} \;
    find sootOutput/ -type f  -exec  sed -i 's/label=//g' {} \;
    find sootOutput/ -type f  -exec  sed -i 's/;//g' {} \;
    find sootOutput/ -type f  -exec  sed -i -E 's/"[0-9]+"//g' {} \;
    find sootOutput/ -type f  -exec  sed -i -E 's/"//g' {} \;

    #move sootOutput files to files_to_analyse folder
    find sootOutput/ -type f -name "*.dot" -exec cp {} resources/files_to_analyse/ \;

    #delete more lines
    find resources/files_to_analyse/ -type f  -exec  sed -i '/(/d' {} \;
    find resources/files_to_analyse/ -type f  -exec  sed -i '/&/d' {} \;
    find resources/files_to_analyse/ -type f  -exec  sed -i '/)/d' {} \;
    find resources/files_to_analyse/ -type f  -exec  sed -i '/\./d' {} \;
    find resources/files_to_analyse/ -type f  -exec  sed -i '/cmp/d' {} \;
    find resources/files_to_analyse/ -type f  -exec  sed -i '/\|/d' {} \;
    find resources/files_to_analyse/ -type f  -exec  sed -i '/\^/d' {} \;
    find resources/files_to_analyse/ -type f  -exec  sed -i '/\\\"/d' {} \;
    find resources/files_to_analyse/ -type f  -exec  sed -i '/new/d' {} \;
    find resources/files_to_analyse/ -type f  -exec  sed -i -E '/r[0-9]+/d' {} \;
    clear
    
    #delete empty files
    find resources/files_to_analyse/ -size 0 -print -delete
    find sootOutput/ -size 0 -print -delete
    clear

else 
    echo 'soot error. Try again'
fi