describe Vigor::Summoner, :vcr do
  it "can fetch masteries" do
    vigor = Vigor::Client.new(ENV["API_KEY"])
    summoner = vigor.summoner("semiel")
    pages = summoner.mastery_pages
    pages.length.should == 4

    summoner.mastery_pages(:current).name.should == "AP"

    first_page = pages.select{|p| p.name = "Mastery Page 1"}.first
    first_page.should_not be_current

    hardiness = first_page.talents.select{|t| t.name = "Hardiness"}.first
    hardiness.id.should == 4233
  end
end
