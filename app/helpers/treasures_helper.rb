module TreasuresHelper
  def available_tags
    ActsAsTaggableOn::Tag.all.map { |t| t.name }
  end
end
