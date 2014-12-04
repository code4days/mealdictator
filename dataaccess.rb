require 'aws-sdk-core/dynamodb'

class Dataaccess

  attr_reader :restaurantName

  def initialize(restaurantName)
    restaurantName = restaurantName
  end

  # dynamo_db = Aws::DynamoDB.new();
  #dynamo_db
  # dynamo_db = Aws::DynamoDB.new(
  #     :access_key_id => '',
  #     :secret_access_key => '');
  # # DB = DynamoDB.new
  # TABLES = {}
  #
  # {
  #     "restaurants" => {
  #         hash_key: {timeline_id: :string},
  #         range_key: {created_at: :number}
  #     },
  #     "users" => {
  #         hash_key: {id: :string}
  #     }
  # }.each_pair do |table_name, schema|
  #   begin
  #     TABLES[table_name] = DB.tables[table_name].load_schema
  #   rescue ResourceNotFoundException
  #     table = DB.tables.create(table_name, 10, 5, schema)
  #     print "Creating table #{table_name}..."
  #     sleep 1 while table.status == :creating
  #     print "done!\n"
  #     TABLES[table_name] = table.load_schema
  #   end
  # end

end

get '/dataaccess' do
  # @restaurant = params[:restaurant]
  dataaccess = Dataaccess.new(params[:restaurant]);
  # "Hello World"
end
