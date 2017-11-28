module UsersHelper

  def picture_for(user)
    if user.picture?
      picture_url = user.picture
      image_tag(picture_url, alt: user.name, width: '60', height: '60')
    else
      image_tag("top.png", alt: user.name, width: '60', height: '60')
    end
  end
end