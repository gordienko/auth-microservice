Sequel.migration do
  change do
    create_table(:schema_migrations) do
      String :filename, :text=>true, :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:sessions, :ignore_index_errors=>true) do
      primary_key :id, :type=>:Bignum
      String :uuid, :null=>false
      Bignum :user_id, :null=>false
      DateTime :created_at, :size=>6, :null=>false
      DateTime :updated_at, :size=>6, :null=>false
      
      index [:user_id], :name=>:index_ads_on_user_id
    end
    
    create_table(:users) do
      primary_key :id, :type=>:Bignum
      String :name, :null=>false
      String :email, :null=>false
      String :password_digest, :null=>false
      DateTime :created_at, :size=>6, :null=>false
      DateTime :updated_at, :size=>6, :null=>false
    end
  end
end
