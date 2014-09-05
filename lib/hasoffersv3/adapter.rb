class HasOffersV3
  class Adapter
    attr_reader :configuration

    def initialize(configuration, target)
      @configuration = configuration
      @target = target
    end

    def with_configuration(&block)
      previous_config = HasOffersV3.configuration
      HasOffersV3.configuration = @configuration
      begin
        yield
      ensure
        HasOffersV3.configuration = previous_config
      end
    end

    def method_missing(meth, *args, &block)
      if @target.respond_to?(meth)
        with_configuration do
          @target.send(meth, *args, &block)
        end
      else
        super
      end
    end
  end
end
