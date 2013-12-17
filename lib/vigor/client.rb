require 'httparty'

class Vigor
  class Client
    include HTTParty
    # debug_output $stderr

    private

    def self.get(path, options = {})
      raise Vigor::Error::NotConfigured, "Vigor must be configured with an API key" if Client.base_uri.nil?
      response = super
      raise Vigor::Error.from_status(response.code), response.message unless response.code == 200
      return response
    end
  end
end
