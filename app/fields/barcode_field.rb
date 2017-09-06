require "administrate/field/base"

require 'chunky_png'
require 'barby/outputter/png_outputter'

class BarcodeField < Administrate::Field::Base
  def data_uri
    raw = data.to_png
    "data:image/png;base64,#{Base64.strict_encode64(raw)}"
  end

end
