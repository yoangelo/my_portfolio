module TakeScreenshot
  def take_screenshot
    page.save_screenshot "tmp/capybara/screenshot-#{DateTime.now}.png"
  end
end
