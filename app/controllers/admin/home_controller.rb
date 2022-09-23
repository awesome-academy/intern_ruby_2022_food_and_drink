class Admin::HomeController < ApplicationController
  def index
    @q = Order.ransack(params)
    if params[:by_start_date].nil? && params[:by_end_date].nil?
      @orders = @q.result.where("created_at >= ?", Time.zone.now.beginning_of_month)
                      .where("created_at <= ?", Time.zone.now.end_of_month)
                      .group_by_day(:created_at)
                      .count
    else
      @orders = @q.result.group_by_day(:created_at).count
    end

    @users = User.user.where("sign_in_count >= 1").order(sign_in_count: :desc).limit(5)
  end
end
