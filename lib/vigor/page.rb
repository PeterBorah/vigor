module Vigor
  class Page
    attr_accessor :name

    def initialize(data)
      @name = data["name"]
      @current = data["current"]
    end

    def current?
      @current
    end
  end
end
