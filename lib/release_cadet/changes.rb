module ReleaseCadet
  class Changes < Command
    SUMMARY = "Listing commit diff between two branches. Falls back to production branch to compare."

    def execute release, against=nil
      against ||= @config['branches']['production']
      output = []
      branch = verify_branch(release)
      fetch = fetch_all
      output << fetch if is_verbose?
      output << "<RC> Commits between the #{branch} and #{against}:\n" if is_verbose?
      output << `git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr %an)%Creset' --abbrev-commit --date=relative origin/#{against}..origin/#{branch}`

      puts output.join("\n")
    end
  end
end
