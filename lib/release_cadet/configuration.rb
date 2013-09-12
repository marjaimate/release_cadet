require 'yaml'

module ReleaseCadetCfg
  class << self; attr_accessor :config ; end

  RC_ROOT = File.expand_path("../../", File.dirname(__FILE__))
  CONFIG_DIR        = File.join(RC_ROOT, "config")
  CONFIG_FILE       = File.join(CONFIG_DIR, "base.yml")
  RCRC_FILE = File.expand_path(".", ".rcrc")

  def self.read_configuration
    if File.exist?(CONFIG_FILE)
      configuration = YAML.load_file(CONFIG_FILE)
      if configuration 
        @config = configuration.freeze
      end
    else
      raise "configuration.yml not found!"
    end
    # Check for overrides 
    if File.exist?(RCRC_FILE)
      overrides = YAML.load_file(RCRC_FILE)
      if overrides.kind_of?(Hash)
        cfg = @config.dup
        overrides.each do |k, v|
          if cfg[k].kind_of?(Hash)
            cfg[k] = @config[k].merge(v)
          else
            cfg[k] = v
          end
        end
        @config = cfg.freeze
      end
    end
  end

  def self.config
    self.read_configuration if !@config
    @config
  end
end
