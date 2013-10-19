require 'spec_helper'

describe "treasures/show" do
  before(:each) do
    @treasure = assign(:treasure, stub_model(Treasure,
      :description => "MyText",
      :time => Time.parse('00:02:26')
    ))
  end

  it "renders attributes in <p>"
end
