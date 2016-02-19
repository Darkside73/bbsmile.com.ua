# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :redis_session_store, {
  key: '_bbsmile_session',
  serializer: :json,
  redis: {
    key_prefix: 'bbsmile:session:'
  }
}
