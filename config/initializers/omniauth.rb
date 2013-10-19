OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, GITHUB_CONFIG['key'], GITHUB_CONFIG['secret'], scope: "user:email"
end
