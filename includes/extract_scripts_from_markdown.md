# extract all rust code block from markdown script

<details>
    <summary>Generate scripts from markdown</summary>

- generate four script to extract code block
  - 01_generate_extract_rust_code block_from_md.sh => generate next script
  - 02_extract_rust_code blocks_from_markdown.sh
  - 03_generate_starter_script.sh
  - 04_run_all_generate_starter_script.sh

## first step - extract all rust code block from markdown file

> [!NOTE]  
> bash command : mkdir -p
> To create new directories if they do not exist and ignore the command if they do (no error message) use

```bash
#!/usr/bin/env bash
set -e
#xuo
export SCRIPT_FILE="01_generate_extract_rust_code block_from_md.sh"
export SCRIPT_DIR="utilities"
# create \$SCRIPT_DIR if is not available
mkdir -p ./"$SCRIPT_DIR";
# create script
cat << EoF > ./$SCRIPT_DIR/$SCRIPT_FILE
#!/usr/bin/env bash
# check minimum one argument is present
if [[ \$# -eq 0 ]] ; then
    echo 'No source markdown file as first argument is specified';
    exit 1
fi
export MD_SCRIPT="\$1"
export SCRIPTS_OUTPUT="./utilities/02_extract_rust_code blocks_from_markdown.sh";
export DIRECTORY_OUTPUT="./examples";
# test markdown file exits
if [ -f ./"\$MD_SCRIPT" ]; then
    echo "MD_SCRIPT exists => \$MD_SCRIPT.";
else
    echo "File does not exist => \$MD_SCRIPT.";
    return;
fi
echo "DIRECTORY_OUTPUT directory => \$DIRECTORY_OUTPUT";
echo "cleanup => \$DIRECTORY_OUTPUT";
[ -d \$DIRECTORY_OUTPUT ] && rm -fr "\$DIRECTORY_OUTPUT";
echo "create new: mkdir   => \$DIRECTORY_OUTPUT";
[ -d \$DIRECTORY_OUTPUT ] || mkdir "\$DIRECTORY_OUTPUT";
echo "cleanup => \$SCRIPTS_OUTPUT";
[ -f \$SCRIPTS_OUTPUT ] && rm "\$SCRIPTS_OUTPUT";
echo "create script_output =>\$SCRIPTS_OUTPUT";
# create new file
printf "\n" >\$SCRIPTS_OUTPUT && \
# add shebang
sed -i '1 i\#\!\/usr\/bin\/env bash' \$SCRIPTS_OUTPUT;
# add settings
sed -i '2 i\set -exuo' \$SCRIPTS_OUTPUT;
sed -n '/^\`\`\`rust/,/^\`\`\`/ p' <"\$MD_SCRIPT"| \
sed '\/^\`\`\`/ d' >> \$SCRIPTS_OUTPUT;#!/usr/bin/env bash
```

## 2nd version

```bash
set -e
#xuo
export SCRIPT_FILE="01_generate_extract_rust_code_block_from_md.sh"
export SCRIPT_DIR="utilities"
mkdir -p $SCRIPT_DIR
cat << EoF > ./$SCRIPT_DIR/$SCRIPT_FILE
#!/usr/bin/env bash
# check minimum one argument is present
if [ \$# -eq 0 ] ; then
    echo "No source markdown file as first argument is specified.";
    exit 1
fi
export MD_SCRIPT="\$1"
export SCRIPTS_OUTPUT="./utilities/02_extract_rust_code_blocks_from_markdown.sh";
export DIRECTORY_OUTPUT="./examples";
# test markdown file exits
if [ -f ./"\$MD_SCRIPT" ]; then
    echo "Ok => MD_SCRIPT exists, we will generate code block => \$MD_SCRIPT.";
else
    echo "Error => File does not exist => \$MD_SCRIPT.";
    return;
fi
echo "DIRECTORY_OUTPUT directory => \$DIRECTORY_OUTPUT";
echo "cleanup => \$DIRECTORY_OUTPUT";
[ -d \$DIRECTORY_OUTPUT ] && rm -fr "\$DIRECTORY_OUTPUT";
echo "create new: mkdir   => \$DIRECTORY_OUTPUT";
[ -d \$DIRECTORY_OUTPUT ] || mkdir "\$DIRECTORY_OUTPUT";
echo "cleanup => \$SCRIPTS_OUTPUT";
[ -f \$SCRIPTS_OUTPUT ] && rm "\$SCRIPTS_OUTPUT";
echo "create script_output =>\$SCRIPTS_OUTPUT";
printf "\n" >\$SCRIPTS_OUTPUT && sed -i '1 i\#\!\/usr\/bin\/env bash' \$SCRIPTS_OUTPUT;
# sed -n '/^\\\`\\\`\\\`rust/,/^\\\`\\\`\\\`/ p' <"\$MD_SCRIPT"| \
# sed '\/^\\\`\\\`\\\`/ d' >> \$SCRIPTS_OUTPUT;
sed -n "/^\\\`\\\`\\\`rust/,/^\\\`\\\`\\\`/ p" <"\$MD_SCRIPT"| sed "/^\\\`\\\`\\\`/ d" >> "\$SCRIPTS_OUTPUT";
EoF

ls -l \$SCRIPTS_OUTPUT;
# /bin/ls -ls "\$SCRIPTS_OUTPUT" | awk '{print "",\$10,\$7,\$8,\$9}';
# date +"%B %d %H:%M";
```

## next step - run generate script

```bash
#!/usr/bin/env bash
# change to PROJECT_FOLDER
sh +x ./utilities/01_generate_extract_rust_code_block_from_md.sh
```

```bash
.
.
create script_output =>./utilities/02_extract_rust_code_blocks_from_markdown.sh
.
.

```

## next step - run generated example script

```bash
#!/usr/bin/env bash
# change to PROJECT_FOLDER
sh +x ./utilities/02_extract_rust_code_blocks_from_markdown.sh
```

> [bash manual](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html)

## next step - extract generate starter scripts from each example

```bash
export SCRIPT_FILE="03_generate_starter_script.sh"
export SCRIPT_DIR="utilities"
cat << EoF > ./$SCRIPT_DIR/$SCRIPT_FILE
#!/usr/bin/env bash
# show command line
# set -x
FILES_DIR="examples";
SCRIPT_TARGET_DIR="run_examples";
# test SCRIPT_TARGET_DIR exits if NOT create it
[ ! -d \$SCRIPT_TARGET_DIR ] && mkdir \$SCRIPT_TARGET_DIR
# loop
for FILE_NAME in "\$FILES_DIR"/*.rs;
do
    echo "";
    echo "START => Processing \$FILE_NAME file...";
    if echo "\$FILE_NAME"| grep -q 'rs' ;then

        # echo "FILE_NAME => \$FILE_NAME";
        # SCRIPT_FILE_NAME="$(basename "\$FILE_NAME")";
        # echo "generate SCRIPT_FILE => \$STARTER_FILES_DIR/\$(basename "\$FILE_NAME")";
        # echo "script_file_name => \$SCRIPT_FILE_NAME";

        PLAIN_NAME="\$(echo "\$(basename "\$FILE_NAME")" | cut -d . -f 1)"
        echo "PLAIN_NAME => \$PLAIN_NAME";

        SCRIPT_FILE_NAME="\$PLAIN_NAME.sh";
        echo "SCRIPT_FILE_NAME => \$SCRIPT_FILE_NAME"

        echo "path/script_name => => ./\$SCRIPT_TARGET_DIR/\$SCRIPT_FILE_NAME";

        # generate new file
        printf "\n" >"./\$SCRIPT_TARGET_DIR/\$SCRIPT_FILE_NAME";
        ret=\$?;
        # add shebang
        sed -i '1 i\#\!\/usr\/bin\/env bash' "./\$SCRIPT_TARGET_DIR/\$SCRIPT_FILE_NAME";
        # add set -exuo
        # maybe to much
        # sed -i '2 i\set -exuo' "./\$SCRIPT_TARGET_DIR/\$SCRIPT_FILE_NAME";
        # add code block
        sed -n '/^\/\*/,/^\*\// p' <"\$FILE_NAME" >>"./\$SCRIPT_TARGET_DIR/\$SCRIPT_FILE_NAME";

        # remove
        # code block marker
        # before code block
        sed -i 's/^\/\*//' "./\$SCRIPT_TARGET_DIR/\$SCRIPT_FILE_NAME";
        # after code block
        sed -i 's/^\*\///' "./\$SCRIPT_TARGET_DIR/\$SCRIPT_FILE_NAME";
        # remove git push - minimize from too many git push during run
        sed -i 's/git push//' "./\$SCRIPT_TARGET_DIR/\$SCRIPT_FILE_NAME";
    else
        echo "NOT *.rs script => \$FILE_NAME";
        echo "next file ";
    fi
    #FINISHED
    echo "FINISH => Processing \$SCRIPT_FILE_NAME file...";
    echo "";
done
echo "check return code !!!"
echo "echo \\\$?";

EoF
```

## next step - run generate starter script

```bash
#!/usr/bin/env bash
# change to PROJECT_FOLDER
sh +x ./utilities/03_generate_starter_script.sh
```

## next step - run all generated starter script for each examples

```bash
#!/usr/bin/env bash
export SCRIPT_FILE="04_run_all_generate_starter_script.sh";
export SCRIPT_DIR="utilities";
cat << EoF > ./$SCRIPT_DIR/$SCRIPT_FILE
#!/usr/bin/env bash
FILES_DIRECTORY="run_examples";
FILES_DIRECTORY_ALL="run_all_examples";
# test FILES_DIRECTORY_ALL is exits, IF MOT create it
[ ! -d \$FILES_DIRECTORY_ALL ] && mkdir \$FILES_DIRECTORY_ALL;

echo "start ..";
# copy starter files and modify
cp -a ./"\$FILES_DIRECTORY"/* ./"\$FILES_DIRECTORY_ALL";

# build all example
cargo build --examples;


for FILE_NAME in "\$FILES_DIRECTORY_ALL"/*;
   do
   # comment cargo check for each starter script
   # avoid double/multiple run cargo check
   sed -i 's/^cargo check/# cargo check/' "./\$FILE_NAME";
   # remove/comment cargo clippy , cargo check for each starter script
   # avoid double/multiple run cargo clippy
   sed -i 's/^cargo clippy/# cargo clippy/' "./\$FILE_NAME";
   # remove/comment cargo fmt for each starter script
   # avoid unnecessary fmt action not changes are saved
   sed -i 's/^cargo fmt/# cargo fmt/' "./\$FILE_NAME";
   # avoid unnecessary clippy action not changes are saved 
   sed -i 's/^cargo clippy/# cargo clippy/' "./\$FILE_NAME";
   # avoid unnecessary git action script already save inside md file
   sed -i 's/^git/# git/' "./\$FILE_NAME";
   echo "Processing \$FILE_NAME file...";
   if echo "\$FILE_NAME"| grep -q 'sh' ;then
    echo "";
    echo "#################";
    echo "start => \$FILE_NAME";
    echo "#################";
    echo "";
    # shell check source=/dev/null
    EXIT_CODE=source sh +x "\$FILE_NAME";
    ret=\$?;
    echo "";
    echo "#################";
    echo "finished ..";
    # printf "ExitCode => %s  <= %s \n" "\$EXIT_CODE" "\$FILE_NAME";
    printf "ExitCode => %s <= %s \n" "\$ret" "\$FILE_NAME";
    echo "#################";
    echo "";
   else
    echo "NOT *.sh script => \$FILE_NAME ";
    echo "next file ";
   fi
done;
echo "finished ..";

EoF
```

## next step - run starter script

```bash
#!/usr/bin/env bash
# change to PROJECT_FOLDER
sh +x ./utilities/04_run_all_generate_starter_script.sh
```

## next step - project cleanup

```bash
#!/usr/bin/env bash
export SCRIPT_FILE="99_project_cleanup.sh"
export SCRIPT_DIR="utilities"
cat << EoF > ./$SCRIPT_DIR/$SCRIPT_FILE
#!/usr/bin/env bash
echo "Do you want cleanup this project ? Type => yes";
read -r  clean_up;
if [ "\$clean_up" = "yes" ];then
  echo "cleanup" && \
  cargo clean && \
  cargo clean --release
  ls -l ./target
else
  echo "Do nothing. By :-)";
fi

EoF
```

## step run all four step

```bash
2195* sh +x utilities/01_generate_extract_rust_code block_from_md.sh  Rust_Testcase_Main_Fn_Result.md
 2196  sh +x utilities/02_extract_rust_code blocks_from_markdown.sh 
 2197  sh +x utilities/03_generate_starter_script.sh 
 2198  sh +x utilities/04_run_all_generate_starter_script.sh 

```rust,no_run
#!/usr/bin/env bash
export EXAMPLE_SCRIPT_FILE="05_extract_scripts_from_markdown_and_run.sh"
export EXAMPLE_SCRIPT_DIR="utilities/"
cat << EoF > ./$EXAMPLE_SCRIPT_DIR/$EXAMPLE_SCRIPT_FILE
#!/usr/bin/env bash
# set script_name
SCRIPT_NAME="\$0";
echo "ScriptName => \$SCRIPT_NAME";
# check markdown file is as parameter not missing AND set inside script
# pure check minimum one argument is present
if [ \$# -eq 0 ] ; then
    echo "Error => No markdown file as first argument is specified.";
    exit 1;
fi
export MD_SCRIPT="\$1"
# loop through folder
for FILE_NAME in "\$EXAMPLE_SCRIPT_DIR"*
   do
    if [ "\$FILE_NAME" = "\$SCRIPT_NAME" ]; then
        # echo "HERE HERE equal" "\$FILE_NAME"  "\$SCRIPT_NAME";
        echo "NOT RUN the script itself => \$SCRIPT_NAME  ";
        # EXIT SCRIPT
        exit 0;
    else
        # echo "NOT equal" "\$FILE_NAME" "\$SCRIPT_NAME";
        echo "run script =>\$FILE_NAME";
    fi
    echo "Processing file =>  \$FILE_NAME ";
    if echo "\$FILE_NAME"| grep -q 'sh' ;then
        echo "";
        echo "#################";
        echo "start => \$FILE_NAME";
        echo "#################";
        echo "";
        # call each file with parameter
        BASE_NAME=\$(basename "\$FILE_NAME");
        echo "#################";
        echo "start => \$BASE_NAME";
        echo "#################";
        # FROM HERE
        # https://www.shellcheck.net/wiki/SC1091
        # shellcheck source=/dev/null
        bash +x ./"\$FILE_NAME" "\$MD_SCRIPT";
        ret=\$?;
        echo "";
        echo "#################";
        echo "finished ..";
        printf "ExitCode => %s <= %s \n" "\$ret" "\$FILE_NAME";
        echo "#################";
        echo "";
    else
        echo "NOT *.sh script => \$FILE_NAME ";
        echo "next file if it avaible ";
   fi
done;
echo "finished ..";
EoF

```

## next step - run cleanup script

```bash
#!/usr/bin/env bash
# change to PROJECT_FOLDER
sh +x ./utilities/99_project_cleanup.sh
```

## nice knowing - run rust script with Cargo.toml from [another](https://www.nativespeakeronline.com/confusing-words/the-difference-between-another-other-and-different) / different path

```bash
#!/usr/bin/env bash
cd && \
cd /tmp && \
cargo run \
--manifest-path /home/trapapa/rust_errors_handling/Cargo.toml \
--example 03_err_use_fallback_value
```

## nice knowing - create new script with shebang

```bash
#!/usr/bin/env bash
FILE="/tmp/shebang_insert.sh";
printf "\n" >$FILE && sed -i '1 i\#\!\/usr\/bin\/env bash' $FILE && \
cat $FILE;
```

</details>
