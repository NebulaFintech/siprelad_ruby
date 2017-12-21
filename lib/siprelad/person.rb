module Siprelad
  class Person < Resource
    include Mixins::Select
    ATTRIBUTES = [:a_materno, :a_paterno, :activo, :alto_riesgo,
      :alto_riesgo_por_act_economica, :alto_riesgo_por_lista_negra,
      :alto_riesgo_por_nacionalidad, :alto_riesgo_por_pep,
      :alto_riesgo_por_residencia, :alto_riesgo_por_ser_persona_bloque,
      :curp, :calle, :clave_empresa, :codigo_postal, :colonia,
      :documentacion_de_justificacion, :expediente, :fecha_de_ingreso,
      :fecha_de_nacimiento_o_constitucio, :genero, :id_actividad_economica,
      :id_estado, :id_grupo, :id_localidad, :id_nacionalidad,
      :id_ocupacion, :id_pais, :id_pais_de_nacimiento,
      :id_persona, :id_sucursal_socio, :id_tipo_persona,
      :log_error, :no_de_cliente, :nombre, :numero_ext,
      :numero_int, :rfc, :razones_de_riesgo, :telefono_particular_u_oficina]
      attr_reader(*ATTRIBUTES)

      # insert params
      # @Sucursal
      # @Grupo
      # @NumCliente
      # @ApPaterno
      # @ApMaterno
      # @Nombre
      # @RFC
      # @CURP
      # @TipoPersona
      # @FechaNac (20)
      # @Nacionalidad
      # @Calle
      # @NumExterior
      # @NumInterior
      # @Colonia
      # @Localidad
      # @Estado
      # @CP
      # @Pais
      # @Telefono
      # @Ocupacion
      # @FechaIngreso
      # @Actividad
      # @Genero
      # @PaisDeNacimiento
    def initialize(options={})
    end

    def self.select_operation
      :persona_select
    end

    def self.insert_operation
      :persona_insert
    end
  end
end