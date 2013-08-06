class Slug
    def self.set item, attribute = :name
        item.update slug: (item.id.to_s + "_" + item.attributes[attribute].to_slug) if item.slug.blank?
    end
end