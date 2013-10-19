class Railscast < ActiveRecord::Base

  # == Validations ==
  validates :url, :name, :description, presence: true
end
