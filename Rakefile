# frozen_string_literal: true

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:cucumber) { |t|
  t.cucumber_opts = '--format pretty'
}

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:rspec) { |t|
  t.rspec_opts = [
    '--require', 'spec_helper',
    '--format', 'documentation'
  ]
}

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) { |t|
  t.options = ['--display-cop-names']
}

task default: [:cucumber, :rspec, :rubocop]
