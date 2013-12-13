module Vigor
  class Talent
    attr_accessor :id, :rank, :name

    def initialize(data)
      @id = data["id"]
      @rank = data["rank"]
      @name = data["name"]
    end
  end
end
