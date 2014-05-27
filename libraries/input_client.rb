module Graylog2
  class Input
    attr_accessor :data

    def initialize(data)
      self.data = data || {}
    end

    def title
      data['title']
    end

    def id
      data['input_id']
    end

  end

  class InputClient < ClientBase
    attr_accessor :last_input

    def by_title(title)
      result = JSON.parse(http_client.get(path))

      Chef::Log.info("GET to #{base_url}/#{path} successful")
      Chef::Log.debug("GET request response: #{result}")

      inputs = result['inputs'].map{|input| Input.new(input['message_input'])}

      inputs.find{|input|
        input.title == title
      }

    end

    def exists?(title)
      ! by_title(title).nil?
    end

    def delete_by_title(title)
      delete(by_title(title).id)
    end

  end
end