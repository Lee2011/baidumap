# encoding: UTF-8

module Baidumap
  class Configuration < Hash

    # Default options. Overridden by values in _config.yml.
    # Strings rather than symbols are used for compatibility with YAML.
    DEFAULTS = {
      # Baidu server
      'api_domain'    => 'api.map.baidu.com',
      'test_ak'       => 'en6DYRcyeGnch8br16wS7FNj',


      # Where things are
      'source'        => Dir.pwd,
      'destination'   => File.join(Dir.pwd, '_site'),
      'plugins'       => '_plugins',
      'layouts'       => '_layouts',
      'data_source'   =>  '_data',
      'collections'   => nil,

      # Handling Reading
      'safe'          => false,
      'include'       => ['.htaccess'],
      'exclude'       => [],
      'keep_files'    => ['.git','.svn'],
      'encoding'      => 'utf-8',
      'markdown_ext'  => 'markdown,mkdown,mkdn,mkd,md',
      'textile_ext'   => 'textile',

      # Filtering Content
      'show_drafts'   => nil,
      'limit_posts'   => 0,
      'future'        => true,           # remove and make true just default
      'unpublished'   => false,

      # Plugins
      'whitelist'     => [],
      'gems'          => [],

      # Conversion
      'markdown'      => 'kramdown',
      'highlighter'   => 'pygments',
      'lsi'           => false,
      'excerpt_separator' => "\n\n",

      # Serving
      'detach'        => false,          # default to not detaching the server
      'port'          => '4000',
      'host'          => '0.0.0.0',
      'baseurl'       => '',

      # Backwards-compatibility options
      'relative_permalinks' => false,

      # Output Configuration
      'permalink'     => 'date',
      'paginate_path' => '/page:num',
      'timezone'      => nil,           # use the local timezone

      'quiet'         => false,
      'defaults'      => [],

      'maruku' => {
        'use_tex'    => false,
        'use_divs'   => false,
        'png_engine' => 'blahtex',
        'png_dir'    => 'images/latex',
        'png_url'    => '/images/latex',
        'fenced_code_blocks' => true
      },

      'rdiscount' => {
        'extensions' => []
      },

      'redcarpet' => {
        'extensions' => []
      },

      'kramdown' => {
        'auto_ids'      => true,
        'footnote_nr'   => 1,
        'entity_output' => 'as_char',
        'toc_levels'    => '1..6',
        'smart_quotes'  => 'lsquo,rsquo,ldquo,rdquo',
        'use_coderay'   => false,

        'coderay' => {
          'coderay_wrap'              => 'div',
          'coderay_line_numbers'      => 'inline',
          'coderay_line_number_start' => 1,
          'coderay_tab_width'         => 4,
          'coderay_bold_every'        => 10,
          'coderay_css'               => 'style'
        }
      },

      'redcloth' => {
        'hard_breaks' => true
      }
    }

    # Public: Turn all keys into string
    #
    # Return a copy of the hash where all its keys are strings
    def stringify_keys
      reduce({}) { |hsh,(k,v)| hsh.merge(k.to_s => v) }
    end

    # Public: Directory of the Baidumap source folder
    #
    # override - the command-line options hash
    #
    # Returns the path to the Baidumap source directory
    def source(override)
      override['source'] || self['source'] || DEFAULTS['source']
    end

    def quiet?(override = {})
      override['quiet'] || self['quiet'] || DEFAULTS['quiet']
    end

    def safe_load_file(filename)
      case File.extname(filename)
      when /\.toml/i
        TOML.load_file(filename)
      when /\.ya?ml/i
        SafeYAML.load_file(filename)
      else
        raise ArgumentError, "No parser for '#{filename}' is available. Use a .toml or .y(a)ml file instead."
      end
    end

    # Public: Generate list of configuration files from the override
    #
    # override - the command-line options hash
    #
    # Returns an Array of config files
    def config_files(override)
      # Be quiet quickly.
      Baidumap.logger.log_level = :error if quiet?(override)

      # Get configuration from <source>/_config.yml or <source>/<config_file>
      config_files = override.delete('config')
      if config_files.to_s.empty?
        default = %w[yml yaml].find(Proc.new { 'yml' }) do |ext|
          File.exists? Baidumap.sanitized_path(source(override), "_config.#{ext}")
        end
        config_files = Baidumap.sanitized_path(source(override), "_config.#{default}")
        @default_config_file = true
      end
      config_files = [config_files] unless config_files.is_a? Array
      config_files
    end

    # Public: Read configuration and return merged Hash
    #
    # file - the path to the YAML file to be read in
    #
    # Returns this configuration, overridden by the values in the file
    def read_config_file(file)
      next_config = safe_load_file(file)
      raise ArgumentError.new("Configuration file: (INVALID) #{file}".yellow) unless next_config.is_a?(Hash)
      Baidumap.logger.info "Configuration file:", file
      next_config
    rescue SystemCallError
      if @default_config_file
        Baidumap.logger.warn "Configuration file:", "none"
        {}
      else
        Baidumap.logger.error "Fatal:", "The configuration file '#{file}' could not be found."
        raise LoadError, "The Configuration file '#{file}' could not be found."
      end
    end

    # Public: Read in a list of configuration files and merge with this hash
    #
    # files - the list of configuration file paths
    #
    # Returns the full configuration, with the defaults overridden by the values in the
    # configuration files
    def read_config_files(files)
      configuration = clone

      begin
        files.each do |config_file|
          new_config = read_config_file(config_file)
          configuration = Utils.deep_merge_hashes(configuration, new_config)
        end
      rescue ArgumentError => err
        Baidumap.logger.warn "WARNING:", "Error reading configuration. " +
                     "Using defaults (and options)."
        $stderr.puts "#{err}"
      end

      configuration.fix_common_issues.backwards_compatibilize
    end

    # Public: Split a CSV string into an array containing its values
    #
    # csv - the string of comma-separated values
    #
    # Returns an array of the values contained in the CSV
    def csv_to_array(csv)
      csv.split(",").map(&:strip)
    end

    def fix_common_issues
      config = clone

      if config.key?('paginate') && (!config['paginate'].is_a?(Integer) || config['paginate'] < 1)
        Baidumap.logger.warn "Config Warning:", "The `paginate` key must be a" +
          " positive integer or nil. It's currently set to '#{config['paginate'].inspect}'."
        config['paginate'] = nil
      end

      config
    end
  end
end
