require 'spec_helper'

describe "treasures/index" do
  before(:each) do
    assign(:treasures, [
      stub_model(Treasure,
        :description => "MyText",
        :time => Time.parse('00:02:26')
      ),
      stub_model(Treasure,
        :description => "MyText",
        :time => Time.parse('00:02:26')
      )
    ])
  end

  it "renders a list of treasures"
end
