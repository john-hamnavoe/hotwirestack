# PR has been done on view_component to register the view components directory
# but it's not released yet
require "rails/code_statistics"
Rails::CodeStatistics.register_directory("ViewComponent tests", "test/components", test_directory: true)
