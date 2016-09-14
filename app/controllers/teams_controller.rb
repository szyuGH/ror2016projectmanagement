class TeamsController < ApplicationController
  before_action :set_member, only: [:remove_member, :promote_member, :demote_member]
  before_action :set_team
  before_action :authenticate_user!
  before_action :check_access_rights


  # GET /teams/1
  # GET /teams/1.json
  def show
    @members = @team.members
  end

  def add_member
    @member = TeamMember.new
  end

  def create
    @member = TeamMember.new(member_params)
    @member.team = @team
    @team.members.push(@member)
    respond_to do |format|
      if @member.save && @team.save
        format.html { redirect_to project_team_path(@team.project), notice: 'Member was successfully added to the team.' }
        format.json { render :show, location: @team }
      else
        format.html { render :add_member }
        format.json { render json: @team.errors, status: :unpromotable_entity }
      end
    end
  end

  def remove_member
    @team.members.delete(@member)
    respond_to do |format|
      if @team.save
        format.html { redirect_to project_team_path(@team.project), notice: 'Member was successfully removed from the team.' }
        format.json { render :show, location: @team }
      else
        format.html { render :show }
        format.json { render json: @team.errors, status: :unpromotable_entity }
      end
    end
  end

  def promote_member
    @member.is_admin = true
    respond_to do |format|
      if @member.save
        format.html { redirect_to project_team_path(@team.project), notice: 'Member was successfully promoted to admin.' }
        format.json { render :show, location: @team }
      else
        format.html { render :show }
        format.json { render json: @team.errors, status: :unpromotable_entity }
      end
    end
  end

  def demote_member
    @member.is_admin = false
    respond_to do |format|
      if @member.save
        format.html { redirect_to project_team_path(@team.project), notice: 'Member was successfully demoted.' }
        format.json { render :show, location: @team }
      else
        format.html { render :show }
        format.json { render json: @team.errors, status: :undemotable_entity }
      end
    end
  end

  private
    def set_member
      @member = TeamMember.find(params[:member_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.select{|t| t.project_id  == params[:project_id].to_i}.first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.fetch(:team, {})
    end

    def member_params
      params.require(:team_member).permit(:user_id, :is_admin)
    end

    def check_access_rights
      if current_user.project_hierarchy?(@team.project) < 0
        go_back
      end
    end
end
