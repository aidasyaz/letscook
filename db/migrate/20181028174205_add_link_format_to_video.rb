class AddLinkFormatToVideo < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :link_format, :string
  end
end
