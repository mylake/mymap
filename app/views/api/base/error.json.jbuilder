json.error true
json.code @exception.try(:to_code) || @exception.class.to_s.underscore
json.message @exception.message
if !Rails.env.production? && @status.to_i == 500
  json.backtrace @exception.backtrace
end
