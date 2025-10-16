module Xrechnung
  class AllowanceCharge
    include MemberContainer

    # @!attribute charge_indicator
    #   @return [TrueClass, FalseClass]
    member :charge_indicator, type: [TrueClass, FalseClass]

    # @!attribute amount
    #   @return [Xrechnung::Currency]
    member :amount, type: Xrechnung::Currency

    def initialize(**kwargs)
      kwargs[:amount]      = Currency::EUR(kwargs[:amount])
      super(**kwargs)
    end

    # noinspection RubyResolve
    def to_xml(xml)
      xml.cac :AllowanceCharge do
        xml.cbc :ChargeIndicator, charge_indicator
        xml.cbc :Amount, *amount.xml_args
      end
    end
  end
end
