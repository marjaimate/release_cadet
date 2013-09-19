module ReleaseCadet
  class Clean < Command
    SUMMARY = "Deleting remote branches already merged into the production branch"

    def execute
      # Ask for a target branch when we don't have one
      output = []
      branch = @config['branches']['production']

      output << "<RC> Cleaning up branches that has been merged into #{branch}"
      output << "<RC> Warning this is a destructive operation!"
      output << "<RC> Checking out the target branch '#{branch}'" if is_verbose?
      fetch = fetch_and_checkout(branch)
      output << fetch if is_verbose?

      target_branches = `git branch -r --merged | grep -iv '\\(HEAD\\|#{branch}\\)'| sed -e 's/origin\\///g'`.split("\n").map do |a|
        a.gsub(/\s+/, "")
      end

      puts output.join("\n")
      output << "<RC> List of branches: #{target_branches.join(", ")}"

      target_branches.each do |b|
        print "<RC> Do you want to delete #{b} from origin? [yN] "
        should_delete = STDIN.gets.chomp
        if ["y", "yes"].include?(should_delete.downcase)
          puts "<RC> Deleting #{b} from origin..."
          puts "git push origin :#{b}"
        end
      end
    end
  end
end