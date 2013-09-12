#!/bin/bash
gem uninstall release_cadet
rm -rf ./release_cadet-*.gem
gem build release_cadet.gemspec
gem install release_cadet --local ./release_cadet-*.gem --no-ri --no-rdoc
