module Baidumap
  module Commands
    class Direction < Command
      class << self

        # Create the Mercenary command for the Baidumap CLI for this Command
        def init_with_program(prog)
          prog.command(:direction) do |c|
            c.syntax      'direction [options]'
            c.description '提供公交、驾车、步行线路查询规划功能'

            add_build_options(c)

            c.action do |args, options|
              Baidumap::Commands::Direction.process(options)
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
