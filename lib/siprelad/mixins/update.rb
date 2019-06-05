module Siprelad
  module Mixins
    module Update
      module ClassMethods
        def update(params = {})
          requestor = Requestor.new
          response = requestor.request(update_operation, params)
          parse_response(response, update_operation)
        end
      end
      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
