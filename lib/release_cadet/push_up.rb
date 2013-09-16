module ReleaseCadet
  class PushUp < Command
    def execute from, to
      puts "<RC> Checking out the target branch '#{to}'"
      puts `git fetch --all && git checkout #{to}`
      puts "<RC> Merging in #{from}"
      puts `git merge origin/#{from}`
      puts "<RC> Pushing up to origin"
      puts `git push origin #{to}`
    end
  end
end
