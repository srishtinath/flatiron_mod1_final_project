class AddCaptureRateColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :capture_rate, :integer
  end
end
