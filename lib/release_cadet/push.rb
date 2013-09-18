module ReleaseCadet
  class Push < Command
    def execute from, to=nil
      # Ask for a target branch when we don't have one
      if to.nil?
        puts "<RC> No target branch specified, please select one:"
        puts get_target_branches.join("\n")
        to = gets
      end

      if valid_target?(to)
        puts "<RC> Checking out the target branch '#{to}'"
        puts `git checkout #{to}`
        puts "<RC> Merging in #{from}"
        merge_output = `git merge origin/#{from}`
        if 0 == $?.exitstatus
          puts merge_output
          puts "<RC> Do you want to push the results?\n [Y/n]"
          should_push = gets
          if ["y", "yes", ""].include?(should_push.downcase)
            puts "<RC> Pushing up to origin"
            puts `git push origin #{to}`
          end
          exit 0
        else
          puts "<RC> Merge failed, aborting. Please check your local branch and resolve all conflicts!"
          exit 1
        end
      else
        puts "<RC> Target branch not accepted. Allowed target branches:"
        puts get_target_branches.join("\n")
        exit 2
      end
    end
  end
end
