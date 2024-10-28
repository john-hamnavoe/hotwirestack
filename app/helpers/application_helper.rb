module ApplicationHelper
  def svg_icon(name, width: 24, height: 24, color: "currentColor", classes: "")
    file_path = "icons/#{name}.svg"

    inline_svg_tag(file_path,
      class: classes,
      width: width,
      height: height,
      style: "stroke: #{color}; fill: none;",
      aria: true)
  end
end
