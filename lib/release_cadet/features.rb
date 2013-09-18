module ReleaseCadet
  class Features < Command
    def execute release
      # TODO check for release number - fall back to normal branch name
      branch = @config['prefixes']['release'] + release
      output = []
      output << "<RC> Checking out the target release '#{release}'" if is_verbose?
      fetch = fetch_and_checkout(branch)
      output << fetch if is_verbose?
      output << "<RC> Merge commits between the release and master:" if is_verbose?
      output << `git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr %an)%Creset' --abbrev-commit --date=relative origin/master..#{branch} --merges`
      # output
      puts output.join("\n")
    end
  end
end
