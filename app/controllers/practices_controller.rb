class PracticesController < ApplicationController
  before_action :set_practice, only: [:show, :edit, :update, :destroy]
  before_action :set_attendees, only: [:show]
  helper_method :sort_column, :sort_direction

  def index
    @practices = Practice.includes(:location).
                          order(sort_column + " " + sort_direction).paginate(:page => params[:page])
  end

  def show
  end

  def new
    @practice = Practice.new
  end

  def edit
  end

  def create
    @practice = Practice.new(practice_params)

    respond_to do |format|
      if @practice.save
        format.html { redirect_to @practice, notice: 'Practice was successfully created.' }
        format.json { render :show, status: :created, location: @practice }
      else
        format.html { render :new }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @practice.update(practice_params)
        format.html { redirect_to @practice, notice: 'Practice was successfully updated.' }
        format.json { render :show, status: :ok, location: @practice }
      else
        format.html { render :edit }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @practice.destroy
    respond_to do |format|
      format.html { redirect_to practices_url, notice: 'Practice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_practice
      @practice = Practice.find(params[:id])
    end

    def set_attendees
      @attendees = @practice.attendees.
                             order(sort_column + " " + sort_direction).
                             paginate(:page => params[:page])
    end

    def practice_params
      params.require(:practice).permit(:location_id, :date, :start, :end, :status)
    end

    def sort_column
      Practice.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
