module Vigor
  class RunePage < Page
    include Enumerable
    attr_accessor :runes, :id

    def initialize(data)
      super
      @id = data["id"]

      return if data["slots"].nil?
      @runes = data["slots"].map {|slot| Rune.new(slot)}
    end

    def each(&block)
      @runes.each do |rune|
        block.call(rune)
      end
    end
  end
end
