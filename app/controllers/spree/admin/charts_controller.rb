# frozen_string_literal: true

module Spree
  module Admin
    class ChartsController < Spree::Admin::BaseController
      def index
        # some sensible defaults
        params[:period] ||= :day
        params[:start_gt] ||= Time.now - 7.days
        params[:end_lt] ||= Time.now

        params[:period] = params[:period].to_sym
        params[:start_gt] = params[:start_gt].to_datetime
        params[:end_lt] = params[:end_lt].to_datetime
      end
    end
  end
end
