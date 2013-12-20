describe Vigor, :vcr do

  it "works on servers other than NA" do
    Vigor.configure(ENV["API_KEY"], "euw")
    summoner = Vigor.summoner("Froggen")
    expect(summoner.id).to eq(19531813)
    expect(summoner.name).to eq("Froggen")
    expect(summoner.level).to eq(30)
  end

  it "can be configured for region case-insensitively" do
    Vigor.configure(ENV["API_KEY"], "EuW")
    summoner = Vigor.summoner("Froggen")
    expect(summoner.id).to eq(19531813)
    expect(summoner.name).to eq("Froggen")
    expect(summoner.level).to eq(30)
  end
end
