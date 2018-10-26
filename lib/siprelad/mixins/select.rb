module Siprelad
  module Mixins
    module Select
      module ClassMethods
        def select(params = {})
          requestor = Requestor.new
          response = requestor.request(select_operation, params)
          parse_response(response, select_operation)
        end
        def select_id(params = {})
          requestor = Requestor.new
          response = requestor.request(select_id_operation, params)
          parse_response(response, select_id_operation)
        end
      end
      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
