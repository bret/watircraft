Gem::Specification.new do |s|
  s.name = %q{firewatir}
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Angrez Singh"]
  s.date = %q{2008-08-14}
  s.description = %q{FireWatir stands for "Web Application Testing in Ruby for Firefox". FireWatir (pronounced firewater) is a free,  open-source functional testing tool for automating browser-based tests of web applications.  It works with applications written in any language. FireWatir drives the Firefox browser the same way an end user would.  It clicks links, fills in forms, presses buttons.  FireWatir also checks results, such as whether expected text appears on the page, or whether a control is enabled. FireWatir is a Ruby library that works with Firefox on Windows. It also works on Linux, Mac but without support for JavaScript popups (currently support will be there shortly).}
  s.email = %q{firewatir@groups.google.com}
  s.files = ["container.rb", "firewatir.rb", "htmlelements.rb", "MozillaBaseElement.rb", "firewatir/exceptions.rb", "firewatir/testUnitAddons.rb", "firewatir/winClicker.rb", "firewatir/x11.rb", "unittests/attach_to_new_window_test.rb", "unittests/bug_fixes_test.rb", "unittests/buttons_test.rb", "unittests/buttons_xpath_test.rb", "unittests/checkbox_test.rb", "unittests/checkbox_xpath_test.rb", "unittests/div_test.rb", "unittests/filefield_test.rb", "unittests/filefield_xpath_test.rb", "unittests/form_test.rb", "unittests/frame_test.rb", "unittests/hidden_test.rb", "unittests/hidden_xpath_test.rb", "unittests/images_test.rb", "unittests/images_xpath_test.rb", "unittests/iostring.rb", "unittests/iostring_test.rb", "unittests/javascript_test.rb", "unittests/links_test.rb", "unittests/links_xpath_test.rb", "unittests/mozilla_all_tests.rb", "unittests/pre_test.rb", "unittests/radios_test.rb", "unittests/radios_xpath_test.rb", "unittests/redirect_test.rb", "unittests/selectbox_test.rb", "unittests/selectbox_xpath_test.rb", "unittests/setup.rb", "unittests/table_test.rb", "unittests/table_xpath_test.rb", "unittests/textfields_test.rb", "unittests/textfields_xpath_test.rb", "unittests/html/blankpage.html", "unittests/html/buttons1.html", "unittests/html/checkboxes1.html", "unittests/html/complex_table.html", "unittests/html/cssTest.html", "unittests/html/div.html", "unittests/html/div_xml.html", "unittests/html/fileupload.html", "unittests/html/forms2.html", "unittests/html/forms3.html", "unittests/html/forms4.html", "unittests/html/formTest1.html", "unittests/html/frame_buttons.html", "unittests/html/frame_links.html", "unittests/html/frame_multi.html", "unittests/html/iframeTest.html", "unittests/html/iframeTest1.html", "unittests/html/iframeTest2.html", "unittests/html/images1.html", "unittests/html/JavascriptClick.html", "unittests/html/javascriptevents.html", "unittests/html/links1.html", "unittests/html/links2.html", "unittests/html/link_pass.html", "unittests/html/modal_dialog.html", "unittests/html/modal_dialog_launcher.html", "unittests/html/nestedFrames.html", "unittests/html/new_browser.html", "unittests/html/pass.html", "unittests/html/popups1.html", "unittests/html/pre.html", "unittests/html/radioButtons1.html", "unittests/html/redirect.html", "unittests/html/redirect1.html", "unittests/html/redirect2.html", "unittests/html/redirect3.html", "unittests/html/selectboxes1.html", "unittests/html/select_tealeaf.html", "unittests/html/simple_table.html", "unittests/html/simple_table_buttons.html", "unittests/html/simple_table_columns.html", "unittests/html/table1.html", "unittests/html/tableCell_using_xpath.html", "unittests/html/textarea.html", "unittests/html/textfields1.html", "unittests/html/textsearch.html", "unittests/html/images/1.gif", "unittests/html/images/2.GIF", "unittests/html/images/3.GIF", "unittests/html/images/button.jpg", "unittests/html/images/circle.jpg", "unittests/html/images/minus.GIF", "unittests/html/images/originaltriangle.jpg", "unittests/html/images/plus.gif", "unittests/html/images/square.jpg", "unittests/html/images/triangle.jpg"]
  s.has_rdoc = true
  s.homepage = %q{http://code.google.com/p/firewatir}
  s.rdoc_options = ["--title", "FireWatir API Reference", "--accessor", "def_wrap=R,def_wrap_guard=R,def_creator=R,def_creator_with_default=R", "--exclude", "unittests|camel_case.rb|testUnitAddons.rb"]
  s.require_paths = ["."]
  s.requirements = ["Mozilla Firefox browser 1.5 or later."]
  s.rubyforge_project = %q{Watir}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Automated testing tool for web applications using Firefox browser.}
  s.test_files = ["unittests/mozilla_all_tests.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
