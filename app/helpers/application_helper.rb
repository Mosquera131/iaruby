module ApplicationHelper
  def flash_class(key)
    case key.to_sym
    when :notice
      "bg-green-500 text-white"
    when :alert
      "bg-red-500 text-white"
    else
      "bg-gray-500 text-white"
    end
  end
end
