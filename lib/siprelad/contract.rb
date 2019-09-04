module Siprelad
  class Contract < Resource
    include Mixins::Select
    include Mixins::Insert
    ATTRIBUTES = %i[destino_recursos fecha_originacion fecha_vencimiento
                    frecuencia_pago id_auxiliar id_grupo id_origen id_origenp id_producto
                    importe_mensualidad moneda_credito monto_credito no_de_cliente
                    origen_recursos plazo sueldo_mensual tipo_instrumento] .freeze

    attr_reader(*ATTRIBUTES)
    # insert and update param
    # @DestinoRecursos
    # @Fecha_originacion
    # @Fecha_vencimiento
    # @FrecuenciaPago
    # @IdAuxiliar
    # @IdGrupo
    # @IdOrigen
    # @IdOrigenp
    # @IdProducto
    # @Importe_mensualidad
    # @Moneda_credito
    # @Monto_credito
    # @NoDeCliente
    # @OrigenRecursos
    # @Plazo
    # @Sueldo_mensual
    # @Tipo_instrumento

    def initialize(options = {}); end

    def self.find(id)
      select('IdAuxiliar' => id).first
    rescue
      nil
    end

    def self.create(params = {})
      insert(
        'IdOrigen' => 0,
        'IdGrupo' => 0,
        'NoDeCliente' => params.fetch(:customer_id),
        'IdOrigenp' => 1,
        'IdProducto' => params.fetch(:loan_product_id),
        'IdAuxiliar' => params.fetch(:id),
        'Tipo_instrumento' => '03',
        'Fecha_originacion' => parse_date(params.fetch(:expected_disbursement_at)),
        'Fecha_vencimiento' => parse_date(params.fetch(:liquidation_date)),
        'Sueldo_mensual' => params.fetch(:monthly_income).to_f,
        'Plazo' => params.fetch(:months_duration),
        'Importe_mensualidad' => params.fetch(:monthly_repayment),
        'Moneda_credito' => params.fetch(:currency),
        'Monto_credito' => params.fetch(:principal),
        'OrigenRecursos' => '002',
        'DestinoRecursos' => '002',
        'FrecuenciaPago' => '02'
      ).first
    end

    def id
      id_auxiliar.to_i
    end

    def self.select_operation
      :contrato_select_sofom
    end

    def self.insert_operation
      :contrato_insert_sofom
    end
  end
end
