describe Vigor, :vcr do
  it "raises an exception when using a bad key" do
    Vigor.configure("bad_key")
    expect{ Vigor.summoner("semiel") }.to raise_error(Vigor::Error::Unauthorized)
  end

  it "raises an exception when no summoner name exists" do
    Vigor.configure(ENV["API_KEY"])
    expect{ Vigor.summoner("invalid1234") }.to raise_error(Vigor::Error::SummonerNotFound)
  end

  it "raises an exception when no summoner id exists" do
    Vigor.configure(ENV["API_KEY"])
    expect{ Vigor.summoner(0) }.to raise_error(Vigor::Error::SummonerNotFound)
  end

  it "raises an exception when the API is down" do
    stub_request(:get, "http://prod.api.pvp.net/api/lol/na/v1.2/summoner/by-name/semiel?api_key=#{ENV["API_KEY"]}").
        to_return(:status => 500, :body => "", :headers => {})
    Vigor.configure(ENV["API_KEY"])
    expect{ Vigor.summoner("semiel") }.to raise_error(Vigor::Error::InternalServerError)
  end

  it "raises an exception when Vigor has not been configured" do
    expect{ Vigor.summoner("semiel") }.to raise_error(Vigor::Error::NotConfigured)
  end

  it "raises an exception when Vigor is configured with an invalid region" do
    expect{ Vigor.configure(ENV["API_KEY"], "xyz") }.to raise_error(Vigor::Error::InvalidRegion)
  end
end
