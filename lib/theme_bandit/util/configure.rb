module ThemeBandit
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Config.new
    yield configuration
    configuration
  end

  class Config
    attr_accessor :data

    def initialize(data = {})
      @data = {}
      update!(data)
    end

    def update!(data)
      data.each do |key, value|
        self[key.to_sym] = value
      end
    end

    def [](key)
      @data[key.to_sym]
    end

    def []=(key, value)
      @data[key.to_sym] = value
    end

    def keys
      @data.keys
    end

    def to_hash
      @data
    end

    def method_missing(sym, *args)
      if sym.to_s =~ /(.+)=$/
        self[Regexp.last_match[1]] = args.first
      else
        self[sym]
      end
    end
  end
end
