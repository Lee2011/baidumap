# encoding: UTF-8

require 'uri'

# Scheme
# Userinfo
# Host
# Port
# Registry
# Path
# Opaque
# Query
# Fragment

module Baidumap
  class UriHelper

    def initialize(service_path)
      @service_path = service_path
    end

    def generate_uri(options)

      require_relative 'configuration'

      config = Baidumap::Configuration.new().get_config()

      uri = URI::HTTP.build(:scheme => config['api_scheme'],
                            :host => config['api_domain'],
                            :path => config[@service_path])

      if options['ak']
        command_options = options
      else
        command_options = options
        command_options['ak'] = config['user_ak']
      end

      uri.query = URI.encode_www_form(command_options)
      return uri
    end

    def getResponse(uri)
      require 'net/http'

      Net::HTTP.version_1_2   # 设定对象的运作方式

      Net::HTTP.start(uri.host, uri.port) do |http|
        request = Net::HTTP::Get.new uri

        http.request request do |response|
          puts response.read_body
        end
      end

    end

  end # end of class UriHelper
end
