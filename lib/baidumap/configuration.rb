# encoding: UTF-8

module Baidumap
  class Configuration < Hash

    # Default options. Overridden by values in _config.yml.
    # Strings rather than symbols are used for compatibility with YAML.
    DEFAULTS = {
      # Baidu web service api server
      'api_scheme'        => 'http',
      'api_domain'        => 'api.map.baidu.com',
      'user_ak'           => 'en6DYRcyeGnch8br16wS7FNj',

      # Place API V2.0
      'place_search'      => '/place/v2/search',
      'place_detail'      => '/place/v2/detail',
      'place_eventsearch' => '/place/v2/eventsearch',
      'place_eventdetail' => '/place/v2/eventdetail',

      # Geocoding API v2.0
      'geocoding'         => '/geocoder/v2/',

      # Direction API
      'direction'         => '/direction/v1',

      # Route Matrix API
      'routematrix'       => '/direction/v1/routematrix',

      # IP定位API
      'locationip'        => '/location/ip',

      # 坐标转换API
      'geoconv'           => '/geoconv/v1/'
    }


    def get_config
      require 'yaml'

      config_file = File.join(ENV['HOME'],'.db_backup.rc.yaml')

      if File.exists? config_file
        config_options = YAML.load_file(config_file)
        DEFAULTS.merge!(config_options)
      else
        DEFAULTS
      end
    end

  end
end
