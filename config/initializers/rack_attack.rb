class Rack::Attack
  Rails.application.config.middleware.use Rack::Attack

  throttle('posts/ip', limit: 5, period: 1.minute) do |req|
    req.ip if req.path == '/api/v1/posts'
  end

  self.throttled_responder = lambda do |_env|
    [429, { 'Content-Type' => 'application/json' }, ['Rate limit exceeded.']]
  end

  blocklist('block 192.168.1.1') do |req|
    '192.168.1.1' == req.ip
  end

  safelist('allow-localhost') do |req|
    '127.0.0.1' == req.ip
  end

  ActiveSupport::Notifications.subscribe('rack.attack') do |name, start, finish, request_id, payload|
    Rails.logger.info "[Rack::Attack] Blocked #{payload[:request].ip}"
  end
end