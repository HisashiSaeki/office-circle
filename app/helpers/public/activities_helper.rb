module Public::ActivitiesHelper


  def transition_path(activity)
    case activity.action_type.to_sym
    when :commented_to_own_article
      article_path(activity.subject.article, anchor: "comment-#{activity.subject.id}")
    when :liked_to_own_article
      article_path(activity.subject.article)
    end
  end


end
