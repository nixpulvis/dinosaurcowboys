namespace :db do

  desc "Pull database contents from pgbackups"
  task :pull do
    system 'curl -o latest.dump `heroku pgbackups:url`'

    # FIXME: Currently NO error checking, due to limitations with rake, and
    #        Rails.
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

    system 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U \
            postgres -d party_shark_development latest.dump'
  end

end