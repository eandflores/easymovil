class Datos
    NOMBRE        = 1
    NUMERO        = 2
    PRECIO        = 3
    PRECIO_NORMAL = 4
    CATEGORIA     = 5
    LOCAL         = 6
    DESCRIPCION   = 7

    def self.xls
        file = File.join(Padrino.root, "datos.xls")

        xls = Roo::Excel.new file

        2.upto(xls.count).each do |i|
            nombre        = xls.cell(i, NOMBRE)
            numero        = xls.cell(i, NUMERO)
            precio        = xls.cell(i, PRECIO)
            precio_normal = xls.cell(i, PRECIO_NORMAL)
            categoria     = xls.cell(i, CATEGORIA)
            local         = xls.cell(i, LOCAL)
            descripcion   = xls.cell(i, DESCRIPCION)

            unless numero.blank?

                cat = Category.first_or_create({name: categoria})
                Product.first_or_create({   name:           nombre}, 
                                        {   local:          local, 
                                            number:         numero, 
                                            price:          precio, 
                                            normal_price:   precio_normal, 
                                            category:       cat, 
                                            image_url:      "http://www.easy.cl/EASYFO_IMGS/img/productos/grande/#{numero.to_i.to_s}.jpg"
                                        })
            end
        end
    end
end