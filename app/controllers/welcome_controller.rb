class WelcomeController < ApplicationController
  def index
    @quotes = [["waffle iron has made life around the house sane again","Casey Kelly"],["A little organization is all I needed to finally get caught up!", "Skeeter Thomas"],["Wow! Really helpful!","Walter Westinghouse"]]
  end

  def about
    @users = User.all
    @projects = Project.all
    @memberships = Membership.all
    @tasks = Task.all
    @comments = Comment.all
  end

  def terms
  end

  def tasks
  end


end
