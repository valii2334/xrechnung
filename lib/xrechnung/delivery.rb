module Xrechnung
  class Delivery
    include MemberContainer

    # @!attribute actual_delivery_date
    #   @return [Date]
    member :actual_delivery_date, type: Date

    def to_xml(xml)
      xml.cac :Delivery do
        xml.cbc :ActualDeliveryDate, actual_delivery_date
      end
    end
  end
end
