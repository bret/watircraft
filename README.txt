= taza

* http://github.com/scudco/taza/tree/master 

== DESCRIPTION:

Taza is meant to make acceptance testing more sane for developers(or QA where applicable) and customers.

== FEATURES/PROBLEMS:

* Generate a project for application testing
* Generate pages and sites for different applications
* Manage tests by tags
* Cross-site testing

== SYNOPSIS:

To generate a new skeleton for acceptance testing
 $ taza foo

Inside your new skeleton you'll have a few rake tasks available to help you get started
 $ rake generate:site name=google
 $ rake generate:page site=google name=home_page

== REQUIREMENTS:

* taglob 

== INSTALL:

* sudo gem install taza 
* gem install taza

== LICENSE:

(The MIT License)

Copyright (c) 2008 Charley Baker

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
