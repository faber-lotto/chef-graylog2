actions :create, :delete
default_action :create


attribute :title, :name_attribute => true, :kind_of => String, :required => true
attribute :configuration, :kind_of => [Hash],  :default => {"allow_override_date" => true,
                                                            "port" => 514,
                                                            "bind_address" => "0.0.0.0"}
attribute :global, :kind_of => [TrueClass, FalseClass], :default => false
attribute :creator_user_id, :kind_of => String, :default => "admin"
attribute :type, :kind_of => String,  :default => "org.graylog2.inputs.syslog.udp.SyslogUDPInput"

attribute :base_url, :kind_of => String, :default => nil
attribute :path, :kind_of => String, :default => "/system/inputs"
attribute :username, :kind_of => String, :default => "admin"
attribute :password, :kind_of => String, :default => nil

attr_accessor :exists