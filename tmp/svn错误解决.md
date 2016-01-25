# svn

## xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun

Have you upgraded to OS X El Cap­i­tan from App Store ?

Have you sud­denly started get­ting the fol­low­ing error in your project?

xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun

If yes, then here is the solution

    xcode-select --install

Remem­ber, in MAC git is attached to XCode’s Com­mand line tools.

## sqlite: database disk image is malformed

This has been asked before:

svn cleanup: sqlite: database disk image is malformed

The answer there is:

You do an integrity check on the sqlite database that keeps track of the repository (/.svn/wc.db):

    sqlite3 .svn/wc.db "pragma integrity_check"

That should report some errors.

Then you might be able to clean them up by doing:

    sqlite3 .svn/wc.db "reindex nodes"
    sqlite3 .svn/wc.db "reindex pristine"

If there are still errors after that, you still got the option to check out a fresh copy of the repository to a temporary folder and copy the .svn folder from the fresh copy to the old one. Then the old copy should work again and you can delete the temporary folder.

## svn客户端E155037错误, 解决:执行 svn cleanup 即可
