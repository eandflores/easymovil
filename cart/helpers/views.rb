# encoding: utf-8
VQ::Cart.helpers do
  
  def rend file
    render '../../views/' + file, layout: '../../../views/layouts/application'
  end

  def menu_link name, url, param = :name
    str  = '<a href="'
    str << url
    str << '"'
    str << ' class="active" ' if params[param].eql?(name.to_slug)
    str << '>'
    str << name
    str << '</a>'
  end

  def part file, options = {}
    partial '../../views/' + file, options
  end

  def notices
    str = ""
    unless flash[:notice].blank?
      str << "$.pnotify({title: '#{flash[:notice]}', type: 'success'});"
    end
  end

  # Arma un arreglo para options_for_select a partir de un arreglo de constantes (arr) definidas en una clase (cls)
  def for_select cls, arr, first=""
    fnl = first.blank? ? [] : [ [first, ""] ]
    cls.const_get(arr).each do |i|
        fnl << [i.to_s.humanize.titleize, cls.const_get(i)]
    end
    
    fnl
  end
  # Devuelve un hash con el nombre de un valor en particular
  # => Params
      # => cls : Clase
      # => arr : Arreglo de constantes
      # => val : Valor entero 
  def get_name cls, arr, val
      cls.const_get(arr).each do |i|
          return i.to_s.humanize.titleize if cls.const_get(i).to_s == val.to_s
      end
      return nil
  end

  def value obj, val
      return "" if obj.nil? || obj.send(val).nil?

      obj.send(val)
  end
  
  def get_name_matrix cls, arr, val
      data = []
      vl = val + 1000
      vl = vl.to_s
      k = 1
      while k < vl.length do
          cls.const_get(arr).each do |i|
              data << i.to_s.humanize.capitalize if vl[k] == '1' && ( 1000+ cls.const_get( i ) ).to_s[k] == '1'
          end
          k += 1
      end
      return data.join(", ")
  end

end