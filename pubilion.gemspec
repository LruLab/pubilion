# frozen_string_literal: true

require_relative "lib/pubilion/version"

# guide at: https://bundler.io/guides/creating_gem.html

Gem::Specification.new do |spec|
  spec.name = "pubilion"
  spec.version = Pubilion::VERSION
  spec.authors = ["KL-Lru"]
  spec.email = ["26233827+KL-Lru@users.noreply.github.com"]

  spec.summary = "ActiveJob Backend for Google Cloud Pub/Sub"
  spec.description = "ActiveJob Backend for Google Cloud Pub/Sub"
  spec.homepage = "https://github.com/LruLab/pubilion"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activejob", ">= 6.1"
  spec.add_dependency "google-cloud-pubsub", "~> 2.0"
end
