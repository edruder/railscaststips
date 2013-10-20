require 'spec_helper'

describe "railscasts/show" do
  before(:each) do
    @railscast = assign(:railscast, stub_model(Railscast,
      :url => "Url",
      :name => "Name",
      :description => "Description"
    ))

    @user = mock_model(User)
    view.stub(:current_user).and_return(@user)
    @user.stub(:admin?).and_return true
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    rendered.should match(/Name/)
    rendered.should match(/Description/)
  end
end
