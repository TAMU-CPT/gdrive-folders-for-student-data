#!/usr/bin/env bash
#set -ex
PARENT_FOLDER=****************************
parents=$(mktemp)

gdrive share list $PARENT_FOLDER | grep '@tamu.edu' | awk '{print $4}' > $parents

echo $parent_folder_emails

function unshare(){
    STUDENT_NAME=$1
    STUDENT_EMAIL=$2

    folders=$(gdrive list  -q '"'$PARENT_FOLDER'" in parents')
    for id in $(echo "$folders" | awk '(NR>1){print $1}');
    do
        # Changing to @tamu.edu selects for emails, tamu.edu selects emails + domain
        data=$(gdrive share list $id | grep 'tamu.edu' | grep -v -f $parents)
        share_ids=($(echo "$data"|  awk '{print $1}'))
        emails=($(echo "$data"|  awk '{print $4}'))
        #for share_id in $share_ids; do
        for ((i=0;i<${#share_ids[@]};i++)); do
            email=${emails[i]}
            share_id=${share_ids[i]}
            echo "Unsharing $id from $email ($share_id)"
            gdrive share revoke $id $share_id;
        done
    done
}
unshare
rm $parents
