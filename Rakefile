require 'rubygems'
require 'rake/gempackagetask'

GEM_NAME = "irb_rocket"
GEM_VERSION = "0.1.3"
AUTHOR = "Genki Takiuchi"
EMAIL = "genki@s21g.com"
HOMEPAGE = "http://blog.s21g.com/genki"
SUMMARY = "irb plugin that makes irb #=> rocket"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'irb_rocket'
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency('wirble', '>= 0.1.2')
  s.add_dependency('ruby-terminfo', '>= 0.1')
  s.require_path = 'lib'
  s.files = %w(README Rakefile) + Dir.glob("{lib,spec}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the plugin as a gem"
task :install => :gemspec do
  sh "gem build #{GEM_NAME}.gemspec"
  sh "sudo gem install #{GEM_NAME}-#{GEM_VERSION}.gem"
end

desc "Uninstall the gem"
task :uninstall => :gemspec do
  sh "sudo gem uninstall #{GEM_NAME} -v #{GEM_VERSION}"
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

desc "Run specs"
task :spec do
  sh "spec --color spec"
end

task :default => :spec
