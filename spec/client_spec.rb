require 'vigor'

describe Vigor::Client do
  it "can find a summoner by name" do
    vigor = Vigor::Client.new(ENV["API_KEY"])
    summoner = vigor.summoner("semiel")
    summoner.id.should == 23893133
    summoner.name.should == "Semiel"
    summoner.profile_icon_id.should == 518
    summoner.level == 30
  end

  it "can find a summoner by name" do
    vigor = Vigor::Client.new(ENV["API_KEY"])
    summoner = vigor.summoner(23893133)
    summoner.id.should == 23893133
    summoner.name.should == "Semiel"
    summoner.profile_icon_id.should == 518
    summoner.level == 30
  end
end
