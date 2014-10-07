baidumap
========

A ruby CLI tool for baidu map service API.

Usage:

  baidumap <subcommand> [options]

Options:
        -h, --help         Show this message
        -v, --version      Print the name and version
        -t, --trace        Show the full backtrace when an error occurs
            --ak AK        用户密钥, 必选，在lbs云官网注册的access key，作为访问的依据
            --sn SN        用户的权限签名, 可选，若用户所用ak的校验方式为sn校验时该参数必须
            --timestamp TIMESTAMP 设置sn后该值必填


Subcommands:
  locationip            根据IP返回对应位置信息的服务接口（包括坐标值、省份、城市、百度城市代码等）
        -i, --ip IP      IP地址, 可选，IP不出现，或者出现且为空字符串的情况下，会使用当前访问者的IP地址作为定位参数
        -c, --coor COOR  输出的坐标格式, 可选，coor不出现时，默认为百度墨卡托坐标；coor=bd09ll时，返回为百度经纬度坐标

  place                 Place API 提供区域检索POI服务、POI详情服务与团购信息检索服务、商家团购详情查询
            --search       区域POI查询
            --detail       POI详情
            --eventsearch  团购信息检索
            --eventdetail  商家团购详情查询

  #common search options:
        -q, --query QUERY  检索关键字，周边检索和矩形区域内检索支持多个关键字并集检索，不同关键字间以$符号分隔，最多支持10个关键字检索。如:”银行$酒店”  
        -t, --tag   TAG    标签项，与q组合进行检索
        -o, --output OUTPUT       输出格式为json或者xml
            --scope SCOPE         检索结果详细程度。取值为1 或空，则返回基本信息；取值为2，返回检索POI详细信息
            --filter FILTER       检索过滤条件，当scope取值为2时，可以设置filter进行排序
            --Pagesize PAGESIZE   范围记录数量，默认为10条记录，最大返回20条。多关键字检索时，返回的记录数为关键字个数*page_size
            --Pagenum PAGENUM     分页页码，默认为0,0代表第一页，1代表第二页，以此类推

  #search options:
        -r, --region REGION       检索区域，如果取值为“全国”或某省份，则返回指定区域的POI
        -b, --bounds BOUNDS       检索矩形区域
        -l, --location LOCATION   周边检索中心点，不支持多个点
            --radius RADIUS       周边检索半径，单位为米

  #detail options:
            --uid UID             poi的uid
            --UIDS UIDS           uid的集合，最多可以传入10个uid，多个uid之间用英文逗号分隔
        -o, --output OUTPUT       输出格式为json或者xml
            --scope SCOPE         检索结果详细程度。取值为1 或空，则返回基本信息；取值为2，返回检索POI详细信息

  #eventsearch options
        -q, --query QUERY  检索关键字
            --event EVENT  事件名称，可以是团购、打折或全部，目前只支持团购
        -r, --region REGION       检索区域，此字段必须填写城市名称或城市代码，不能为全国或1
        -l, --location LOCATION   检索中心点，注意顺序：纬度，经度
            --radius RADIUS       检索半径。默认1000米，最大可设置2000米。
        -b, --bounds BOUNDS       检索矩形Bound，注意顺序：左下角纬度，左下角经度，右上角纬度，右上角经度
        -o, --output OUTPUT       输出格式为json或者xml
            --filter FILTER       检索过滤条件
            --Pagesize PAGESIZE   返回记录数量，默认为10条记录，最大可设置为20条
            --Pagenum PAGENUM     分页页码，默认为0。 0代表第一页，1代表第二页，以此类推。 如果设置了此字段，则输出结果中含有total字段

  #eventdetail options
            --uid UID             poi的uid
        -o, --output OUTPUT       输出格式为json或者xml












[Web服务API](http://developer.baidu.com/map/index.php?title=webapi)
