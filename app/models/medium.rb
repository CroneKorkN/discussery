class Medium < ActiveRecord::Base
  has_attached_file :file, styles: { thumbnail: "200x200>", full: "10000x10000>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
