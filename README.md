# Batch Google Drive Folder Script

At the end of each semester we have students deposit datasets to a folder named
after them (for our ease of administration).

This is a script to automatically create those folders and share those folders
with the individual students.


## Execution

1. Edit gdrive-create.sh

    - You will need to edit the parent ID
    - You will need to edit the list of names / emails

2. `bash gdrive-create.sh`


```
[hxr@leda:~/work/checklistomania]$ bash tmp.sh > email.html
Directory **************************** created
Granted writer permission to user
[hxr@leda:~/work/checklistomania]$ cat email.html
<a href="https://drive.google.com/open?id=****************************">Jane Doe</a><br />
```

## Options

If you wish to create the folder in the root of your google drive (but why
would you ever do that?) you cans imply comment out the two `PARENT_FOLDER`
settings at the top.

## Dependencies

https://github.com/prasmussen/gdrive/

## License

MIT
