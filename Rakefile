# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rake/extensiontask'

Rake::ExtensionTask.new('bsm/internal') do |ext|
  ext.ext_dir = 'ext/bsm/internal'
  ext.lib_dir = 'lib/bsm'
end

RSpec::Core::RakeTask.new(:spec)

task default: :spec
