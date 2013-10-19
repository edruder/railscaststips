class Railscast < ActiveRecord::Base

  # == Validations ==
  validates :url, :name, :description, presence: true
  validates :url, :name, uniqueness: true
end
