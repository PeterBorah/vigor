describe Vigor, :vcr do
  it "raises an exception when using a bad key" do
    Vigor.configure("bad_key")
    lambda { Vigor.summoner("semiel") }.should raise_error(Vigor::Error::Unauthorized)
  end

  it "raises an exception when no summoner name exists" do
    Vigor.configure(ENV["API_KEY"])
    lambda { Vigor.summoner("invalid1234") }.should raise_error(Vigor::Error::SummonerNotFound)
  end

  it "raises an exception when no summoner id exists" do
    Vigor.configure(ENV["API_KEY"])
    lambda { Vigor.summoner(0) }.should raise_error(Vigor::Error::SummonerNotFound)
  end

  it "raises an exception when the API is down" do
    stub_request(:get, "http://prod.api.pvp.net/api/lol/na/v1.1/summoner/by-name/semiel?api_key=#{ENV["API_KEY"]}").
        to_return(:status => 500, :body => "", :headers => {})
    Vigor.configure(ENV["API_KEY"])
    lambda { Vigor.summoner("semiel") }.should raise_error(Vigor::Error::InternalServerError)
  end

  it "raises an exception when Vigor has not been configured" do
    lambda { Vigor.summoner("semiel") }.should raise_error(Vigor::Error::NotConfigured)
  end

  it "raises an exception when Vigor is configured with an invalid region" do
    lambda { Vigor.configure(ENV["API_KEY"], "xyz") }.should raise_error(Vigor::Error::InvalidRegion)
  end
end
