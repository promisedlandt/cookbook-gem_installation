require "bundler/setup"
require "rubocop/rake_task"

desc "Run rubocop linter"
RuboCop::RakeTask.new(:rubocop) do |task|
  task.formatters = %w(simple)
end

desc "for travis-ci run"
task travis: :default

task lint: :rubocop

task default: :lint
