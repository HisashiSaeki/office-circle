class Notice < ApplicationRecord

  belongs_to :group
  has_one :activity, as: :subject, dependent: :destroy


  with_options presence: do
    validates :title, length: { maximum: 100 }
    validates :body
  end

  after_create_commit :create_activities


  def create_activities
    logger.debug("create_activities")
    members = self.group.employees
    logger.debug("members=#{members}")
    members.each{ |member| Activity.create(subject: self, employee: member, action_type: :noticed_to_participating_group) }
  end

end
