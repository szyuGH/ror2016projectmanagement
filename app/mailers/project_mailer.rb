class ProjectMailer < ActionMailer::Base
  default from: 'pm@ror2016pm.de'
  # layout 'mailer'

  def team_user_added_email(user, project)
    @user = user
    @project = project
    mail(to: user.email, subject: 'You have been added to a project!')
  end

  def team_user_removed_email(user, project)
    @user = user
    @project = project
    mail(to: user.email, subject: 'You have been removed from a project!')
  end

  def team_user_promoted_email(user, project)
    @user = user
    @project = project
    mail(to: user.email, subject: 'You have been promoted in a project!')
  end

  def team_user_demoted_email(user, project)
    @user = user
    @project = project
    mail(to: user.email, subject: 'You have been demoted in a project!')
  end
end
