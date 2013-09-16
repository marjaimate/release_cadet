require 'active_support/core_ext'

module ReleaseCadet
  class Help < Command
    def execute
      commands = ReleaseCadet.constants.select {|c| Class === ReleaseCadet.const_get(c)}
      commands.reject! {|c| [:Command, :ReleaseCadetCfg].include?(c)}
      puts "Release Cadet is an eager sidekick to help you dealing with releases.\n"
      puts "Usage: $ cadet COMMAND ARGUMENTS\n"
      puts "--------------------------------\n\n"
      puts "Available commands:\n"
      commands.each do |c|
        cmd_class_name = c.to_s.underscore
        cmd_class = "release_cadet/#{cmd_class_name}".camelize.constantize
        puts "- #{cmd_class_name} #{cmd_class.instance_method(:execute).parameters.join(" ")}\n"
        puts cmd_class.instance_method(:execute).parameters.to_s
      end
    end
  end
end
