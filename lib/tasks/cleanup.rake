task :database_cleanup => :environment do
  task :delete_old_memberships => :environment do
    desc 'Removes all memberships where their users have already been deleted'
    Membership.all.each do |membership|
      if membership.user.nil?
        membership.destroy
      end
    end
  end

  task :delete_old_projects => :environment do
    desc 'Removes all memberships where their projects have already been deleted'
    Membership.all.each do |membership|
      if membership.project.nil?
        membership.destroy
      end
    end
  end

  task :delete_old_tasks => :environment do
    desc 'Removes all tasks where their projects have been deleted'
    Task.all.each do |task|
      if task.project.nil?
        task.destroy
      end
    end
  end

  task :delete_old_comments => :environment do
    desc 'Removes all comments where their tasks have been deleted'
    Comment.all.each do |comment|
      if comment.task.nil?
        comment.destroy
      end
    end
  end

  task :set_old_comments_to_nil => :environment do
    desc 'Sets the user_id of comments to nil if their users have been deleted'
    Comment.all.each do |comment|
      if comment.user.nil?
        comment.user_id = nil
      end
    end
  end

  task :remove_tasks_nil => :environment do
    desc 'Removes any tasks with null project_id'
    Task.all.each do |task|
      if task.project_id.nil?
        task.destroy
      end
    end
  end

  task :remove_comments_nil => :environment do
    desc 'Removes any comments with a null task_id'
    Comments.all.each do |comment|
      if comment.task_id.nil?
        comment.destroy
      end
    end
  end

  task :remove_memberships_nil => :environment do
    desc 'Removes any memberships with a null project_id or user_id'
    Memberships.all.each do |membership|
      if membership.project_id.nil? || membership.user_id.nil?
        membership.destroy
      end
    end
  end
end
