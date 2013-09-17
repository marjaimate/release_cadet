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
        allowed_branches << @config['prefixes']['releases']
        banned_branches = ['HEAD']
        @target_branches = `git branch -r | grep -ie '\(#{allowed_branches.join("\|")}\)' | grep -iv '\(#{banned_branches.join("\|")}\)' | sed -e 's/origin\///g'`
      end
      @target_branches
    end

    # We only would like to push to a list of branches only
    def valid_target? to
      get_target_branches.include?(to)
    end
  end
end
