module Siprelad
  class Contract < Resource
    include Mixins::Select
    include Mixins::Insert
    ATTRIBUTES = %i[id_origen id_grupo id_socio
                    id_origenp id_producto id_auxiliar tipo_instrumento
                    fecha_originacion fecha_vencimiento sueldo_mensual
                    plazo importe_mensualidad moneda_credito monto_credito
                    origen_recursos destino_recursos frecuencia_pago].freeze

    attr_reader(*ATTRIBUTES)
    # insert and update param
    # @IdOrigen
    # @IdGrupo
    # @IdSocio
    # @IdOrigenp
    # @IdProducto
    # @IdAuxiliar
    # @Tipo_instrumento
    # @Fecha_originacion
    # @Fecha_vencimiento
    # @Sueldo_mensual
    # @plazo
    # @Importe_mensualidad
    # @Moneda_credito
    # @Monto_credito
    # @OrigenRecursos
    # @DestinoRecursos
    # @FrecuenciaPago

    def initialize(options = {}); end

    def self.select_operation
      :contrato_select
    end

    def self.insert_operation
      :contrato_insert
    end

    def self.select_id_operation
      :contrato_select_id
    end
  end
end
