module ImportData
  class ReadData
    require 'rubyXL'

    attr_accessor :enterprise, :worksheet
    REQUIREDCOLUMNS = [
      "Identificación",
      "Cliente",
      "Email",
      "Celular",
      "Telefono",
      "Direccion",
      "Fecha emision",
      "Cod. Factura",
      "Total",
      "Saldo",
      "Fecha Vencimiento",
      "Descripcion"
    ].freeze

    def initialize(enterprise_id)
      @enterprise = Enterprise.find(enterprise_id)
      read_file(
        @enterprise.excel.current_path
      )
    end

    def row_head
      read_row(0)
    end

    def load_data(keys)
      @worksheet.each_with_index do |rows, index|
        next if keys["skip_first_row"].to_i == 1 && index == 0
        row = read_row(index)
        next if row[keys["Identificacion"].to_i].nil?

        client = @enterprise.clients.find_or_create_by(identification: row[keys["Identificacion"].to_i])

        ## Update Client Attributes ##
        client.update(
          name: row[keys["Cliente"].to_i],
          email: row[keys["Email"].to_i],
          cellphone: row[keys["Celular"].to_i],
          phone: row[keys["Telefono"].to_i],
          address_description: row[keys["Direccion"].to_i]
        )

        ## Update or Create Bills ##
        invoice = client.invoices.find_or_create_by(
                    code: row[keys["Cod. Factura"].to_i],
                    type: 'Invoices::Sale',
                    enterprise_id: @enterprise.id
                  )

        invoice.update(
          total: row[keys["Total"].to_i],
          balance: row[keys["Saldo"].to_i],
          description: row[keys["Descripcion"].to_i],
          expiration_date: row[keys["Fecha Vencimiento"].to_i],
          creation_date: row[keys["Fecha emision"].to_i],
        )

        ## if import data was successful
        ## @worksheet.delete_row(index)
      end
    end

    def read_row(row=0)
      @worksheet[row].cells.map { |c| c.value }
    end

    def read_file(file)
      workbook = RubyXL::Parser.parse(file)
      @worksheet = workbook[0]
    end
  end
end
