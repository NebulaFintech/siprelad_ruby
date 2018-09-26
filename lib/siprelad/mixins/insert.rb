module Siprelad
  module Mixins
    module Insert
      module ClassMethods
        def insert(params = {})
          requestor = Requestor.new
          response = requestor.request(insert_operation, params)
          puts response.inspect
          # parse_response(response, insert_operation)
        end
      end
      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
