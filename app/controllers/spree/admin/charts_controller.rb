# frozen_string_literal: true

module Spree
  module Admin
    class ChartsController < Spree::Admin::BaseController
      include Chartkick::Helper

      def index
        # some sensible defaults
        params[:period] ||= :day
        params[:start_gt] ||= Time.now - 7.days
        params[:end_lt] ||= Time.now

        params[:period] = params[:period].to_sym
        params[:start_gt] = params[:start_gt].to_datetime
        params[:end_lt] = params[:end_lt].to_datetime

        @expressions = []

        label = "Users Created"
        @expressions << SolidusChartkick::Expression.new(label, -> (period, start_gt, end_lt) {
          scope = Spree::User.group_by_period(period, :created_at, range: start_gt..end_lt)
          line_chart scope.count
        })

        label = "Order Totals"
        @expressions << SolidusChartkick::Expression.new(label, -> (period, start_gt, end_lt) {
          scope = Spree::Order.complete.group_by_period(period, :completed_at, range: start_gt..end_lt)
          line_chart scope.sum(:total)
        })

        label = "Products Sold | Excluded : [RFL, RFBL, Cypher]"
        @expressions << SolidusChartkick::Expression.new(label, -> (_period, start_gt, end_lt) {
          scope = Spree::Order.where(completed_at: start_gt.beginning_of_day..end_lt.end_of_day).joins(:products)
          res = scope.group(:name).count
          res.delete("Rift Filter Lite")
          res.delete("Rift Feedback Lite")
          res.delete("Cypher")
          column_chart res
        })
      end
    end
  end
end
