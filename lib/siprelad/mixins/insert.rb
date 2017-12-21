module Siprelad
  module Mixins
    module Insert
      module ClassMethods
        def Insert(params={})
          requestor = Requestor.new
          response = requestor.request(insert_operation, params)
          parse_response(response, insert_operation)
        end
      end
      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end