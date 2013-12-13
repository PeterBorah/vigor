module Vigor
  class Rune
    attr_accessor :slot, :id, :description, :name, :tier

    def initialize(data)
      rune = data["rune"]

      @slot = data["runeSlotId"]
      @id = rune["id"]
      @description = rune["description"]
      @name = rune["name"]
      @tier = rune["tier"]
    end
  end
end
