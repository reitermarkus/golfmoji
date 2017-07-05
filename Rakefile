# frozen_string_literal: true

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:rspec)

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: [:rspec, :rubocop]
