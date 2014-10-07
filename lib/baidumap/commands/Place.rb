module Baidumap
  module Commands
    class Place < Command

      class << self

        # Create the Mercenary command for the Baidumap CLI for this Command
        def init_with_program(prog)
          prog.command(:place) do |c|
            c.syntax      'place <subcommand> [options]'
            c.description '提供区域检索服务与团购信息检索服务'

            c.command(:search) do |s|
              s.syntax      'search [options]'
              s.description '区域POI查询'

              #如果取值为“全国”或某省份，则返回指定区域的POI
              s.option 'region', '-r', '--region REGION', '检索区域'
              s.option 'bounds', '-b', '--bounds BOUNDS', '检索矩形区域'
              s.option 'location', '-l', '--location LOCATION', '周边检索中心点，不支持多个点'
              s.option 'radius',  '--radius RADIUS',  '周边检索半径，单位为米'

              s.action do |args, options|
                Baidumap::Commands::Place.processSearch(options)
              end

            end

            c.command(:detail) do |d|
              d.syntax      'detail [options]'
              d.description 'POI详情'

              d.option 'uid', '--uid UID', 'POI 的 uid'
              d.option 'uids', '--uids UIDS', 'uid的集合，最多可以传入10个uid，多个uid之间用英文逗号分隔'

              d.action do |args, options|
                Baidumap::Commands::Place.processDetail(options)
              end
            end

            c.command(:eventsearch) do |e|
              e.syntax      'eventsearch [options]'
              e.description '团购信息检索'

              e.option 'event', '--event EVENT',  '事件名称，可以是团购、打折或全部，目前只支持团购'
              e.option 'region', '-r', '--region REGION', '检索区域，此字段必须填写城市名称或城市代码'
              e.option 'location', '-l', '--location LOCATION',  '检索中心点，注意顺序：纬度，经度'
              e.option 'radius', '--radius RADIUS', '检索半径。默认1000米，最大可设置2000米'
              #注意顺序：左下角纬度，左下角经度，右上角纬度，右上角经度
              e.option 'bounds', '-b', '--bounds BOUNDS', '检索矩形Bound'

              e.action do |args, options|
                Baidumap::Commands::Place.processEventsearch(options)
              end

            end

            c.command(:eventdetail) do |f|
              f.syntax      'eventdetail [options]'
              f.description '商家团购详情查询'

              f.option 'uid', '--uid UID', 'POI 的 uid'

              f.action do |args, options|
                Baidumap::Commands::Place.processEventdetail(options)
              end

            end

            #周边检索和矩形区域内检索支持多个关键字并集检索，不同关键字间以$符号分隔，最多支持10个关键字检索。如:”银行$酒店”
            c.option 'query', '-q', '--query QUERY', String, '检索关键字'
            c.option 'tag',   '-t', '--tag TAG', '标签项，与 -q 组合进行检索'
            c.option 'output','-o', '--output OUTPUT', '输出格式为json或者xml'

            #取值为1 或空，则返回基本信息；取值为2，返回检索POI详细信息
            c.option 'scope', '--scope SCOPE', '检索结果详细程度'
            #当scope取值为2时，可以设置filter进行排序
            c.option 'filter','--filter FILTER', '检索过滤条件'
            #多关键字检索时，返回的记录数为关键字个数*page_size
            c.option 'pagesize','--Pagesize PAGESIZE', '范围记录数量，默认为10条记录，最大返回20条'
            c.option 'pagenum', '--Pagenum PAGENUM',   '分页页码，默认为0, 0代表第一页，1代表第二页，以此类推'

            add_build_options(c)

            c.action do |args, options|
              Baidumap::Commands::Place.process(options)
            end
          end
        end

        # Call the API
        def process(options)
          Baidumap.logger.log_level = :error if options['quiet']

          #options = configuration_from_options(options)
          setup()

        end

        def processSearch(options)
          p options
          p options.class
          uri = buildURI(options)
          puts uri
        end

        def processDetail(options)
          p options
        end

        def processEventsearch(options)
          p options
        end

        def processEventdetail(options)
          p options
        end

        def setup()
          require 'net/http'

          Net::HTTP.version_1_2   # 设定对象的运作方式

          #uri = URI('http://api.map.baidu.com/place/v2/search?&q=%E5%B0%8F%E5%AD%A6&output=json&scope=2&page_num=0&region=%E6%B5%B7%E5%AE%81&ak=en6DYRcyeGnch8br16wS7FNj')
          # res = Net::HTTP.get_response(uri)

          # uri = URI('http://example.com/large_file')

          uri = URI('http://example.com/index.html')
          params = { :limit => 10, :page => 3 }
          uri.query = URI.encode_www_form(params)
          puts uri
          puts uri.query

        end

        def buildURI(options)
          require 'uri'
          uri = URI('http://api.map.baidu.com/place/v2/search')
          uri.query = URI.encode_www_form(options)
          return uri
        end

      end # end of class << self

    end
  end
end
