class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :name, :registered_at
end
