class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :email, :is_enabled, :role, :created_at
end
