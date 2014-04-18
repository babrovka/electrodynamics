class AddFieldsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :establish_date, :date
    add_column :organizations, :site, :string
    add_column :organizations, :country_id, :string
    add_column :organizations, :city_id, :string
    add_column :organizations, :employees, :string
    add_column :organizations, :about, :text
  end
end
