HTML_TeX
========

This is a simple tool to convert HTML blocks of code into TeX code.

It is meant to be used to convert short blocks of HTML code directly in place.

It doesn't have any dependencies.

Gem use
-----------

    require "html_tex"
    
    # Return output as a string
    tex = HtmlTex.convert(html)

Limitations
-----------

At the moment this tool only recognises simple HTML tags. It doesn't (and likely won't ever) recognise any CSS code.

Future Improvements
----------
* Have a complementary object oriented approach;
* Allow the definition of options;
* Add an option to return a full TeX document;
* Expand the String class allowing the conversion of any string to TeX.
