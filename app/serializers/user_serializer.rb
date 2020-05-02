class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :name, :registered_at
end
