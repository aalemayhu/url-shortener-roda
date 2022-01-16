Sequel.migration do
  up do
    create_table(:short_links) do
      primary_key :id
      String :short_link, unique: true
      String :url
    end
  end
  down do
    drop_table(:short_links)
  end
end
