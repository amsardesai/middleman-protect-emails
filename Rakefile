require 'bundler/gem_tasks'
require 'cucumber/rake/task'
require 'rake/clean'

Cucumber::Rake::Task.new(:cucumber, 'Run features that should pass') do |t|
  t.cucumber_opts = "--color --tags ~@wip --strict --format #{ENV['CUCUMBER_FORMAT'] || 'Fivemat'}"
end

task test: ['cucumber']
task default: :test
