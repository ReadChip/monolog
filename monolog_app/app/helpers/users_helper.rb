module UsersHelper

  def picture_for(user)
    picture_url = user.picture
    if user.picture?
      image_tag(picture_url, alt: user.name, width: '80', height: '80')
    else
      image_tag("top.png", alt: user.name, width: '80', height: '80')
    end
  end
end