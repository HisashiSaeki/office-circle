class Favorite < ApplicationRecord

  belongs_to :employee
  belongs_to :article
end
