Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '207859815920359', '5fd6b516e7d916cabaaa6b378503f11a'
end