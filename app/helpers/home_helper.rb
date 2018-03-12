module HomeHelper
  def root_path?
    current_page?(root_path)
  end
end
