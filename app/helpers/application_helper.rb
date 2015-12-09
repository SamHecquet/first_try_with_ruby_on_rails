module ApplicationHelper

  def gravatar_for(chef, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(chef.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: chef.chefname, class: "gravatar")
  end
  
  def sign_in chef
    session[:chef_id] = chef.id
  end
end
