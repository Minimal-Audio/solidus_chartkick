# frozen_string_literal: true

Spree::Backend::Config.configure do |config|
  config.locale = 'en'

  # config.menu_items << config.class::MenuItem.new(
  #   [:charts],
  #   'bar-chart',
  #   condition: -> { can?(:manage, ::Spree::Order)  },
  # )
end
