module ReleaseCadet
  class Features < Command
    def execute release
      branch = @config['prefixes']['release'] + release
      puts "<RC> Checking out the target release '#{release}'"
      puts `git fetch --all && git checkout #{branch}`
      puts "<RC> Merge commits between the release and master:\n"
      puts `git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr %an)%Creset' --abbrev-commit --date=relative origin/master..#{branch} --merges`
    end
  end
end
