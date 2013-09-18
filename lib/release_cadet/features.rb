module ReleaseCadet
  class Features < Command
    def execute release
      output = []
      branch = verify_branch(release)
      output << "<RC> Checking out the target '#{branch}'" if is_verbose?
      fetch = fetch_and_checkout(branch)
      output << fetch if is_verbose?
      output << "<RC> Merge commits between #{branch} and master:" if is_verbose?
      output << `git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr %an)%Creset' --abbrev-commit --date=relative origin/master..#{branch} --merges`
      # output
      puts output.join("\n")
    end
  end
end