ENV['GITHUB_SECRET'] = '773ba8505d038db07dccc1b5f3040f32c2b076ce'
ENV['GITHUB_KEY'] = 'be6471329d3c33ef9abd'
OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user:email"
end
