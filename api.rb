# encoding: utf-8
require "i18n"
require "json"
require "sinatra/base"

require_relative "init"
require_relative "tinto/localizer"
require_relative "tinto/dispatcher"
require_relative "tinto/exceptions"
require_relative "user/member"

%w{ orchestrator presenter }.each do |file|
  require_relative "status/#{file}"
  require_relative "reply/#{file}"
  require_relative "workspace/#{file}"
  require_relative "workspace/board/#{file}"
  require_relative "workspace/autoinvitation/#{file}"
  require_relative "workspace/invitation/#{file}"
  require_relative "workspace/reply/#{file}"
  require_relative "workspace/status/#{file}"
  require_relative "scrapbook/#{file}"
  require_relative "scrapbook/scrap/#{file}"
  require_relative "request/#{file}"
  require_relative "user/#{file}"
  require_relative "appointment/#{file}"
end

require_relative "user/member"
require_relative "credential/orchestrator"
require_relative "api/sessions"
require_relative "api/statuses"
require_relative "api/followers"
require_relative "api/workspaces"
require_relative "api/scrapbooks"
require_relative "api/requests"
require_relative "api/appointment"
require_relative "api/helpers/file_mover"
require_relative "request/activity/presenter"

require_relative "uploaders/file_saver"
require_relative "middleware/aye_aye"

$redis = Redis.new

module Belinkr
  class API < Sinatra::Base

    use Rack::AyeAye, detector: Belinkr::FileSaver

    enable :sessions

    before do
      halt [401, ""] unless public_path? || current_user || authorized? 
      I18n.locale = Tinto::Localizer.new(self).locale 
    end
    helpers Belinkr::ApiHelpers

    helpers do
      def current_user
        #return false unless session[:user_id] && session[:entity_id]
        #require_relative './entity/orchestrator'
        #$redis.flushdb

        #entity = Belinkr::Entity::Member
        #  .new(name: 'belink', phone: '888888888', address: 'Anxi Road 100')
        #credential1 = Belinkr::Credential::Member
        #  .new(email: 'user1@belinkr.com', password: '88888888888888')
        #user1 = Belinkr::User::Member.new(first: 'user1', last: '111')
        #entity, admin_credential, admin = Belinkr::Entity::Orchestrator
        #  .create(entity, credential1, user1)
        #workspace = Belinkr::Workspace::Orchestrator.create(
        #  Belinkr::Workspace::Member.new(name: 'workspace1', entity_id: entity.id),
        #  admin 
        #)
        #user2 = Belinkr::User::Orchestrator.create(
        #  Belinkr::User::Member.new(first: 'user2', last: '112', entity_id: entity.id) 
        #)
        session[:user_id] = 1
        session[:entity_id] = 1 
        @current_user ||= Belinkr::User::Member.new(
           id: session[:user_id], entity_id: session[:entity_id]
        )
      end

      def public_path?
        request.path_info =~ /sessions/
      end

      def dispatch(action, resource=nil, &block)
        Tinto::Dispatcher.new(current_user, resource, &block).send(action)
      end

      def sanitized_payload
        input = request.body.read.to_s
        request.body.rewind
        JSON.parse(input).select { |k, v| k != "id" }
      end

      def authorized?
        @auth ||=  Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? && @auth.basic? && @auth.credentials && 
          @auth.credentials == [
            Belinkr::Config::AUTH_USERNAME, Belinkr::Config::AUTH_PASSWORD
        ]
      end

    end

  end # API
end # Belinkr
