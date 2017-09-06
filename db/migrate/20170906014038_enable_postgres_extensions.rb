class EnablePostgresExtensions < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto'
    enable_extension 'citext'
  end
end
