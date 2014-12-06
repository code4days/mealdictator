gem 'aws-sdk'


get '/db' do
dynamo_db = AWS::DynamoDB.new(
    :access_key_id => 'AKIAIC4EEK5KCRHCSROQ',
    :secret_access_key => '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',
    :region => 'us-east-1'
)

table = dynamo_db.tables.create(
    "Mytable", 10, 5,
    :hash_key => { :id => :string }
)

sleep 1 while table.status == :creating

item = table.items.put(:id => "abc123")
item.hash_value # => "abc123"
item.attributes.set(
    :colors => ["red", "blue"],
    :numbers => [12, 24]
)

"DB SHIT DONE!!!"
end