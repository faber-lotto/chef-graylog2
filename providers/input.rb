# Support whyrun
def whyrun_supported?
  true
end


action :create do
  if new_resource.exists
    Chef::Log.info "#{ new_resource } already exists - nothing to do."
  else
    converge_by("Create #{ new_resource }") do

      message = {"configuration" => new_resource.configuration,
                 "global" => new_resource.global,
                 "creator_user_id" =>new_resource.creator_user_id,
                 "title" => new_resource.title,
                 "type" => new_resource.type
             }

      @client.create(message)
    end
  end
end

action :delete do
  if new_resource.exists
    converge_by("Delete #{ new_resource }") do
      @client.delete_by_title(new_resource.title)
    end
  else
    Chef::Log.info "#{ new_resource } doesn't exist - can't delete."
  end
end



def load_current_resource
  base_url = new_resource.base_url || node['graylog2']['transport_uri']
  password = new_resource.password || node['graylog2']['root_password']

  first_run = true
  begin
    @client = ::Graylog2::InputClient.new(base_url, new_resource.username, password, new_resource.path)
    new_resource.exists = @client.exists?(new_resource.title)
  rescue => e
    if first_run
      first_run = false
      Chef::Log.error('First startup try to wait once more')
      sleep 30
      retry
    else
      raise e
    end

  end


end
