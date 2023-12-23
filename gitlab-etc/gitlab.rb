letsencrypt['enable'] = false
postgresql['enable'] = false
gitlab_rails['initial_root_password'] = 'LetMeIn9'
external_url 'http://192.168.0.10:80'
gitlab_rails['db_adapter'] = 'postgresql'
gitlab_rails['db_encoding'] = 'utf8'
gitlab_rails['db_host'] = '192.168.0.10'
gitlab_rails['db_port'] = '5432'
gitlab_rails['db_username'] = 'gitlab'
gitlab_rails['db_password'] = 'LetMeIn9'
gitlab_rails['db_database'] = 'gitlabhq_production'
