module Baidumap
  module Commands
    class Geoconv < Command
      class << self

        # Create the Mercenary command for the Baidumap CLI for this Command
        def init_with_program(prog)
          prog.command(:geoconv) do |c|
            c.syntax      'geoconv [options]'
            c.description '用于将常用的非百度坐标转换成百度地图中使用的坐标'

            c.option 'coords',  '--coords [COORDS]', '源坐标'
            c.option 'from',    '--from [FROM]', '源坐标类型'
            c.option 'to',      '--to [TO]', '目的坐标类型'

            add_build_options(c)

            c.action do |args, options|
              Baidumap::Commands::Geoconv.process(options)
            end
          end
        end

        # Call the API
        def process(options)
          Baidumap.logger.log_level = :error if options['quiet']

          require_relative '../uri_helper'

          uriHelper = Baidumap::UriHelper.new('geoconv')

          uriHelper.getResponse(uriHelper.generate_uri(options))

        end

      end # end of class << self
    end
  end
end
