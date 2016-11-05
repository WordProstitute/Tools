#!/usr/bin/env bash
#
# WORD PROSTITUTE(R) SYSTEM OF RECORD FOR FICTION (Beta)
#
# Version 0.99.1

# PURPOSE:
# The purpose of this script is to show and tell steps to create
# a System of Record for Fiction for a non-coder and a coder.

# RESOURCES:
# WordProstituteSystemOfRecordForFiction.txt defines System of Record for Fiction.

# TODO:
# 1. Edit the while do argument to have a help switch parameter and change current -h to maybe -ho, so -h can be used for help.
# 2. Include and format WordProstituteSystemOfRecordForFiction.txt for the help.
# 3. Check .git directory from root of current working directory.
# 4. Implement the creation of FunWork.dtd.
# 5. Functionalize git commands.
# 6. Functionalize and order the Environment variables.
# 7. Functionalize the FunWork template or maybe read it in.
# 8. Check operating system and install git.
# 9. Add log file and /dev/null as output options.
# 10. Capture command return and print with spaces or tabs and format for output.
# 11. Rewrite as a class or classes in com.wordprostitute.tools.publish.*.

# Word Prostitute(R) Open Story License
#
# Story: sorff.sh
# Writer: Kalab J. Oster
# Copyright Holders: Kalab J. Oster
# copyright (C) Kalab J. Oster
#
# Permission is granted by the Copyright Holders for humans or other intelligent agents to read, write, edit, publish
# and critique the Story if the humans or intelligent agents keep this Word Prostitute(R) Open Story License with the
# Story, and if another writer writes or edits the Story then the writer's name needs to be appended to the end of
# the Writer list of this Word Prostitute(R) Open Story License.

# This link helped better write the lines 41 to 62 for parsing command line arguments in bash:
# http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
echo "READ AND PUBLISH PARAMETERS FOR OPTIONS AND ARGUMENTS"
while [[ $# -gt 1 ]]
do
parameter="$1"
case $parameter in
    -h|--home)
    HOME_FLAG="true"
    ;;
    -p|--pseudonym)
    PSEUDONYM="$2"
    shift 
    ;;
    -s|--story)
    STORY="$2"
    shift
    ;;
    *)

    ;;
esac
shift
done

echo "READ: CHECK IF PSEUDONYM EXISTS"
if [[ -z $PSEUDONYM ]]; then
     echo "CRITIQUE: ERROR=There is no argument with -p for a pseudonym."
     echo "PUBLISH: WORKING EXAMPLE=bash $0 -p 'Kalab J. Oster' -s 'Open'"
     echo "Exit sorff.sh"
     exit
fi
echo "READ: CHECK FOR SPACE IN PSEUDONYM"
if [[ $PSEUDONYM =~  ( |\') ]]; then
     echo "EDIT: CREATE SPACELESS FILE DIRECTORY VERSION OF $PSEUDONYM BECAUSE SPACES BREAK FILE SENTENCES"
     PSEUDONYM_FILE_DIRECTORY="${PSEUDONYM// /_}"
     echo "PUBLISH: PSEUDONYM_FILE_DIRECTORY EXISTS WITHOUT SPACES: $PSEUDONYM_FILE_DIRECTORY"
else
     PSEUDONYM_FILE_DIRECTORY=$PSEUDONYM
fi
echo "READ: CHECK IF STORY EXISTS"
if [[ -z $STORY ]]; then
     echo "CRITIQUE: ERROR=There is no argument with -s for a story."
     echo "PUBLISH: WORKING EXAMPLE=bash $0 -p 'Kalab J. Oster' -s 'Open'"
     echo "Exit sorff.sh"
     exit
fi
echo "READ: CHECK FOR SPACE IN STORY"
if [[ $STORY =~ ( |\') ]]; then
     echo "EDIT: CREATE SPACELESS FILE DIRECTORY VERSION OF $STORY BECAUSE SPACES BREAK FILE SENTENCES"
     STORY_FILE_DIRECTORY="${STORY// /_}"
     echo "PUBLISH: STORY_FILE_DIRECTORY EXISTS WITHOUT SPACES: $STORY_FILE_DIRECTORY"
else
     STORY_FILE_DIRECTORY=$STORY
fi
echo "PUBLISH: PRINT KEY VALUE PAIRS TO STDOUT"
echo "PUBLISH: PSEUDONYM=$PSEUDONYM"
echo "PUBLISH: STORY=$STORY"

echo "READ: IS GIT IS INSTALLED WITH TYPE"
if ! type "git" > /dev/null; then
     echo "CRITIQUE: INSTALL GIT=https://git-scm.com/book/en/v2/Getting-Started-Installing-Git"
     echo "Exit sorff.sh"
     exit
fi

echo "READ: CHECK FOR HOME AND HOME FLAG"
if [[ -d "$HOME" && -n "$HOME_FLAG" ]]; then
     echo "PUBLISH: PRINTING IN YOUR HOME DIRECTORY"
     echo "WRITE: CREATE ENVIRONMENT VARIABLE ROOT_DIRECTORY $HOME FOR GLOBAL USE"
     ROOT_DIRECTORY=$HOME
else
     echo "PUBLISH: PRINTING IN CURRENT WORKING DIRECTORY"
     echo "PUBLISH: IF IN A GIT REPOSITORY THEN YOU MAY WANT TO USE THE-h OPTION"
     echo "PUBLISH: WORKING EXAMPLE=bash $0 -h -p 'Kalab J Oster' -s 'Open'"
     echo "WRITE: CREATE ENVIRONMENT VARIABLE ROOT_DIRECTORY FOR GLOBAL USE"
     ROOT_DIRECTORY=$(pwd)
fi

echo "PUBLISH: SYSTEM OF RECORD EXISTS IN: $ROOT_DIRECTORY"

echo "READ: CHANGE DIRECTORY INTO ROOT DIRECTORY TO WRITE SYSTEM OF RECORD FOR FICTION"
cd $ROOT_DIRECTORY

echo "WRITE AND PUBLISH: CREATE SYSTEM OF RECORD"
git init $STORY_FILE_DIRECTORY

echo "READ: CHANGE DIRECTORY TO COMMIT CHANGE TO SYSTEM OF RECORD"
cd $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY

echo "WRITE: CREATE ENVIRONMENT VARIABLE WORKING_DIRECTORY FOR GLOBAL USE"
WORKING_DIRECTORY=$(pwd)
echo "PUBLISH: YOUR WORKING DIRECTORY IS: $WORKING_DIRECTORY"

echo "WRITE AND PUBLISH: DEFINE $PSEUDONYM AS GLOBAL GIT USER"
git config --global user.name "$PSEUDONYM"
git config --global user.email "$PSEUDONYM_FILE_DIRECTORY@localhost"

echo "PUBLISH AND WRITE: OVERWRITE FILE AND DEFINE THE TITLE IN THE GIT DESCRIPTION"
echo "$STORY" > $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/.git/description 

echo "WRITE: CREATE DIRECTORY SENTENCES TO WORDS FOR $PSEUDONYM's FUNWORK JOURNAL"
mkdir  $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/Tool
mkdir  $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/Tool/$PSEUDONYM_FILE_DIRECTORY
mkdir  $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/Tool/$PSEUDONYM_FILE_DIRECTORY/FunWork

echo "CREATE VARIABLE TO FUNWORK BECAUSE THE PATH STING IS LONG"
FUNWORK=$ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/Tool/$PSEUDONYM_FILE_DIRECTORY/FunWork/1.wpml.xml

echo "PUBLISH: CREATE DATE ENVIRONMENT VARIABLES FOR GLOBAL USE AND FunWork"
YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)

echo "WRITE: FILE $FUNWORK"
touch $FUNWORK

echo "WRITE AND PUBLISH: TEMPLATE $FUNWORK"

echo "<funwork timeframe='week'>" > $FUNWORK
echo "<funwork timeframe='day' time='$YEAR-$MONTH-$DAY' sounds='' images='' movies=''>" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='$STORY' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='$STORY' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK  
echo "</funwork>" >> $FUNWORK
echo "<funwork timeframe='day' time='$YEAR-$MONTH-$DAY' sounds='' images='' movies=''>" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='$STORY' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='$STORY' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK  
echo "</funwork>" >> $FUNWORK
echo "<funwork timeframe='day' time='$YEAR-$MONTH-$DAY' sounds='' images='' movies=''>" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='$STORY' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='$STORY' from='' to='' />" >> $FUNWORK
echo "<read-write-publish  data='FunWork' from='' to='' />" >> $FUNWORK  
echo "</funwork>" >> $FUNWORK
echo "<copyright>"  >> $FUNWORK
echo "copyright (c) $YEAR $PSEUDONYM" >> $FUNWORK
echo "</copyright>" >> $FUNWORK
echo "</funwork>" >> $FUNWORK

echo "PUBLISH: FUNWORK TO SYSTEM OF RECORD"
git add Tool/$PSEUDONYM_FILE_DIRECTORY/FunWork/1.wpml.xml
git commit -m"Publish the written template of FunWork." Tool/$PSEUDONYM_FILE_DIRECTORY/FunWork/1.wpml.xml

echo "WRITE: STORY TEMPLATE"
mkdir $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/Words
echo "A story directory for writing and editing." > $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/Words/README.md

echo "PUBLISH: STORY TEMPLATE"
git add Words/README.md
git commit -m"Publish: README.md and Words directory to maybe define the story." Words/README.md

echo "WRITE: TEMPLATE FOR BOOK FILE DIRECTORY"
mkdir $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/Book
echo "A story directory for publishing the book." > $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/Book/README.md

echo "PUBLISH: BOOK SENTENCE"
git add Book/README.md
git commit -m"Publish: README.md and Book directory to maybe define the book of the story." Book/README.md

echo "PUBLISH AND WRITE: BRANCH STORY"
git branch writer/"$PSEUDONYM_FILE_DIRECTORY"
git checkout writer/"$PSEUDONYM_FILE_DIRECTORY"

echo "WRITE: A FILE TO BEGIN" 
touch $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/Words/1.txt

echo "PUBLISH: BEGIN"
git add Words/1.txt
git commit -m"Publish: a file that may begin what you need written." Words/1.txt

echo "PUBLISH: CHANGE DIRECTORY TO BEGIN WRITING A FICTION STORY"
echo "PUBLISH: EXECUTE='cd $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/Words'"
echo "PUBLISH: CHANGE DIRECTORY TO WRITE THE JOURNAL OF A WRITER FOR YOU AND MAYBE A.I."
echo "PUBLISH: EXECUTE='cd $ROOT_DIRECTORY/$STORY_FILE_DIRECTORY/Tool/$PSEUDONYM_FILE_DIRECTORY/FunWork'"
echo "PUBLISH: MANUAL=https://git-scm.com/"
echo "Thank you for writing with Word Prostitute(R)"

