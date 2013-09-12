module ReleaseCadet
  class Command
    attr_reader :config
    def initialize
      @config = ReleaseCadetCfg.config
    end
  end
end
