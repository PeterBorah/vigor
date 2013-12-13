require 'httparty'

module Vigor
  class Client
    include HTTParty
    # debug_output $stderr

    def initialize(api_key, region = "na")
      self.class.default_params :api_key => api_key
      self.class.base_uri "http://prod.api.pvp.net/api/lol/#{region}/v1.1"
    end

    def summoner(lookup_value)
      if lookup_value.is_a? String
        return Summoner.new(self.class.get("/summoner/by-name/" + lookup_value.gsub(/\s+/, "")))
      else
        return Summoner.new(self.class.get("/summoner/" + lookup_value.to_s))
      end
    end
  end
end
