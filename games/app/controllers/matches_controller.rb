class MatchesController < ApplicationController

  def edit
    @change_match = Match.find(params[:id])
    @change_match.game_name = Game.find(@change_match.game_id).name
    @change_match.convention_name = Convention.find(@change_match.convention_id).name
  end

  def update
    @change_match = Match.find(params[:id])
    if @change_match.update_attributes(match_params)
      redirect_to games_path
    else
      flash[:alert]="Failed editing"
      render 'edit'
    end
  end

  def show
    @match = Match.find(params[:id])
  end

  def index
    @all_matches = Match.all
    @indeks = 0
  end

  def new
    @match = Match.new
  end

  def create
    match = Match.new(match_params)
    #trzeba pamietac jak odnosimy sie do elementow danej klasy w params to trzeba podac ta klase
    match.game_id = Game.find_by_name(params[:match][:game_name]).id
    match.convention_id = Convention.find_by_name(params[:match][:convention_name]).id
    if match.save
      redirect_to matches_path
    else
      @match = Match.new
      flash[:alert]="Failed creating"
      render 'new'
    end
  end

  def destroy
    Match.delete(params[:id])
    rediredt_to matches_path
  end

  def match_params
    params.require(:match).permit(:time,:seats_number,:price,:game_name,:convention_name)
  end
end
