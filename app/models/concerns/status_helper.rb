module StatusHelper
  def set_status
    public_send("#{status_check}!")
  end

  def status_check
    # implement custom verison of this method in each including class/module
    :draft
  end
end
