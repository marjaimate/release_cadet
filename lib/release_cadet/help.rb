require 'active_support/core_ext'

module ReleaseCadet
  class Help < Command
    def execute
      commands = ReleaseCadet.constants.select {|c| Class === ReleaseCadet.const_get(c)}
      puts "Release Cadet is an eager sidekick to help you dealing with releases.\n"
      puts "Usage: $ cadet COMMAND ARGUMENTS\n"
      puts "--------------------------------\n\n"
      puts "Available commands:\n"
      commands.each do |c|
        puts "#{c.to_underscore}\n"
      end
    end
  end
end
