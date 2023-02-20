# frozen_string_literal: true

SolidusChartkick.configure do |config|
  include Chartkick::Helper

  # User Created Chart
  config.expressions << SolidusChartkick::Expression.new(
    'Users Created',
    'col-12',
    ->(period, start_gt, end_lt) {
      scope = Spree::User.group_by_period(period, :created_at, range: start_gt..end_lt)
      area_chart scope.count
    }
  )

  # Order Total Chart
  config.expressions << SolidusChartkick::Expression.new(
    'Order Totals',
    'col-12',
    ->(period, start_gt, end_lt) {
      scope = Spree::Order.complete.group_by_period(period, :completed_at, range: start_gt..end_lt)
      area_chart scope.sum(:total), prefix: '$', thousands: ','
    }
  )

  # Product Sold Via Count
  config.expressions << SolidusChartkick::Expression.new(
    'Products Sold',
    'col-12',
    ->(_period, start_gt, end_lt) {
      scope = Spree::Order.where(completed_at: start_gt.beginning_of_day..end_lt.end_of_day).joins(:products)
      column_chart scope.group(:name).count
    }
  )
end
