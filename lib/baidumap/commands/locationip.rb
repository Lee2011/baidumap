module Baidumap
  module Commands
    class Locationip < Command

      class << self

        # Create the Mercenary command for the Baidumap CLI for this Command
        def init_with_program(prog)
          prog.command(:locationip) do |c|
            c.syntax      'locationip [options]'
            c.description '根据IP返回对应位置信息'

            c.option 'ip', '-i', '--ip [IP]', 'ip地址'
            c.option 'coor', '-c', '--coor [COOR]', '输出的坐标格式'

            add_build_options(c)

            c.action do |args, options|
              Baidumap::Commands::Locationip.process(options)
            end
          end
        end

        # Call the API
        def process(options)
          Baidumap.logger.log_level = :error if options['quiet']
          require_relative '../uri_helper'

          uriHelper = Baidumap::UriHelper.new('locationip')

          uriHelper.getResponse(uriHelper.generate_uri(options))
        end

      end # end of class << self

    end
  end
end
