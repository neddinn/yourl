class WelcomeController < ApplicationController
  before_filter :set_links, :only=>[:show]

  def index
    @recents = Link.recent_links
    @top_links = Link.top_links
  end

  def show
    if !@link.nil?
      redirect_to @link.long_url
    else
      render welcome_index_path
    end
  end

  private
    def set_links
      @link = Link.find_by short_url: params[:id]
      if @link
        View.create(link_id: @link.id, referrer: request.referrer, request_ip: request.remote_ip, country: request.location.country)
      else
        no_record_error 
      end
    end

    def no_record_error
      flash[:notice] = "No record Found"
      redirect_to root_path
      return
    end
end
