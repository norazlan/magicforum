class RenameFriendlyIdToFriendlyIdSlugs < ActiveRecord::Migration[5.0]
  def change
    rename_table :friendly_id, :friendly_id_slugs
  end
end
