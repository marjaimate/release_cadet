module ReleaseCadet
  class Features < Command
    def execute release, against=nil
      against ||= @config['branches']['production']
      output = []
      branch = verify_branch(release)
      output << "<RC> Checking out the target '#{branch}'" if is_verbose?
      fetch = fetch_and_checkout(branch)
      output << fetch if is_verbose?
      output << "<RC> Merge commits between #{branch} and #{against}:" if is_verbose?
      output << `git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr %an)%Creset' --abbrev-commit --date=relative origin/#{against}..#{branch} --merges`
      # output
      puts output.join("\n")
    end
  end
end
