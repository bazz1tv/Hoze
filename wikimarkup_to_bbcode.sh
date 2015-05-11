tmpfile=`mktemp /tmp/XXXXXX`

echo "using $tmpfile"
cp $1 $tmpfile
### '''Bold''' or '''Bold 
## Must run these 2 in the order provided
# most correct syntax
perl -i.original -pe "s#(''')(.+?)(''')#\[b\]\2\[/b\]#g" $tmpfile
# passing syntax
sed -E -i.original "s#(''')(.*)($)#\[b\]\2\[/b\]#g" $tmpfile

### == Heading == or ==Heading==
## ascend the levels of heading
sed -E -i.original "s#(=====)(.*)(=====)#[SIZE="2"]\2[/SIZE]#g"	$tmpfile
sed -E -i.original "s#(====)(.*)(====)#[SIZE="3"]\2[/SIZE]#g"	$tmpfile
sed -E -i.original "s#(===)(.*)(===)#[SIZE="4"]\2[/SIZE]#g"		$tmpfile
sed -E -i.original "s#(==)(.*)(==)#[SIZE="5"]\2[/SIZE]#g" $tmpfile
### <source> multi-line </source>
perl -0777 -i.original -pe 's#(<source>)(.+?)(</source>)#\[CODE\]$2\[/CODE\]#gis' $tmpfile

### Links
## Internal
#Images
sed -E -i.original 's#(\[\[)(.*)(\]\])#\[URL\]http://wiki.bazz1.com/index.php/\2\[/URL\]#g' $tmpfile
#etc
sed -E -i.original 's#(\[\[)(.*)(\]\])#\[URL\]http://wiki.bazz1.com/index.php/\2\[/URL\]#g' $tmpfile

### External
## labeled
# HTTP(S)
sed -E -i.original 's#\[(https?://[^ ]*) (.*)\]#\[URL=\1\]\2\[/URL\]#g' $tmpfile
## Unlabeled
# HTTP(S)
sed -E -i.original 's#\[(https?://[^ ]*)\]#\[URL\]\1\[/URL\]#g' $tmpfile




###Ordered Lists
## This does not cover nested lists (that would be implemented in C I think, using a for loop for the number of #'s)
#[list=1][*]Example list item 1.[/*][*]Example list item 2.[/*][*]Example list item 3.[/*][/list] produces a numbered list.
# add the end list marker
perl -00 -i.original -pe 's|(^\#.*)|\1\n\[/list\]\n|gis' $tmpfile
# match the first
	# below comment includes the terminating list marker
	#perl -000 -i.original -pe 's#^\*(.+?)\s#\[list\]\n\[\*\]\1\[/\*\]#gis' $tmpfile
perl -00 -i.original -pe 's|(^#.+?\n)|\[list=1\]\n\1|gis' $tmpfile
# match rest
	# below comment includes terminating list marker
	#perl -i.original -pe 's#^\*(.*)$#\[\*\]\1\[/\*\]#gi' $tmpfile
perl -i.original -pe 's|^\#(.*)$|\[\*\]\1|gi' $tmpfile
# end

###Unordered lists *
## This does not cover nested lists (that would be implemented in C I think, using a for loop for the number of *'s)
##[list][*]Example list item 1.[/*][*]Example list item 2.[/*][*]Example list item 3.[/*][/list] produces a bulleted list.
# add the end list marker
#perl -00 -i.original -pe 's#(^\*.*)#\1\n\[/list\]#gis' $tmpfile
perl -00 -i.original -pe 's#(^\*.*)#\1\n\[/list\]\n#gis' $tmpfile
# match the first
	# below comment includes the terminating list marker
	#perl -000 -i.original -pe 's#^\*(.+?)\s#\[list\]\n\[\*\]\1\[/\*\]#gis' $tmpfile
perl -00 -i.original -pe 's#(^\*.+?\n)#\[list\]\n\1#gis' $tmpfile
# match rest
	# below comment includes terminating list marker
	#perl -i.original -pe 's#^\*(.*)$#\[\*\]\1\[/\*\]#gi' $tmpfile
perl -i.original -pe 's#^\*(.*)$#\[\*\]\1#gi' $tmpfile
# end
#perl -000 -pe 's#^\*(.*)#\[list\]\n\[\*\]\1\[/\*\]#gis'

subl $tmpfile