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

    def self.find(id)
      select_id('NoDeCliente' => id).first
    rescue
      nil
    end

    def self.where(params = {})
      given_names = params.fetch(:given_names, nil)
      paternal_surname = params.fetch(:paternal_surname, nil)
      maternal_surname = params.fetch(:maternal_surname, nil)
      raise 'Given names or surnames must be given!' if (given_names.to_s + paternal_surname.to_s + maternal_surname.to_s).blank?

      select('Nombre' => given_names, 'APaterno' => paternal_surname, 'AMaterno' => maternal_surname)
    end

    def self.create(params = {})
      insert(
        'IdSucursalSocio' => 1,
        'IdGrupo' => 1,
        'NoDeCliente' => params.fetch(:id),
        'APaterno' => params.fetch(:paternal_surname),
        'AMaterno' => params.fetch(:maternal_surname),
        'Nombre' => params.fetch(:given_names),
        'RFC' => params.fetch(:rfc),
        'CURP' => params.fetch(:curp),
        'IdTipoPersona' => 1,
        'FechaDeNacimientoOConstitucio' => params.fetch(:birth_date).strftime('%d/%m/%Y'),
        'IdNacionalidad' => 1,
        'Calle' => params.fetch(:street1),
        'NumeroExt' => params.fetch(:external_number),
        'NumeroInt' => params.fetch(:internal_number, nil),
        'Colonia' => params.fetch(:neighborhood),
        'IdLocalidad' => params.fetch(:municipality_pld_id),
        'IdEstado' => params.fetch(:state_pld_id),
        'CodigoPostal' => params.fetch(:postal_code),
        'IdPais' => parse_country(params.fetch(:country, 1)),
        'TelefonoParticularUOficina' => params.fetch(:mobile_phone),
        'IdOcupacion' => nil,
        'FechaDeIngreso' => parse_date(params.fetch(:starting_working_date)),
        'IdActividadEconomica' => params.fetch(:economic_activity_code),
        'Genero' => parse_gender(params.fetch(:gender)),
        'IdPaisDeNacimiento' => parse_country(params.fetch(:country_of_birth)),
        'NumeroIdOficial' => params.fetch(:responsible_id, nil),
        'FirmaElectronica' => params.fetch(:fea_reference_id).to_i,
        'EstadoNacimiento' => params.fetch(:province_of_birth_pld_id),
        'CorreoElectronico' => params.fetch(:email),
        'PF_ConActividadEmpresarial' => 0,
        'EstadoCivil' => parse_civil_status(params.fetch(:civil_status)),
        'TipoDomicilio' => parse_housing_type(params.fetch(:housing_type)),
        'AntiguedadDomicilio' => years_since(params.fetch(:lived_in_since)),
        'AntiguedadLaboral' => years_since(params.fetch(:starting_working_date)),
        'TipoUsoTerceros' => 1,
        'TipoCuentaBancaria' => nil,
        'RecepcionPago' => nil
      ).first
    end

    def id
      no_de_cliente.to_i
    end

    def self.select_id_operation
      :persona_select_id_sofom
    end

    def self.select_operation
      :persona_select_sofom
    end

    def self.insert_operation
      :persona_insert_sofom
    end
  end
end
