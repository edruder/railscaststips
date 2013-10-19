require 'spec_helper'

describe "treasures/new" do
  before(:each) do
    assign(:treasure, stub_model(Treasure,
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new treasure form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", treasures_path, "post" do
      assert_select "textarea#treasure_description[name=?]", "treasure[description]"
    end
  end
end
