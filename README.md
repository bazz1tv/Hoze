# Wiki-Markup to BBCode Converter

Wiki Markup, also known as wikitext or wikicode, to bbcode converter.

## considered volatile

it's only been worked on for a matter of hours.

### Requirements

Perl and Sed (OSX 10.10.3's SED works fine). I use perl from macports.

### How to Use

On the wiki, edit the page to access the wiki markup, copy and paste it into a local file. then from a shell,

	$ ./wiki_markup_to_bbcode.sh wm.txt

The output is now in your clipboard for pasting

### Current Support

Bold text 

4 levels of headings starting from == to ===== 

Links -- HTTP(S), internal and external

(Un)Ordered lists are supported, but Nested lists are not supported. Only 1 level deep.

### To-Do

Images

Support to handle input from pbpaste
