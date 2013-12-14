describe Vigor::Client, :vcr do
  it "can find a summoner by name" do
    vigor = Vigor::Client.new(ENV["API_KEY"])
    summoner = vigor.summoner("semiel")
    summoner.id.should == 23893133
    summoner.name.should == "Semiel"
    summoner.profile_icon_id.should == 518
    summoner.level.should == 30
  end

  it "can find a summoner by id" do
    vigor = Vigor::Client.new(ENV["API_KEY"])
    summoner = vigor.summoner(23893133)
    summoner.id.should == 23893133
    summoner.name.should == "Semiel"
    summoner.profile_icon_id.should == 518
    summoner.level.should == 30
  end

  it "works on servers other than NA" do
    vigor = Vigor::Client.new(ENV["API_KEY"], "euw")
    summoner = vigor.summoner("Froggen")
    summoner.id.should == 19531813
    summoner.name.should == "Froggen"
    summoner.level.should == 30
  end

  it "can find summoners whose names have whitespace" do
    vigor = Vigor::Client.new(ENV["API_KEY"])
    summoner = vigor.summoner("Best Riven NA")
    summoner.id.should == 32400810
    summoner.name.should == "Best Riven NA"
    summoner.level.should == 30
  end

  it "raises an exception when using a bad key" do
    vigor = Vigor::Client.new("bad_key")
    lambda { vigor.summoner("semiel") }.should raise_error(Vigor::Error::Unauthorized)
  end

  it "raises an exception when no summoner name exists" do
    vigor = Vigor::Client.new(ENV["API_KEY"])
    lambda { vigor.summoner("invalid1234") }.should raise_error(Vigor::Error::SummonerNotFound)
  end

  it "raises an exception when no summoner id exists" do
    vigor = Vigor::Client.new(ENV["API_KEY"])
    lambda { vigor.summoner(0)}.should raise_error(Vigor::Error::SummonerNotFound)
  end

  it "raises an exception when the API is down" do
    stub_request(:get, "http://prod.api.pvp.net/api/lol/na/v1.1/summoner/by-name/semiel?api_key=#{ENV["API_KEY"]}").
        to_return(:status => 500, :body => "", :headers => {})
    vigor = Vigor::Client.new(ENV["API_KEY"])
    lambda { vigor.summoner("semiel") }.should raise_error(Vigor::Error::InternalServerError)
  end

end
