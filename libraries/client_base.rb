module Graylog2
  class ClientBase
    attr_accessor :http_client, :base_url, :path

    def initialize(base_url, username, password, path)
      self.base_url = base_url
      self.path = path
      self.http_client = Chef::HTTP.new(base_url,
                                 :headers =>
                                {"AUTHORIZATION" => "Basic #{Base64.encode64("#{username}:#{password}")}",
                                 "Content-Type" => "application/json"}
                                )
    end

    def path=(new_path)
      @path = new_path.reverse.chomp('/').reverse.chomp('/')
    end

    def base_url=(new_url)
      @base_url = new_url.chomp('/')
    end

    def create(data)
      http_client.post(self.path, data.to_json)
    end

    def delete(id)
      http_client.delete("#{path}/#{id}")
    end

  end
end