module Baidumap
  module Commands
    class Geocoder < Command
      class << self

        # Create the Mercenary command for the Baidumap CLI for this Command
        def init_with_program(prog)
          prog.command(:geocoder) do |c|
            c.syntax      'geocoder [options]'
            c.description '提供从地址到经纬度坐标或者从经纬度坐标到地址的转换服务'

            c.option 'address',  '--address [ADDRESS]', '根指定地址进行坐标的反定向解析'
            c.option 'city',     '--city [CITY]', '地址所在的城市名'

            c.option 'coordtype',  '--coord [COORD]', '坐标的类型'
            c.option 'location',   '--location [LOCATION]', '根据经纬度坐标获取地址'
            c.option 'pois',       '--pois [POIS]', '是否显示指定位置周边的poi'

            add_build_options(c)

            c.action do |args, options|
              Baidumap::Commands::Geocoder.process(options)
            end
          end
        end

        # Call the API
        def process(options)
          Baidumap.logger.log_level = :error if options['quiet']

          require_relative '../uri_helper'

          uriHelper = Baidumap::UriHelper.new('geocoding')

          uriHelper.getResponse(uriHelper.generate_uri(options))

        end

      end # end of class << self
    end
  end
end
