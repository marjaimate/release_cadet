module ReleaseCadet
  class Command
    attr_reader :config, :target_branches, :options

    def initialize options=[]
      @config = ReleaseCadetCfg.config
      @options = options
    end

    # Get the list of target branches
    def get_target_branches
      unless @target_branches
        fetch_all
        base = @config['branches']['production']
        allowed_branches = @config['branches'].values
        allowed_branches << @config['prefixes']['release'] if @config['prefixes']['release']
        banned_branches = ['HEAD']
        target_branches = `git branch -r origin/#{base} | grep -ie '\\(#{allowed_branches.join("\\|")}\\)' | grep -iv '\\(#{banned_branches.join("\\|")}\\)' | sed -e 's/origin\\///g'`
        @target_branches = target_branches.split("\n").map{|a| a.gsub(/\s+/, "")}
      end
      @target_branches
    end

    # We only would like to push to a list of branches only
    def valid_target? to
      get_target_branches.include?(to)
    end

    def fetch_all
      `git fetch --all`
    end

    def fetch_and_checkout branch
      fetch_all + `git checkout #{branch} && git pull origin #{branch} 2>&1`
    end

    def verify_branch branch
      if /^[0-9]{2}\.[0-9]{2}/.match(branch)
        release_branch = @config['prefixes']['release'] + branch
        if get_target_branches.include?(release_branch)
          branch = release_branch
        end
      end
      branch
    end

    # Boolean check on verbosity
    def is_verbose?
      options.include?("-v")
    end
  end
end
