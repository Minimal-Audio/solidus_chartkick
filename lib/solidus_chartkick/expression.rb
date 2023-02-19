# frozen_string_literal: true

module SolidusChartkick
  # An expression is a wrapper around a label & lamda which generates
  # the chart you would like to render in your admin panel
  class Expression
    attr_reader :label, :chart_expression

    def initialize(label, chart_expression)
      @label = label
      @chart_expression = chart_expression
    end
  end
end
