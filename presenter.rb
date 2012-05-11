#encoding: utf-8
require 'json'
require_relative '../../tinto/utils'

module Belinkr
  module Workspace
    module Board
      module Presenter
        class Collection
          def initialize(resource)
             @resource = resource
          end
          
          def as_poro
            @resource.map { |member| Presenter::Member.new(member).as_poro }
          end

          def as_json
           "[#{as_poro.map { |i| i.to_json }.join(",")}]"
          end

        end#Collection

        class Member

          def initialize(resource)
            @resource = resource
          end

          def as_poro
            {
              id:         @resource.id,
              name:       @resource.name,
              entity_id:  @resource.entity_id,
              workspace_id: @resource.workspace_id,
              user_id: @resource.user_id,
              created_at: @resource.created_at,
              updated_at: @resource.updated_at
            }.merge! errors
          end
          
          def as_json
            as_poro.to_json
          end
         
          private
          def errors
            (@resource.errors.empty?) ? {} : {errors: @resource.errors.to_hash}
          end
        end#Member

      end
    end
  end
end 


