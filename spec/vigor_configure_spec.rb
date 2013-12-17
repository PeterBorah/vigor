describe Vigor, :vcr do

  it "works on servers other than NA" do
    Vigor.configure(ENV["API_KEY"], "euw")
    summoner = Vigor.summoner("Froggen")
    summoner.id.should == 19531813
    summoner.name.should == "Froggen"
    summoner.level.should == 30
  end

  it "can be configured for region case-insensitively" do
    Vigor.configure(ENV["API_KEY"], "EuW")
    summoner = Vigor.summoner("Froggen")
    summoner.id.should == 19531813
    summoner.name.should == "Froggen"
    summoner.level.should == 30
  end
end
