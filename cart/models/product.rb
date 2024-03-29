# encoding: utf-8
class Product
    include DataMapper::Resource
    include DataMapper::Timestamp

    property :id,           Serial
    property :name,         String, required: true
    property :slug,         String
    property :description,  Text, lazy: false
    property :price,        Integer, default: 0
    property :normal_price, Integer, default: 0
    property :counter,      Integer, default: 0
    property :add_to_cart,  Integer, default: 0
    property :sells,        Integer, default: 0


    #mount_uploader :image, ImageUploader


    timestamps :at

    belongs_to :category, required: false
    belongs_to :subcategory, required: false

    property :number,       Integer
    property :local,        String
    property :image_url,    String

end