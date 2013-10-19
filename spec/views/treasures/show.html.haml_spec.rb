require 'spec_helper'

describe "treasures/show" do
  before(:each) do
    @treasure = assign(:treasure, stub_model(Treasure,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
