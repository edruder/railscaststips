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

  def get_message_for_search search
    case search.type
    when :search_all
      "Showing available Tips"
    when :by_query
      "Showing results for query '#{search.search_term}'"
    when :by_tag
      "Showing results for tag '#{search.search_term}'"
    when :suggested
      "Your search for '#{search.failed_search_term}' did not match any documents, instead we're suggesting you to look for '#{search.search_term}' tag."
    else
      "Showing results for '#{search.search_term}'"
    end
  end
end
