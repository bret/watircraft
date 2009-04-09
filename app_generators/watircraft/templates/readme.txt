
How to create a WatirCraft Project
==================================

 1. DONE - Run the WatirCraft command: watircraft projectname
 2. Edit config/environments.yml to include the base url of your application.
 3. CD into your new project directory. All of the following commands assume 
    that your current directory is the base of your project. 

WatirCraft allows you to create Rspec tests, Cucumber tests or both.

Rspec Tests
 
 4. Create a test: script\generate spec testname
 5. Edit the file, adding Watir commands where specified.
 6. Run one test: ruby test\specs\testname_spec.rb
    Or you can just use F5 if using the Scite editor.
 7. Run all spec-tests: rake spec

Cucumber Tests

 8. Create a feature. Place your feature-tests in the test\features directory.
    They should follow the standard cucumber format.
 9. Create Steps File: script\generate steps filename
10. Dry Run: cucumber test\features\featurename
    This will create step outlines.
11. Paste these step outlines into the step definition templates.
12. Add Watir command to these steps to make them work.
13. Run one feature: cucumber test\features\featurename
14. Run all features: rake features

Pages are optional and can be used with either Rspec or Cucumber tests.

15. Create a page: script\generate page pagename
16. Pages can be referenced from rspec tests or cucumber steps.

Methods are optional cna be used with either Rspec or Cucumber tests.

17. Create a method: script\generate method methodname
18. Methods can be referenced from rspec tests, cucumber steps or from
    other methods.

Enter "script\generate" to see a complete list of WatirCraft files that
you can create.
