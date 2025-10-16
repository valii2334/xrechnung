module Xrechnung
  class Party
    include MemberContainer

    # @!attribute name
    #   @return [String]
    member :name, type: String

    # @!attribute postal_address
    #   @return [Xrechnung::PostalAddress]
    member :postal_address, type: Xrechnung::PostalAddress

    # @!attribute party_identification
    #   @return [Xrechnung::PartyIdentification]
    member :party_identification, type: Xrechnung::PartyIdentification

    # @!attribute party_tax_scheme
    #   @return [Xrechnung::PartyTaxScheme]
    member :party_tax_scheme, type: Xrechnung::PartyTaxScheme

    # @!attribute party_legal_entity
    #   @return [Xrechnung::PartyLegalEntity]
    member :party_legal_entity, type: Xrechnung::PartyLegalEntity

    # @!attribute contact
    #   @return [Xrechnung::Contact]
    member :contact, type: Xrechnung::Contact

    member :supplier_party_electronic_address, type: String

    attr_accessor :nested

    def initialize(nested: true, **kwargs)
      super(**kwargs)
      self.nested = nested
    end

    # noinspection RubyResolve
    def to_xml(xml)
      if nested
        xml.cac :Party do
          xml.cbc :EndpointID, supplier_party_electronic_address, schemeID: 'EM'
          party_body(xml)
        end
      else
        party_body(xml)
      end
    end

    private

    def party_body(xml)
      unless name.nil? # if blank? -> empty name tag
        xml.cac :PartyName do
          if name == ""
            xml.cbc :Name
          else
            xml.cbc :Name, name
          end
        end
      end
      party_identification&.to_xml(xml)
      postal_address&.to_xml(xml)
      party_tax_scheme&.to_xml(xml)
      party_legal_entity&.to_xml(xml)
      contact&.to_xml(xml)
    end
  end
end
