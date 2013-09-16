module ReleaseCadet
  class Changes < Command
    def execute release
      branch = @config['prefixes']['release'] + release
      puts "<RC> Checking out the target release '#{release}'"
      `git fetch --all && git checkout #{branch}`
      puts "<RC> Merge commits between the release and master:\n"
      `git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr %an)%Creset' --abbrev-commit --date=relative origin/master..#{branch}`
    end
  end
end
