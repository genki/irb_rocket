# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{irb_rocket}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Genki Takiuchi"]
  s.date = %q{2009-02-08}
  s.description = %q{irb plugin that makes irb #=> rocket}
  s.email = %q{genki@s21g.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["README", "Rakefile", "lib/irb_rocket.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://blog.s21g.com/genki}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{irb_rocket}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{irb plugin that makes irb #=> rocket}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<wirble>, [">= 0.1.2"])
    else
      s.add_dependency(%q<wirble>, [">= 0.1.2"])
    end
  else
    s.add_dependency(%q<wirble>, [">= 0.1.2"])
  end
end
