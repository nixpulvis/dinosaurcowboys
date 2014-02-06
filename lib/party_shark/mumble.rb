module PartyShark
  # PartyShark::Mumble
  # JSON API wrapper for typefrag's mumble api.
  #
  class Mumble
    SERVER = 'partyshark.typefrag.com'
    PORT   = 7675

    include HTTParty

    base_uri 'http://www.typefrag.com/server-status/mumble/ChannelViewerProtocol.aspx'  # rubocop:disable LineLength

    attr_reader :data

    def initialize(server, port)
      @server = server
      @port = port
      @data = self.class.data(server, port)
    end

    class << self
      def data(server, port)
        params = {
          'ReturnType' => 'json',
          'HostName'   => server,
          'PortNumber' => port
        }
        get('/', query: params).parsed_response
      end
    end
  end
end
