module Siprelad
  class Operation < Resource
    include Mixins::Insert
    ATTRIBUTES = %i[id_operacion id_origen id_grupo no_de_cliente
                    id_origenp id_producto id_auxiliar fecha efectivo otros
                    total_operacion tipo_operacion moneda saldo_credito
                    id_origen_operacion].freeze

    attr_reader(*ATTRIBUTES)
    # insert and update param
    # @IdOperacion
    # @IdOrigen
    # @IdGrupo
    # @NoDeCliente
    # @IdOrigenp
    # @IdProducto
    # @IdAuxiliar
    # @Fecha
    # @Efectivo
    # @Otros
    # @Total_Operacion
    # @Tipo_Operacion
    # @Moneda
    # @Saldo_credito
    # @IdOrigenOperacion

    def initialize(options = {}); end

    def self.create(params = {})
      insert(
        'IdOperacion' => params.fetch(:id),
        'IdOrigen' => 0,
        'IdGrupo' => 0,
        'NoDecliente' => params.fetch(:customer_id),
        'IdOrigenp' => 0,
        'IdProducto' => params.fetch(:loan_product_id),
        'IdAuxiliar' => params.fetch(:contract_id),
        'Fecha' => parse_date(params.fetch(:operation_date)),
        'Efectivo' => nil,
        'Otros' => parse_payment_method(params.fetch(:payment_method)),
        'Total_Operacion' => params.fetch(:operation_amount),
        'Tipo_Operacion' => parse_operation_type(params.fetch(:operation_type)),
        'Moneda' => params.fetch(:currency),
        'Saldo_credito' => params.fetch(:loan_balance),
        'IdOrigenOperacion' => 1
      ).first
    end

    def id
      id_operacion.to_i
    end

    def self.insert_operation
      :operacion_insert_sofom
    end
  end
end
