require 'spec_helper'

describe "railscasts/index" do
  before(:each) do
    assign(:railscasts, [
      stub_model(Railscast,
        :url => "Url",
        :name => "Name",
        :pro => "true",
        :revised => "true",
        :position => 1,
        :permalink => 'permalink-1',
        :duration => '6:40'
      ),
      stub_model(Railscast,
        :url => "Url",
        :name => "Name",
        :pro => "false",
        :revised => "false",
        :position => 2,
        :permalink => "permalink-2",
        :duration => '8:21'
      )
    ])
  end

  it "renders a list of railscasts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "true".to_s, :count => 2
    assert_select "tr>td", :text => "false".to_s, :count => 2
    assert_select "tr>td", :text => "permalink-1".to_s, :count => 1
    assert_select "tr>td", :text => "permalink-2".to_s, :count => 1
    assert_select "tr>td", :text => "6:40".to_s, :count => 1
    assert_select "tr>td", :text => "8:21".to_s, :count => 1
  end
end
