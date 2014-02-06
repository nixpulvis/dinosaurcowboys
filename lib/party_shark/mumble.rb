module PartyShark

  class Mumble
    include HTTParty

    base_uri "http://www.typefrag.com/server-status/mumble/ChannelViewerProtocol.aspx"

    attr_reader :data

    def initialize(server, port)
      @server = server
      @port = port
      @data = self.class.data(server, port)
    end

    class << self
      def data(server, port)
        params = {
          "ReturnType" => "json",
          "HostName"   => server,
          "PortNumber" => port
        }
        get("/", query: params).parsed_response
      end
    end
  end

end