module ReleaseCadet
  class PushUp < Command
    def execute from, to
      puts "<RC> Checking out the target branch '#{to}'"
      `git fetch --all && git checkout #{to}`
      puts "<RC> Merging in #{from}"
      `git merge origin/#{from}`
      puts "<RC> Pushing up to origin"
      `git push origin #{to}`
    end
  end
end
