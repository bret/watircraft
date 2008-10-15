Gem::Specification.new do |s|
  s.name = %q{rb-appscript}
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["HAS"]
  s.date = %q{2008-02-17}
  s.extensions = ["extconf.rb"]
  s.files = ["CHANGES", "doc", "doc/aem-manual", "doc/aem-manual/01_introduction.html", "doc/aem-manual/02_apioverview.html", "doc/aem-manual/03_packingandunpackingdata.html", "doc/aem-manual/04_references.html", "doc/aem-manual/05_targettingapplications.html", "doc/aem-manual/06_buildingandsendingevents.html", "doc/aem-manual/07_findapp.html", "doc/aem-manual/08_examples.html", "doc/aem-manual/aemreferenceinheritance.gif", "doc/aem-manual/index.html", "doc/appscript-manual", "doc/appscript-manual/01_introduction.html", "doc/appscript-manual/02_aboutappscripting.html", "doc/appscript-manual/03_quicktutorial.html", "doc/appscript-manual/04_gettinghelp.html", "doc/appscript-manual/05_keywordconversion.html", "doc/appscript-manual/06_classesandenums.html", "doc/appscript-manual/07_applicationobjects.html", "doc/appscript-manual/08_realvsgenericreferences.html", "doc/appscript-manual/09_referenceforms.html", "doc/appscript-manual/10_referenceexamples.html", "doc/appscript-manual/11_applicationcommands.html", "doc/appscript-manual/12_commandexamples.html", "doc/appscript-manual/13_performanceissues.html", "doc/appscript-manual/14_notes.html", "doc/appscript-manual/application_architecture.gif", "doc/appscript-manual/application_architecture2.gif", "doc/appscript-manual/finder_to_textedit_event.gif", "doc/appscript-manual/index.html", "doc/appscript-manual/relationships_example.gif", "doc/appscript-manual/ruby_to_itunes_event.gif", "doc/full.css", "doc/index.html", "doc/mactypes-manual", "doc/mactypes-manual/index.html", "doc/osax-manual", "doc/osax-manual/index.html", "extconf.rb", "LICENSE", "rb-appscript.gemspec", "README", "sample", "sample/AB_export_vcard.rb", "sample/AB_list_people_with_emails.rb", "sample/Add_iCal_event.rb", "sample/Create_daily_iCal_todos.rb", "sample/Export_Address_Book_phone_numbers.rb", "sample/Hello_world.rb", "sample/iTunes_top40_to_html.rb", "sample/List_iTunes_playlist_names.rb", "sample/Make_Mail_message.rb", "sample/Open_file_in_TextEdit.rb", "sample/Organize_Mail_messages.rb", "sample/Print_folder_tree.rb", "sample/Select_all_HTML_files.rb", "sample/Set_iChat_status.rb", "sample/Simple_Finder_GUI_Scripting.rb", "sample/Stagger_Finder_windows.rb", "sample/TextEdit_demo.rb", "src", "src/lib", "src/lib/_aem", "src/lib/_aem/aemreference.rb", "src/lib/_aem/codecs.rb", "src/lib/_aem/connect.rb", "src/lib/_aem/findapp.rb", "src/lib/_aem/mactypes.rb", "src/lib/_aem/send.rb", "src/lib/_aem/typewrappers.rb", "src/lib/_appscript", "src/lib/_appscript/defaultterminology.rb", "src/lib/_appscript/referencerenderer.rb", "src/lib/_appscript/reservedkeywords.rb", "src/lib/_appscript/safeobject.rb", "src/lib/_appscript/terminology.rb", "src/lib/aem.rb", "src/lib/appscript.rb", "src/lib/kae.rb", "src/lib/osax.rb", "src/rbae.c", "src/SendThreadSafe.c", "src/SendThreadSafe.h", "test", "test/README", "test/test_aemreference.rb", "test/test_appscriptcommands.rb", "test/test_appscriptreference.rb", "test/test_codecs.rb", "test/test_findapp.rb", "test/test_mactypes.rb", "test/test_osax.rb", "test/testall.sh", "TODO"]
  s.homepage = %q{http://rb-appscript.rubyforge.org/}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8")
  s.rubyforge_project = %q{rb-appscript}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Ruby appscript (rb-appscript) is a high-level, user-friendly Apple event bridge that allows you to control scriptable Mac OS X applications using ordinary Ruby scripts.}
  s.test_files = ["test/test_aemreference.rb", "test/test_appscriptcommands.rb", "test/test_appscriptreference.rb", "test/test_codecs.rb", "test/test_findapp.rb", "test/test_mactypes.rb", "test/test_osax.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
    else
    end
  else
  end
end
