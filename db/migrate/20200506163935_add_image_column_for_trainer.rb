class AddImageColumnForTrainer < ActiveRecord::Migration[6.0]
  def change
    add_column :trainers, :back_img_url, :string
    add_column :trainers, :front_img_url, :string
  end
end
