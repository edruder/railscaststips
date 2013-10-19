# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
R13Team376::Application.initialize!

#ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
#  if instance.instance_of? ActionView::Helpers::Tags::Label
#    html_tag
#  else
#    %(<div class="form-field error">#{html_tag}<small class="error">&nbsp;#{[*instance.error_message].join(', ')}</small></div>).html_safe
#  end
#end
