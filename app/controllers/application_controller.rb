class ApplicationController < ActionController::API
  include ActionController::Serialization
  include Knock::Authenticable

  def clean_up
    tables = ActiveRecord::Base.connection.tables
    tables.delete 'schema_migrations'
    tables.each { |t| ActiveRecord::Base.connection.execute("TRUNCATE #{t} CASCADE") }
    Rails.application.load_seed
    render text: 'Truncated tables and seeded'
  end
end
