class Restaurant < ApplicationRecord
  has_many :users
  has_many :tables
  has_many :orders
  has_many :menu_items
  has_many :feedbacks, dependent: :destroy

  has_one_attached :qr

  after_create :generate_qr_code
  # after_update :generate_qr_code

  private

  def generate_qr_code
    @qr_png = RQRCode::QRCode.new("http://127.0.0.1:3000/restaurants/#{id}").as_png
    self.qr.attach(io: StringIO.new(@qr_png.to_s), filename: "filename.png")
  end
end 
