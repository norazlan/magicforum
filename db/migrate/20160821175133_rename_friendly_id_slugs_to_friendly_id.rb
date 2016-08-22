class RenameFriendlyIdSlugsToFriendlyId < ActiveRecord::Migration[5.0]
  def change
    rename_table :friendly_id_slugs, :friendly_id
  end
end
