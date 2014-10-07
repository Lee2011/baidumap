module Baidumap
  module Commands
    class Routematrix < Command
      class << self

        # Create the Mercenary command for the Baidumap CLI for this Command
        def init_with_program(prog)
          prog.command(:routematrix) do |c|
            c.syntax      'routematrix [options]'
            c.description '批量线路查询接口'

            c.option 'origins',  '--origins [ORIGINS]', '起点名称或经纬度'
            c.option 'destinations', '--destinations [DESTS]', '终点名称或经纬度'

            c.option 'mode', '--mode MODE', '导航模式'
            c.option 'coord_type',  '--coordtype [COORDTYPE]', '坐标的类型'
            c.option 'tactics',     '--tactics [TACTICS]', '导航策略'

            add_build_options(c)

            c.action do |args, options|
              Baidumap::Commands::Routematrix.process(options)
            end
          end
        end

        # Call the API
        def process(options)
          Baidumap.logger.log_level = :error if options['quiet']
          require_relative '../uri_helper'

          uriHelper = Baidumap::UriHelper.new('routematrix')

          uriHelper.getResponse(uriHelper.generate_uri(options))
        end

      end # end of class << self
    end
  end
end
