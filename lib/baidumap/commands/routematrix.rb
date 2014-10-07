module Baidumap
  module Commands
    class Routematrix < Command
      class << self

        # Create the Mercenary command for the Baidumap CLI for this Command
        def init_with_program(prog)
          prog.command(:routematrix) do |c|
            c.syntax      'routematrix [options]'
            c.description '批量线路查询接口'

            add_build_options(c)

            c.action do |args, options|
              Baidumap::Commands::Routematrix.process(options)
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
