Skeletons for the tSkeleton vim plugin:
http://www.vim.org/scripts/script.php?script_id=1160

By default, this is the directory where tskeleton searches for skeletons. This directory may contain three types of files:

1. Manually configured skeletons, loaded from an autocommand. Example: This will load a file plain.txt from this directory when creating new files whose extension is "txt":

        autocmd BufNewFile *.txt TSkeletonSetup plain.txt

2. Automatically configured skeletons are kept in the "templates" subdirectory. tskeleton will automatically define suitable autocommands for you. The effect of the above example could also be achieved by saving the template as

        ".../templates/text/text #.vim"

3. "Bits" are skeletons for small portions of code. These are saved in the "bits" subdirectory. Example: The bits for, say, vimscript 

        files are kept in ".../bits/vim/"

