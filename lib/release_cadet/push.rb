module ReleaseCadet
  class Push < Command
    SUMMARY = "Pushes up specified branch to a target. Performs the merge, exits if merge fails."

    def execute from, to=nil
      # Ask for a target branch when we don't have one
      output = []
      from = verify_branch(from)
      if to.nil?
        puts "<RC> No target branch specified, please select one from the list:"
        puts get_target_branches.join("\n")
        print "> "
        to = STDIN.gets.chomp
      end

      if valid_target?(to)
        output << "<RC> Checking out the target branch '#{to}'" if is_verbose?
        fetch = fetch_and_checkout(to)
        output << fetch if is_verbose?
        output << "<RC> Merging in #{from}" if is_verbose?
        merge_output = `git merge origin/#{from} 2>&1`
        if 0 == $?.exitstatus
          output << merge_output if is_verbose?
          puts output.join("\n")
          print "<RC> Do you want to push the results?\n [Y/n]"
          should_push = STDIN.gets.chomp
          if ["y", "yes", ""].include?(should_push.downcase)
            puts "<RC> Pushing up to origin"
            puts `git push origin #{to}`
          end
          exit 0
        else
          puts output.join("\n")
          puts "<RC> Merge returned with error. Please check your local branch!"
          exit 1
        end
      else
        puts output.join("\n")
        puts "<RC> Target branch '#{to}' not accepted. Allowed target branches:"
        puts get_target_branches.join("\n")
        exit 2
      end
    end
  end
end
