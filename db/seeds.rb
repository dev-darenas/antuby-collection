## Create Role ##
Role.find_or_create_by(name: :admin, name_es: 'Administración')
Role.find_or_create_by(name: :collection_advisor, name_es: 'Asesor de cobranza')
Role.find_or_create_by(name: :debt_collector, name_es: 'Recaudador')
