module ApplicationHelper
  def tag_cloud
    tags = Treasure.tag_counts_on(:tags).limit(15)
    content_tag :ul, class: 'tagcloud-list' do
      tags.collect { |tag| concat(content_tag :li, link_for_tag(tag)) }
    end
  end

  def link_for_tag tag
    link_to tag, "/tags/#{tag}"
  end

end
