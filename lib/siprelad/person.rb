module Siprelad
  class Person < Resource
    include Mixins::Select
    include Mixins::Insert
    ATTRIBUTES = %i[a_materno a_paterno antiguedad_domicilio
      antiguedad_laboral curp calle codigo_postal colonia
      correo_electronico estado_civil estado_nacimiento
      fecha_de_ingreso fecha_de_nacimiento_o_constitucio
      firma_electronica genero id_actividad_economica
      id_estado id_grupo id_localidad id_nacionalidad
      id_ocupacion id_pais id_pais_de_nacimiento
      id_sucursal_socio id_tipo_persona no_de_cliente nombre
      numero_ext numero_id_oficial numero_int
      pf_con_actividad_empresarial rfc recepcion_pago
      telefono_particular_u_oficina tipo_cuenta_bancaria
      tipo_domicilio tipo_uso_terceros].freeze

    attr_reader(*ATTRIBUTES)
    # insert and update param
    # @AMaterno
    # @APaterno
    # @AntiguedadDomicilio
    # @AntiguedadLaboral
    # @CURP
    # @Calle
    # @CodigoPostal
    # @Colonia
    # @CorreoElectronico
    # @EstadoCivil
    # @EstadoNacimiento
    # @FechaDeIngreso
    # @FechaDeNacimientoOConstitucio
    # @FirmaElectronica
    # @Genero
    # @IdActividadEconomica
    # @IdEstado
    # @IdGrupo
    # @IdLocalidad
    # @IdNacionalidad
    # @IdOcupacion
    # @IdPais
    # @IdPaisDeNacimiento
    # @IdSucursalSocio
    # @IdTipoPersona
    # @NoDeCliente
    # @Nombre
    # @NumeroExt
    # @NumeroIdOficial
    # @NumeroInt
    # @PF_ConActividadEmpresarial
    # @RFC
    # @RecepcionPago
    # @TelefonoParticularUOficina
    # @TipoCuentaBancaria
    # @TipoDomicilio
    # @TipoUsoTerceros

    def initialize(options = {}); end

    def self.select_operation
      :persona_select_sofom
    end

    def self.insert_operation
      :persona_insert
    end

    def self.select_id_operation
      :persona_select_id_sofom
    end
  end
end
