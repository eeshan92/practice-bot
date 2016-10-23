class Api::V1::PlayersController < Api::V1::BaseController
  before_action :set_player, only: [:show, :update, :destroy]

  def index
    @players = Player.filter(params.slice(:name, :gender, :foreign_id, :handle))
    render json: @players.to_json, status: :ok
  end

  def show
    render json: @player.to_json, status: :ok
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      render json: @player.to_json
    else
      render json: { errors: @player.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @player.update(player_params)
      render json: { id: @player.to_json }, status: :ok
    else
      render json: { errors: @player.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    render json: { deleted: @player.destroy.destroyed? }
  end

  private
    def set_player
      @player = Player.find(params[:id])
      rescue Exception
        render json: { error: "Resource Not Found" }, status: :not_found
    end

    def player_params
      params.require(:player).permit(:foreign_id, :name, :handle, :gender)
    end
end
