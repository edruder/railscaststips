module TreasuresHelper
  def available_tags
    ActsAsTaggableOn::Tag.all.map { |t| t.name }
  end

  def tags_for_treasure treasure = @treasure
    content_tag :ul, class: 'tagcloud-list' do
      treasure.tag_list.collect { |tag| concat(content_tag :li, link_for_tag(tag)) }
    end
  end

  def found_at time
    time.strftime "%M:%S"
  end

end
