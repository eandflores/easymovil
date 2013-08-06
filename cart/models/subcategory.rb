# encoding: utf-8
class Subcategory < Slug
    include DataMapper::Resource
    include DataMapper::Timestamp

    property :id,       Serial
    property :name,     String, required: true
    property :slug,     String
    property :position, Integer

    timestamps :at

    has n, :products
    belongs_to :category
end