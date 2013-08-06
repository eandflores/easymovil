# encoding: utf-8
class Category
    include DataMapper::Resource
    include DataMapper::Timestamp

    property :id,       Serial
    property :name,     String, required: true
    property :slug,     String
    property :position, Integer
    property :enabled,  Boolean, default: true

    timestamps :at

    has n, :products
    has n, :subcategories

end