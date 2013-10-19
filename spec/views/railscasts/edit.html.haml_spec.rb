require 'spec_helper'

describe "railscasts/edit" do
  before(:each) do
    @railscast = assign(:railscast, stub_model(Railscast,
      :url => "MyString",
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit railscast form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", railscast_path(@railscast), "post" do
      assert_select "input#railscast_url[name=?]", "railscast[url]"
      assert_select "input#railscast_name[name=?]", "railscast[name]"
      assert_select "input#railscast_description[name=?]", "railscast[description]"
    end
  end
end
