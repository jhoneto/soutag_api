# frozen_string_literal: true

require 'devise/jwt/test_helpers'

module RequestSpecHelper
  def authenticated_header(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end
end
