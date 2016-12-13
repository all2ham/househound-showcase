desc "PG Backup"
namespace :pg do
  task :backup => [:environment] do
    #stamp the filename
    datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")

    backup_name = "listingmanager_production_#{datestamp}_dump.sql.gz"

    #drop it in the db/backups directory temporarily

    backup_file = "/root/apps/mlm/shared/backup/#{backup_name}"

    #dump the backup and zip it up
    sh "pg_dump #{ENV['DB_NAME']} | gzip -c > #{backup_file}"

    send_to_amazon(backup_file, backup_name)
    #remove the file on completion so we don't clog up our app
    File.delete backup_file
  end
end

def send_to_amazon(file_path, file_name)
  #file_name = File.basename(file_path)
  #AWS::S3::Base.establish_connection!(:access_key_id => ENV['AWS_KEY'], :secret_access_key => ENV['AWS_SECRET'])
  #push the file up
  #AWS::S3::S3Object.store(file_name,File.open("#{file_path}"),bucket)
  # Establish connection
  s3 = AWS::S3.new(
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])

  # Get the bucket
  bucket = s3.buckets['lm-prod-db-backups']

  # Get a reference to the file
  obj = bucket.objects["#{file_name}"]

  # Write the file
  obj.write(Pathname.new(file_path))

end
