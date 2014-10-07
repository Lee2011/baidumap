$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

# Require all of the Ruby files in the given directory.
#
# path - The String relative path from here to the directory.
#
# Returns nothing.
def require_all(path)
  glob = File.join(File.dirname(__FILE__), path, '*.rb')
  Dir[glob].each do |f|
    require f
  end
end

# rubygems
require 'rubygems'

# stdlib
require 'logger'

module Baidumap

  # internal requires
  autoload :VERSION,             'baidumap/version'

  # extensions
  require 'baidumap/command'

  # Public: Tells you which Baidumap environment you are building in so you can
  # skip tasks if you need to.

  def self.env
    ENV["BAIDUMAP_ENV"] || "development"
  end

  # Public: Generate a baidumap configuration Hash by merging the default
  # options with anything in _config.yml, and adding the given options on top.
  #
  # override - A Hash of config directives that override any options in both
  #            the defaults and the config file. See baidumap::Configuration::DEFAULTS for a
  #            list of option names and their defaults.
  #
  # Returns the final configuration Hash.
  def self.configuration(override)
    config = Configuration[Configuration::DEFAULTS]
    override = Configuration[override].stringify_keys
    config = config.read_config_files(config.config_files(override))

    # Merge DEFAULTS < _config.yml < override
    config = Utils.deep_merge_hashes(config, override).stringify_keys
    set_timezone(config['timezone']) if config['timezone']

    config
  end

  # Static: Set the TZ environment variable to use the timezone specified
  #
  # timezone - the IANA Time Zone
  #
  # Returns nothing
  def self.set_timezone(timezone)
    ENV['TZ'] = timezone
  end

  def self.logger
    @logger ||= LogAdapter.new(Stevenson.new)
  end

  def self.logger=(writer)
    @logger = LogAdapter.new(writer)
  end

  # Public: File system root
  #
  # Returns the root of the filesystem as a Pathname
  def self.fs_root
    @fs_root ||= "/"
  end

  def self.sanitized_path(base_directory, questionable_path)
    clean_path = File.expand_path(questionable_path, fs_root)
    clean_path.gsub!(/\A\w\:\//, '/')
    unless clean_path.start_with?(base_directory)
      File.join(base_directory, clean_path)
    else
      clean_path
    end
  end
end

require_all 'baidumap/commands'
