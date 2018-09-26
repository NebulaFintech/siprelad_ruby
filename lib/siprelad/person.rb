module Siprelad
  class Person < Resource
    include Mixins::Select
    include Mixins::Insert
    ATTRIBUTES = %i[id_sucursal_socio id_grupo no_de_cliente
                    fecha_de_ingreso nombre a_paterno a_materno
                    fecha_de_nacimiento_o_constitucio rfc curp genero
                    id_nacionalidad id_pais_de_nacimiento id_tipo_persona
                    id_ocupacion id_actividad_economica calle numero_ext
                    numero_int colonia codigo_postal id_pais id_estado
                    id_localidad telefono_particular_u_oficina
                    rol_de_persona tipo_usuario numero_id_oficial
                    firma_electronica estado_nacimiento correo_electronico].freeze

    attr_reader(*ATTRIBUTES)
    # insert and update param
    # @IdSucursalSocio
    # @IdGrupo
    # @NoDeCliente
    # @FechaIngreso
    # @Nombre
    # @APaterno
    # @AMaterno
    # @FechaDeNacimientoOConstitucio
    # @RFC
    # @CURP
    # @Genero
    # @IdNacionalidad
    # @IdPaisDeNacimiento
    # @IdTipoPersona
    # @IdOcupacion
    # @IdActividadEconomica
    # @Calle
    # @NumExt
    # @NumInt
    # @Colonia
    # @CodigoPostal
    # @IdPais
    # @IdEstado
    # @IdLocalidad
    # @TelefonoParticularUOficina
    # @RolDePersona
    # @TipoUsuario
    # @NumeroIdOficial
    # @FirmaElectronica
    # @EstadoNacimiento
    # @CorreoElectronico
    def initialize(options = {}); end

    def self.select_operation
      :persona_select
    end

    def self.insert_operation
      :persona_insert
    end
  end
end
