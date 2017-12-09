# frozen_string_literal: true

module ApplicationHelper
  # Translate Rails standard flash keys for Bootstrap
  def flash_alert_class(name)
    case name
    when 'notice' then 'success'
    when 'alert'  then 'danger'
    else name
    end
  end

  def svg_icon(clazz)
    content_tag(:svg, content_tag(:use, "", { "xlink:href" => '#icon-' + clazz }), class: "icon icon-#{clazz}")
  end
end
