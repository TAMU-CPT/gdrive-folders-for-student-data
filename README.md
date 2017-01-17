# Batch Google Drive Folder Utilities

At the end of each semester we have students deposit datasets to a folder named
after them (for our ease of administration).

This is a script to automatically create those folders and share those folders
with the individual students.

## Creating Folders

1. Edit gdrive-create.sh

    - You will need to edit the parent ID
    - You will need to edit the list of names / emails

2. `bash gdrive-create.sh`


```
[hxr@leda:~/work]$ bash tmp.sh > email.html
Directory **************************** created
Granted writer permission to user
[hxr@leda:~/work]$ cat email.html
<a href="https://drive.google.com/open?id=****************************">Jane Doe</a><br />
```

## Sharing

At the start of the course, we wanted a nice script that would **sync** a list
of shares against a newline separated list of students in `students.txt`.

`share.sh` will share the folder and show you the changes that will be made.
Supplying the `do_it` argument, the tool will execute the actual changes.

## Unsharing

We needed a script to revoke permissions on student uploaded data, this was trivially handled with `unshare.sh`

## Dependencies

https://github.com/prasmussen/gdrive/

## License

MIT
