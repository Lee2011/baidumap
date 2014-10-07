module Baidumap
  class Command

    class << self

      # A list of subclasses of Baidumap::Command
      def subclasses
        @subclasses ||= []
      end

      # Keep a list of subclasses of Baidumap::Command every time it's inherited
      # Called automatically.
      #
      # base - the subclass
      #
      # Returns nothing
      def inherited(base)
        subclasses << base
        super(base)
      end

      # Create a full Baidumap configuration with the options passed in as overrides
      #
      # options - the configuration overrides
      #
      # Returns a full Baidumap configuration
      def configuration_from_options(options)
        Baidumap.configuration(options)
      end

      # Add common options to a command for building configuration
      #
      # c - the Baidumap::Command to add these options to
      #
      # Returns nothing
      def add_build_options(c)
        c.option 'AK', '--ak AK', String, '用户密钥, 在lbs云官网注册的access key，作为访问的依据'
        c.option 'SN', '--sn SN', String, '用户的权限签名'
        c.option 'timestamp', '--timestamp TIMESTAMP', '设置sn后该值必填'

        c.option 'config',  '--config CONFIG_FILE[,CONFIG_FILE2,...]', Array, 'Custom configuration file'
        c.option 'quiet',   '--quiet', 'Silence output.'
        c.option 'verbose', '--verbose', 'Print verbose output.'
      end

    end
  end # class Command
end # module Baidumap
