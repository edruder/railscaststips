require 'spec_helper'

describe "treasures/new" do
  before(:each) do
    assign(:treasure, stub_model(Treasure,
      :description => "MyText",
      :time => Time.parse('00:02:26')
    ).as_new_record)
  end

  it "renders new treasure form"
end
