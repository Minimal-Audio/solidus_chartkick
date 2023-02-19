# frozen_string_literal: true

module Spree
  module Admin
    class ChartsController < Spree::Admin::BaseController
      def index
        # some sensible defaults
        params[:start_gt] ||= Time.now - 7.days
        params[:end_lt] ||= Time.now

        params[:start_gt] = params[:start_gt].beginning_of_day
        params[:end_lt] = params[:end_lt].end_of_day
      end
    end
  end
end
