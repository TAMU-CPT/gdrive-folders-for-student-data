#!/usr/bin/env bash
#set -ex
PARENT_FOLDER=AAAAAAAAAAAAAAAAAAAAAAAAAAAA
DRY_RUN=true
if [ "$1" == "do_it" ]; then
	echo "RUNNING"
	DRY_RUN=false

else
	echo "DRY RUN. Please run '$0 do_it' in order to make changes"
fi

# Fix existing readers
CACHE="shared_with.$PARENT_FOLDER.txt"
# Cache if not already eixsting
if [ ! -f "$CACHE" ]; then
	gdrive share list $PARENT_FOLDER > $CACHE
fi
EMAILS=$(cat $CACHE | awk '($3=="reader"){print $4}')

printf "===============================\n"
printf "=   Checking existing grants  =\n"
printf "===============================\n"

for email in $EMAILS
do
	if grep -Fxq "$email" students.txt; then
		printf "%-36s is APPROVED for access. Access already granted.\n" $email
		# code if found
	else
		printf "%-36s is NOT APPROVED for access. Removing permissions.\n" $email
		perm_id=$(cat $CACHE | awk '($4=="'$email'"){print $1}')

		if [ "$DRY_RUN" = true ]; then
			echo gdrive share revoke $PARENT_FOLDER $perm_id
		else
			gdrive share revoke $PARENT_FOLDER $perm_id
		fi
	fi
done

printf "===============================\n"
printf "=     Syncing new entries     =\n"
printf "===============================\n"

# Now fix new readers
for email in $(cat students.txt)
do
	if grep -Fq "$email" $CACHE; then
		printf "%-36s is APPROVED for access. Access already granted\n" $email
	else
		printf "%-36s is APPROVED for access. Granting access\n" $email
		if [ "$DRY_RUN" = true ]; then
			echo gdrive share --role reader --type user --email "$email" $PARENT_FOLDER
		else
			gdrive share --role reader --type user --email "$email" $PARENT_FOLDER
		fi
	fi
done
