unless Rails.env.production?
  require 'rubocop/rake_task'

  desc 'Lint the application. (Ruby/Coffeescript/SCSS)'
  task lint: ['lint:rails', 'lint:ruby', 'lint:coffee', 'lint:scss']

  namespace :lint do
    RuboCop::RakeTask.new(:rails) do |task|
      task.options = [
        '-R'
      ]
      task.patterns = [
        'app/**/*.rb'
      ]
    end

    RuboCop::RakeTask.new(:ruby) do |task|
      task.patterns = [
        'lib/**/*.rb',
        'lib/**/*.rake'
      ]
    end

    desc 'Lint Coffeescript'
    task :coffee do
      puts 'Running coffeelint...'
      pass = system('coffeelint .')
      fail 'failed coffeescript linting' unless pass
    end

    desc 'Lint SCSS'
    task :scss do
      puts 'Running scss-lint...'
      pass = system('scss-lint -x SelectorDepth,PlaceholderInExtend app')
      fail 'failed scss linting' unless pass
    end
  end

  Rake::Task['test'].enhance do
    Rake::Task['lint'].invoke
  end
end
