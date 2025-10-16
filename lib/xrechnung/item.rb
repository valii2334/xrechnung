module Xrechnung
  class Item
    include MemberContainer

    # @!attribute description
    #   @return [String]
    member :description, type: String

    # @!attribute name
    #   @return [String]
    member :name, type: String

    # @!attribute standard_item_identification_id
    #   @return [Xrechnung::Id]
    member :standard_item_identification_id, type: Xrechnung::Id, optional: true

    # @!attribute commodity_classification
    #   @return [Xrechnung::TaxCategory]
    member :commodity_classification, type: Xrechnung::TaxCategory

    # @!attribute classified_tax_category
    #   @return [Xrechnung::TaxCategory]
    member :classified_tax_category, type: Xrechnung::TaxCategory

    # noinspection RubyResolve
    def to_xml(xml)
      xml.cac :Item do
        xml.cbc :Description, description
        xml.cbc :Name, name
        unless standard_item_identification_id.nil?
          xml.cac :StandardItemIdentification do
            xml.cbc :ID, standard_item_identification_id.id, schemeID: standard_item_identification_id.scheme_id
          end
        end

        unless commodity_classification.nil?
          xml.cac :CommodityClassification, commodity_classification
        end
        
        classified_tax_category&.to_xml(xml, root_tag_name: :ClassifiedTaxCategory)
      end
    end
  end
end
