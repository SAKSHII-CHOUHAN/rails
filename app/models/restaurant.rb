class Restaurant < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :tables, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :menu_items, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_one :admin_user, dependent: :destroy

  validates :name, :address, :owner_name, presence: true
  validates :owner_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one_attached :qr

  after_create :generate_qr_code

  private

  def generate_qr_code
    @qr_png = RQRCode::QRCode.new("http://127.0.0.1:3000/restaurants/#{id}").as_png
    self.qr.attach(io: StringIO.new(@qr_png.to_s), filename: "filename.png")
  end
end 
