json.session do
  json.partial! '/api/v1/sessions/session', session: @user_session
end