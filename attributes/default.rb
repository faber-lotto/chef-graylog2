default['graylog2']['install']['java'] = true
default['graylog2']['install']['elasticsearch'] = true
default['graylog2']['install']['elasticsearch_monit'] = true
default['graylog2']['install']['mongodb'] = true
default['graylog2']['install']['mongodb_monit'] = true

default['graylog2']['group'] = 'graylog2'
default['graylog2']['user'] = 'graylog2' # only for web interface


default['graylog2']['server_base'] = '/usr/local/graylog2_server'
default['graylog2']['run_dir']= '/var/run/graylog2'
default['graylog2']['server_pid_file']= '/var/run/graylog2/graylog2_server.pid'


default['graylog2']['web']['version']='0.20.2'
default['graylog2']['web']['url_patern']='https://github.com/Graylog2/graylog2-web-interface/releases/download/%<version>s/graylog2-web-interface-%<version>s.tgz'

default['graylog2']['server']= {
    'config' => {
      'is_master' => "true",
      'node_id_file' => '/etc/graylog2-server-node-id',
      'rest_listen_uri' => 'http://127.0.0.1:12900/',
      'rest_enable_cors' => "false",
      'rest_enable_gzip' => "false",
      'elasticsearch_max_docs_per_index' => '20000000',
      'elasticsearch_max_number_of_indices' => '20',
      'retention_strategy' => 'delete',
      'elasticsearch_shards' => '4',
      'elasticsearch_replicas' => '0',
      'elasticsearch_index_prefix' => 'graylog2',
      'elasticsearch_cluster_name' => 'graylog2',
      'elasticsearch_node_name' => 'graylog2-server',
      'elasticsearch_analyzer' => 'standard',
      'output_batch_size' => '5000',
      'processbuffer_processors' => '5',
      'outputbuffer_processors' => '5',
      'processor_wait_strategy' => 'blocking',
      'ring_size' => '1024',
      'dead_letters_enabled' => 'false',
      'mongodb_useauth' => 'false',
      'mongodb_host' => '127.0.0.1',
      'mongodb_database' => 'graylog2',
      'mongodb_port' => '27017',
      'mongodb_max_connections' => '100',
      'mongodb_threads_allowed_to_block_multiplier' => '5',
      'transport_email_enabled' => 'true',
      'transport_email_hostname' => 'localhost',
      'transport_email_port' => '25',
      'transport_email_use_auth' => 'false',
      'transport_email_use_tls' => 'false',
      'transport_email_use_ssl' => 'false',
      'transport_email_auth_username' => 'you@example.com',
      'transport_email_auth_password' => 'secret',
      'transport_email_subject_prefix' => '[graylog2]',
      'transport_email_from_email' => 'graylog2@localhost'
    },
    'additional_config' => {
        "elasticsearch_network_host" => "127.0.0.1",
        'versionchecks' => 'false',
    } #for unknown settings
}

default['graylog2']['server']['version']='0.20.2'
default['graylog2']['server']['url_pattern']='https://github.com/Graylog2/graylog2-server/releases/download/%<version>s/graylog2-server-%<version>s.tgz'



default['graylog2']['web_pid_file'] = "/var/run/graylog2/graylog2-web-interface.pid"

default["elasticsearch"]["cluster"]["name"] = "graylog2"
default["elasticsearch"]["version"] = "0.90.10"
default["elasticsearch"]["network"]["host"] = "127.0.0.1"

default['elasticsearch']['custom_config']['script.disable_dynamic'] = true # http://bouk.co/blog/elasticsearch-rce/


default.elasticsearch[:path][:conf] = "/etc/elasticsearch"
default.elasticsearch[:path][:data] = "/var/data/elasticsearch"
default.elasticsearch[:path][:logs] = "/var/log/elasticsearch"

default.elasticsearch[:pid_path] = "/var/run/elasticsearch"
default.elasticsearch[:pid_file] = "#{node.elasticsearch[:pid_path]}/elastic_search_#{node.elasticsearch[:node][:name].to_s.gsub(/\W/, '_')}.pid"