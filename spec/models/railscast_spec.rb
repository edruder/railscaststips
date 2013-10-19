require 'spec_helper'

describe Railscast do
  it { should validate_presence_of :url }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_uniqueness_of :url }
  it { should validate_uniqueness_of :name }
end
