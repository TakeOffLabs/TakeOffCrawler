# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "take_off_crawler/version"

Gem::Specification.new do |s|
  s.name        = "take_off_crawler"
  s.version     = TakeOffCrawler::VERSION
  s.authors     = ["Flavia Grosan"]
  s.email       = ["me@flaviagrosan.com"]
  s.homepage    = ""
  s.summary     = %q{Parses a text to identify and crawl URLs like image links, youtube.com, nytimes.com and many others}
  s.description = %q{This gem can be used for parsing posts and user provided information.}

  s.rubyforge_project = "take_off_crawler"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_dependency "rake"
  s.add_dependency "nokogiri"
end
