#!/usr/bin/env bash
SCRIPT_NAME="$0";
echo "ScriptName => $SCRIPT_NAME";

# check markdown file is as parameter not missing
# pure check minimum one argument is present
if [ $# -eq 0 ] ; then
    echo "Error => No source markdown file as first argument is specified.";
    exit 1
fi
export MD_SCRIPT="$1"


for FILE_NAME in "$EXAMPLE_SCRIPT_DIR"*
   do
    if [ "$FILE_NAME" = "$SCRIPT_NAME" ]; then
        # echo "HERE HERE equal" "$FILE_NAME"  "$SCRIPT_NAME";
        echo "NOT RUN the script itself => $SCRIPT_NAME  ";
        # EXIT SCRIPT
        exit 0
    else
        # echo "NOT equal" "$FILE_NAME" "$SCRIPT_NAME";
        echo "run script =>$FILE_NAME";
    fi
    echo "Processing file =>  $FILE_NAME ";
    if echo "$FILE_NAME"| grep -q 'sh' ;then
        echo "";
        echo "#################";
        echo "start => $FILE_NAME";
        echo "#################";
        echo "";
        # call each file with parameter
        source sh +x "$FILE_NAME" "$MD_SCRIPT";
        ret=$?;
        echo "";
        echo "#################";
        echo "finished ..";
        printf "ExitCode => %s <= %s \n" "$ret" "$FILE_NAME";
        echo "#################";
        echo "";
    else
        echo "NOT *.sh script => $FILE_NAME ";
        echo "next file if it avaible ";
   fi
done;
echo "finished ..";
