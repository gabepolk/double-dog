
if ENV['APP_ENV'] == 'development'
  DoubleDog.db = DoubleDog::Databases::SQL.new
else
  # DoubleDog.db = DoubleDog::Databases::InMemory.new
end

# TODO: ESTABLISH ACTIVE RECORD CONNECTION
ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'double-dog_test'
)
