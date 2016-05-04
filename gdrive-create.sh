#!/usr/bin/env bash
PARENT_FOLDER=****************************
PARENT_FOLDER_MKDIR=-p $PARENT_FOLDER

function process_student(){
    STUDENT_NAME=$1
    STUDENT_EMAIL=$2

    response=$(gdrive mkdir $PARENT_FOLDER_MKDIR "$STUDENT_NAME")
    (>&2 echo "$response")
    folder_id=$(echo $response | sed 's/Directory //;s/ created//')

    response=$(gdrive share --role writer --type user --email "$STUDENT_EMAIL" "$folder_id")
    (>&2 echo "$response")
    echo '<a href="https://drive.google.com/open?id='$folder_id'">'"$STUDENT_NAME"'</a><br />'
}

process_student 'Jane Doe' 'j.doe@tamu.edu'
