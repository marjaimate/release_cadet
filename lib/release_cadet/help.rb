require 'active_support/core_ext'

module ReleaseCadet
  class Help < Command
    def execute
      commands = ReleaseCadet.constants.select {|c| Class === ReleaseCadet.const_get(c)}
      commands.reject! {|c| [:Command, :ReleaseCadetCfg].include?(c)}
      puts "Release Cadet is an eager sidekick to help you dealing with releases.\n"
      puts "Usage: $ cadet [OPTIONS] COMMAND ARGUMENTS\n"
      puts "--------------------------------\n\n"
      puts "Available options:\n"
      puts " -v\tVerbose\n"
      puts " -h\tHelp\n"
      puts "--------------------------------\n\n"
      puts "Available commands:\n"
      commands.each do |c|
        cmd_class_name = c.to_s.underscore
        cmd_class = "release_cadet/#{cmd_class_name}".camelize.constantize
        param_list = cmd_class.instance_method(
          :execute
        ).parameters.map{|a| a[0].to_s == "opt" ? "[#{a[1].upcase}]" : a[1].upcase }
        puts "- #{cmd_class_name} #{param_list.join(" ")}\n"
      end
    end
  end
end
