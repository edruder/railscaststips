require 'spec_helper'

describe "treasures/edit" do
  before(:each) do
    @treasure = assign(:treasure, stub_model(Treasure,
      :description => "MyText"
    ))
  end

  it "renders the edit treasure form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", treasure_path(@treasure), "post" do
      assert_select "textarea#treasure_description[name=?]", "treasure[description]"
    end
  end
end
