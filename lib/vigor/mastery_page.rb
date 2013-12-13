module Vigor
  class MasteryPage < Page
    include Enumerable
    attr_accessor :talents

    def initialize(data)
      super

      return if data["talents"].nil?
      @talents = data["talents"].map {|talent| Talent.new(talent)}
    end

    def each(&block)
      @talents.each do |talent|
        block.call(talent)
      end
    end
  end
end
