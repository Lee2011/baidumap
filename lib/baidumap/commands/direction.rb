module Baidumap
  module Commands
    class Direction < Command
      class << self

        # Create the Mercenary command for the Baidumap CLI for this Command
        def init_with_program(prog)
          prog.command(:direction) do |c|
            c.syntax      'direction [options]'
            c.description '提供公交、驾车、步行线路查询规划功能'

            c.option 'origin',  '--origin [ORIGIN]', '起点名称或经纬度'
            c.option 'destination', '--destination [DEST]', '终点名称或经纬度'

            c.option 'mode', '--mode MODE', '导航模式'
            c.option 'region', '-r', '--region REGION', '公交、步行导航时该参数必填'
            c.option 'origin_region', '--oregion OREGION', '起始点所在城市，驾车导航时必填'
            c.option 'destination_region', '--dregion DREGION', '终点所在城市，驾车导航时必填'

            c.option 'coord_type',  '--coordtype [COORDTYPE]', '坐标的类型'

            c.option 'waypoints',   '--waypoints [WAYPOINTS]', '分隔的地址名称或经纬度'
            c.option 'tactics',     '--tactics [TACTICS]', '导航策略'

            add_build_options(c)

            c.action do |args, options|
              Baidumap::Commands::Direction.process(options)
            end
          end
        end

        # Call the API
        def process(options)
          Baidumap.logger.log_level = :error if options['quiet']

          require_relative '../uri_helper'

          uriHelper = Baidumap::UriHelper.new('direction')

          uriHelper.getResponse(uriHelper.generate_uri(options))

        end

      end # end of class << self
    end
  end
end
