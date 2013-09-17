module ReleaseCadet
  class Command
    attr_reader :config, :target_branches

    def initialize
      @config = ReleaseCadetCfg.config
    end

    # Get the list of target branches
    def get_target_branches
      unless @target_branches
        `git fetch --all`
        allowed_branches = @config['branches'].values
        allowed_branches << @config['prefixes']['release'] if @config['prefixes']['release']
        banned_branches = ['HEAD']
        target_branches = `git branch -r | grep -ie '\\(#{allowed_branches.join("\\|")}\\)' | grep -iv '\\(#{banned_branches.join("\\|")}\\)' | sed -e 's/origin\\///g'`
        @target_branches = target_branches.split("\n").map{|a| a.gsub(/\s+/, "")}
      end
      @target_branches
    end

    # We only would like to push to a list of branches only
    def valid_target? to
      get_target_branches.include?(to)
    end
  end
end
