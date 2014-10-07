module Baidumap
  module Commands
    class Geoconv < Command
      class << self

        # Create the Mercenary command for the Baidumap CLI for this Command
        def init_with_program(prog)
          prog.command(:geoconv) do |c|
            c.syntax      'geoconv [options]'
            c.description '用于将常用的非百度坐标转换成百度地图中使用的坐标'

            add_build_options(c)

            c.action do |args, options|
              Baidumap::Commands::Geoconv.process(options)
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
