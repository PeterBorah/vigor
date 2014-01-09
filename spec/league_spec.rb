describe Vigor::League, :vcr do
  before (:each) do
    Vigor.configure(ENV["API_KEY"])
  end


end
