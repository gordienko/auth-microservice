# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:sessions) do
      primary_key :id, type: :Bignum
      column :uuid, :Uuid, null: false
      column :user_id, :Bignum, null: false
      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false
      index [:user_id], name: :index_ads_on_user_id
    end
  end
end
