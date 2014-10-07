module Baidumap
  module Commands
    class Locationip < Command

      class << self

        # Create the Mercenary command for the Baidumap CLI for this Command
        def init_with_program(prog)
          prog.command(:locationip) do |c|
            c.syntax      'locationip [options]'
            c.description '根据IP返回对应位置信息的服务接口'

            add_build_options(c)

            c.option 'ip', '-i', '--ip [IP]', 'ip地址'
            c.option 'coor', '-c', '--coor [COOR]', '输出的坐标格式'
            c.option 'ak', '-a', '--ak AK', '用户密钥'
            c.option 'sn', '-s', '--sn SN', '用户的权限签名'

            c.action do |args, options|
              Baidumap::Commands::Locationip.process(options)
            end
          end
        end

        # Call the API
        def process(options)
          Baidumap.logger.log_level = :error if options['quiet']

        # options = configuration_from_options(options)
          setup()

        end

        def setup()
          require 'net/http'

          Net::HTTP.version_1_2   # 设定对象的运作方式

          uri = URI('http://api.map.baidu.com/place/v2/search?&q=%E5%B0%8F%E5%AD%A6&output=json&scope=2&page_num=0&region=%E6%B5%B7%E5%AE%81&ak=en6DYRcyeGnch8br16wS7FNj')
          # res = Net::HTTP.get_response(uri)

          # uri = URI('http://example.com/large_file')

          Net::HTTP.start(uri.host, uri.port) do |http|
            request = Net::HTTP::Get.new uri

            http.request request do |response|
              puts response.read_body
            end
          end

        end

      end # end of class << self

    end
  end
end
