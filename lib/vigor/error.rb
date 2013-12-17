class Vigor
  class Error

    def self.from_status(status)
      case status
        when 400
          BadRequest
        when 401
          Unauthorized
        when 404
          SummonerNotFound
        when 500
          InternalServerError
        else
          ApiError
      end
    end

    class ApiError < StandardError; end

    # 400 response - invalid API endpoint. Should never be raised if gem build is stable.
    class BadRequest < ApiError; end

    # 401 response - when API_KEY is missing or invalid.
    class Unauthorized < ApiError; end

    # 404 response - no summoner found.
    class SummonerNotFound < ApiError; end

    # 500 response - when Riot's API is down.
    class InternalServerError < ApiError; end

    # non-api errors below
    class NotConfigured < StandardError; end
    class InvalidRegion < StandardError; end
  end
end
