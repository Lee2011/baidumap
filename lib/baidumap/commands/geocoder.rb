module Baidumap
  module Commands
    class Geocoder < Command
      class << self

        # Create the Mercenary command for the Baidumap CLI for this Command
        def init_with_program(prog)
          prog.command(:geocoder) do |c|
            c.syntax      'geocoder [options]'
            c.description '提供从地址到经纬度坐标或者从经纬度坐标到地址的转换服务'

            add_build_options(c)

            c.action do |args, options|
              Baidumap::Commands::Geocoder.process(options)
            end
          end
        end

        # Call the API
        def process(options)
          Baidumap.logger.log_level = :error if options['quiet']
          puts "该功能正在开发中，敬请期待 :)"
        end

      end # end of class << self
    end
  end
end
