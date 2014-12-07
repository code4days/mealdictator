require 'data_mapper'

#DataMapper.setup(:default, 'mysql://user:password@hostname/database')
#DataMapper.setup(:default, "mysql://" + ENV['RDS_USERNAME'] + ":" + ENV['RDS_PASSWORD'] + "@" + ENV['RDS_HOSTNAME'] + "/" + ENV['RDS_DB_NAME'])
DataMapper.setup(:default, "mysql://" + ENV['RDS_USERNAME'] + ":" + ENV['RDS_PASSWORD'] + "@" + ENV['RDS_HOSTNAME'] + ".co3wdyunphxf.us-east-1.rds.amazonaws.com/" + ENV['RDS_DB_NAME'])


class DataStuff

  include DataMapper::Resource
  property :id, Serial
  property :name, String

end

DataMapper.finalize

get '/db' do
  DataStuff.auto_migrate!

  d = DataStuff.new
  d.save
end