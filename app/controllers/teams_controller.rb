class TeamsController < ApplicationController
  def index
    @user  = User.find_by(id: params['user_id'])
    @teams = Team.where("user_id = ? AND status !='default'", params['user_id']).all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @user = User.find_by(id: params['user_id'])
    @team = Team.new
  end

  def edit
    @user = User.find_by(id: params['user_id'])
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(team_params)
    @user = User.find_by(id: params['user_id'])
    respond_to do |format|
      if @team.save
        format.html { redirect_to user_teams_url, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @team = Team.find(params[:id])
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to user_team_url, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @user = User.find_by(id: @team.user_id)
    @team.destroy
    respond_to do |format|
      format.html { redirect_to user_teams_path(@user), notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :status, :user_id)
    end
end
