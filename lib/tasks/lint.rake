require 'rubocop/rake_task'

desc "Lint the application. (Ruby/Coffeescript/SASS)"
task :lint => ["lint:ruby", "lint:coffee", "lint:sass"]

namespace :lint do
  Rubocop::RakeTask.new(:ruby) do |task|
    task.options = [
      "-R"
    ]
    task.patterns = [
      'app/**/*.rb',
      'lib/**/*.rb'
    ]
  end

  desc "Lint Coffeescript."
  task :coffee do
    pass = system("coffeelint .")
    raise("failed coffeescript linting") unless pass
  end

  desc "Lint SASS"
  task :sass do
    puts "TODO: Lint SASS."
  end
end

Rake::Task['test'].enhance do
  Rake::Task['lint'].invoke
end
