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
    end

    def id
      id_auxiliar.to_i
    end

    def self.select_operation
      :contrato_select_sofom
    end

    def self.insert_operation
      :contrato_insert
    end

    def self.select_id_operation
      :contrato_select_id
    end
  end
end
