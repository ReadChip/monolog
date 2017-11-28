module MicropostsHelper

    def picture_for(user)
    if user.picture?
      picture_url = user.picture
      image_tag(picture_url, alt: user.name, width: '40', height: '40')
    else
      image_tag("top.png", alt: user.name, width: '80', height: '80')
    end
  end
end
