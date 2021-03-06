module Spree
  class Calculator::AmountTimesConstant < Calculator
    preference :multiplier, :decimal

    preference :min_amount, :integer, default: 0
    preference :max_amount, :integer, default: 100

    def self.description
      "Amount Times Constant Calculator"
    end

    def self.register
      super
      ProductCustomizationType.register_calculator(self)
    end

    def create_options
      # This calculator knows that it needs one CustomizableOption named amount
      [
       CustomizableProductOption.create(name: "amount", presentation: "Amount")
      ]
    end

    def compute(product_customization, variant=nil)
      # expecting only one CustomizedProductOption
      opt = product_customization.customized_product_options.detect {|cpo| cpo.customizable_product_option.name == "amount" } rescue 0.0
      opt.value.to_i * preferred_multiplier
    end
  end
end
