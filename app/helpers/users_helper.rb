module UsersHelper
  def avatar_image(user, version, class_name=nil)
    if user.provider?
      case version
      when :thumb
        image_tag("https://graph.facebook.com/#{user.uid}/picture", size: '30x30', class: class_name)
      when :small
        image_tag("https://graph.facebook.com/#{user.uid}/picture", size: '47x47', class: class_name)
      else
        image_tag("https://graph.facebook.com/#{user.uid}/picture", size: '110x110', class: class_name)
      end
    else
      image_tag(user.avatar_url(version), class: 'class_name')
    end
  end
end
