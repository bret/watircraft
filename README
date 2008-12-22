= taza

* http://github.com/scudco/taza/tree/master 

== DESCRIPTION:

Taza is meant to make acceptance testing more sane for developers(or QA where applicable) and customers.

== FEATURES:

* Generate a project for browser-based testing
* Generate pages and sites for different applications
* Create flows that move through a site
* Use filters to control which elements are accessible on a page depending on its state
* Taza automatically creates and cleans up the browser for each site just like a File block
* Manage tests by tags
* Cross-site testing

== ISSUES:

* Taza has only been used in the wild with WATIR(Safari/Firefox/IE), but Selenium support is built-in
* Taza's generators currently generate RSpec specs, Test::Unit and other test framework support is planned

== SYNOPSIS:

Taza is meant to be a refreshing way to look at browser testing. Taza provides a few ways to abstract browser-based testing into three simple ideas.
  * Sites
  * Pages
  * Flows

Sites have Pages.
Pages have elements and filters.
Flows are common actions on a site such as logging in or performing a search.

Here's an example for starting a project around the Google sites

  $ taza google
  $ cd google/
  $ ./script/generate site google
  $ ./script/generate page home_page google
  $ ./script/generate flow search google
  $ rake spec:functional:google

That will generate an RSpec HTML report at artifacts/functional/google/index.html


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
