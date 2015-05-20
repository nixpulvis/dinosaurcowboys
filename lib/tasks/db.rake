namespace :db do
  desc 'Pull database contents from pgbackups'
  task pull: [:download, :reset] do
    system 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U \
            postgres -d vintage_development latest.dump'
  end

  desc 'Download latest database from pgbackups'
  task :download do
    system 'curl -o latest.dump `heroku pg:backups public-url -q`'
  end
end
