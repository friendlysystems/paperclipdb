require 'rake'
require 'rake/testtask'
require 'rdoc/task'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the paperclipdb plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib/**/*.rb'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the paperclipdb plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Paperclipdb'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "paperclipdb"
    gemspec.summary = "Database storage support for paperclip file attachment plugin."
    gemspec.description = "Database storage support for paperclip file attachment plugin. Forked from paperclipdb by Martin Caruso."
    gemspec.email = "chris@acid.cl"
    gemspec.homepage = "https://github.com/cberkhoff/paperclipdb"
    gemspec.authors = ["Christian Berkhoff","Martin Caruso"]
    gemspec.add_dependency 'paperclip'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
