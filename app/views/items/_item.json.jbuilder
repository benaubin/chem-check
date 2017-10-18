require 'chunky_png'
require 'barby/outputter/png_outputter'

json.extract! item, :code, :amount, :unit, :measurement_str, :details, :id

json.barcode item.barcode && "data:image/png;base64,#{Base64.strict_encode64(item.barcode.to_png)}"

json.checkedOut item.checked_out?

json.session item.current_sessions.first.try :id