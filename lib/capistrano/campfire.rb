require 'capistrano'
require 'tinder'

module Capistrano
  module Campfire
    def self.extended(configuration)
      configuration.load do
        set :campfire_options, {}

        set :campfire_room do

          account = campfire_options[:account]
          token = campfire_options[:token]
          ssl = campfire_options[:ssl]
          ssl_verify = campfire_options[:ssl_verify]
          room_name = campfire_options[:room]

          campfire = ::Tinder::Campfire.new account,
            :token => token,
            :ssl => ssl,
            :ssl_verify => ssl_verify

          campfire.find_room_by_name(room_name)
        end
      end
    end

  end
end

if Capistrano::Configuration.instance
  Capistrano::Configuration.instance.extend(Capistrano::Campfire)
end
