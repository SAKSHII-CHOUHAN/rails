class Restaurant < ApplicationRecord
  has_many :users
  has_many :tables
  has_many :orders
  has_many :menu_items

  has_one_attached :image

  # after_create :generate_qr_code

  private

  def generate_qr_code
    qr = RQRCode::QRCode.new("http://http://127.0.0.1:3000/restaurants/#{id}")

    qr_image = qr.as_png(
    bit_depth: 1,
    border_modules: 4,
    color_mode: ChunkyPNG::COLOR_GRAYSCALE,
    color: "black",
    file: nil,
    fill: "white",
    module_px_size: 6,
    resize_exactly_to: false,
    resize_gte_to: false,
    size: 120
  )
    self.qr.attach(qr_image) 
  end
end
