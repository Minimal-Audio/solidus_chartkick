# frozen_string_literal: true

SolidusChartkick.configure do |config|
  include Chartkick::Helper

  # User Created Chart
  config.expressions << SolidusChartkick::Expression.new('Users Created', -> (period, start_gt, end_lt) {
    scope = Spree::User.group_by_period(period, :created_at, range: start_gt..end_lt)
    line_chart scope.count
  })

  # Order Total Chart
  config.expressions << SolidusChartkick::Expression.new('Order Totals', -> (period, start_gt, end_lt) {
    scope = Spree::Order.complete.group_by_period(period, :completed_at, range: start_gt..end_lt)
    line_chart scope.sum(:total)
  })

  # Product Sold Via Count
  config.expressions << SolidusChartkick::Expression.new('Products Sold', -> (_period, start_gt, end_lt) {
    scope = Spree::Order.where(completed_at: start_gt.beginning_of_day..end_lt.end_of_day).joins(:products)
    column_chart scope.group(:name).count
  })
end
