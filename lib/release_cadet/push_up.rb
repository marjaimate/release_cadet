module ReleaseCadet
  class PushUp < Command
    def execute from, to
      puts "<RC> Checking out the target branch '#{to}'"
      puts `git fetch --all && git checkout #{to}`
      puts "<RC> Merging in #{from}"
      merge_output = `git merge origin/#{from}`
      if 0 == $?.exitstatus
        puts merge_output
        puts "<RC> Pushing up to origin"
        puts `git push origin #{to}`
      else
        puts "<RC> Merge failed, aborting. Please check your local branch!"
      end
    end
  end
end
