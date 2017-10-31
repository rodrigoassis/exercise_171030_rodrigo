class GroupEventsController < ApplicationController
  before_action :set_group_event, only: [:show, :update, :destroy]

  def index
    @group_events = GroupEvent.all
    json_response(@group_events)
  end

  def show
    json_response(@group_event)
  end

  def create
    @group_event = GroupEvent.create!(group_event_params)
    json_response(@group_event, :created)
  end

  def update
    @group_event.update(group_event_params)
    head :no_content
  end

  def destroy
    @group_event.update(deleted: true)
    head :no_content
  end

  private

  def group_event_params
    params.permit(:name, :description, :start_date, :end_date, :duration, :location, :published)
  end

  def set_group_event
    @group_event = GroupEvent.find(params[:id])
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
