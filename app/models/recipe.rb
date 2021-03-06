class Recipe < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, styles: {medium: '300x300#'}
  has_many :ingredients
  has_many :directions

  accepts_nested_attributes_for :ingredients, :directions, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true, length: {minimum: 8}
  validates :description, presence: true, length: {minimum: 15}
  validates :image, presence: true, on: :create
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
