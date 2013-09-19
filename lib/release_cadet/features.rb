module ReleaseCadet
  class Features < Command
    SUMMARY = "Listing feature list (merged branches) between two branches. Falls back to production branch to compare."

    def execute release, against=nil
      against ||= @config['branches']['production']
      output = []
      branch = verify_branch(release)
      output << "<RC> Checking out the target '#{branch}'" if is_verbose?
      fetch = fetch_and_checkout(branch)
      output << fetch if is_verbose?
      output << "<RC> Merge commits between #{branch} and #{against}:" if is_verbose?
      output << `git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr %an)%Creset' --abbrev-commit --date=relative origin/#{against}..#{branch} --merges`
      output << "<RC> Branches merged into #{branch} and not into #{against}:"
      diff = get_merged_branches_in(branch) - get_merged_branches_in(against)
      output << diff.join("\n")
      # output
      puts output.join("\n")
    end

    def get_merged_branches_in branch
      fetch = fetch_and_checkout(branch)
      `git branch -r --merged`.split("\n").map do |a| 
        a.gsub(/\s+/, "").gsub(/origin\//,"")
      end
    end
  end
end
