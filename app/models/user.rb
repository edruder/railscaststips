class User < ActiveRecord::Base
  has_many :treasure_votes

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end

  def self.new_guest
    create { |u| u.guest = true }
  end

  def username
    guest ? 'Guest' : name
  end

  def can_vote_for?(treasure)
    treasure_votes.build(value: 1, treasure: treasure).valid?
  end
end
