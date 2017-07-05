# frozen_string_literal: true

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:rspec) { |t|
  t.rspec_opts = ['--require', 'spec_helper']
}

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) { |t|
  t.options = ['--display-cop-names']
}

task default: [:rspec, :rubocop]
