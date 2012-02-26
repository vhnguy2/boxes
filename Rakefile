require "rake/testtask"

namespace "test" do
  desc "Unit tests for Location API"
  Rake::TestTask.new(:units) do |t|
    t.libs += ["test"]
    t.test_files = Dir["test/*_test.rb"]
    t.verbose = true
  end
end
