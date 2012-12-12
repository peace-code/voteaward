class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.define_callbak(provider)
    define_method provider do
      omniauth_signup_or_connect_or_signin(provider)
    end
  end

  User.omniauth_providers.each do |provider|
    define_callbak provider
  end

  protected

    def omniauth_signup_or_connect_or_signin(provider)
      auth_hash = request.env["omniauth.auth"]
      user = User.where({omniauth_uid: auth_hash.uid, email: auth_hash.info.email}).first
      if user.nil?
        user = User.create(
                name: auth_hash.info.name,
                email: auth_hash.info.email,
                password: Devise.friendly_token[0,20],
                "omniauth_provider" => provider,
                "omniauth_uid" => auth_hash.uid,
                "omniauth_credentials" => auth_hash.credentials,
                "omniauth_url" => auth_hash.info.urls[provider.to_s.capitalize],
                "omniauth_image" => auth_hash.info.image,
                "omniauth" => auth_hash.info.urls[provider.to_s.capitalize],
                # remote_image_url: "http://graph.facebook.com/#{auth_hash.uid}/picture?type=large")
              )
        user.save!
      else
        # user.skip_confirmation!
        user.update_attributes({
          "omniauth_provider" => provider,
          "omniauth_uid" => auth_hash.uid,
          "omniauth_credentials" => auth_hash.credentials,
          "omniauth_url" => auth_hash.info.urls[provider.to_s.capitalize],
          "omniauth_image" => auth_hash.info.image,
          "omniauth" => auth_hash.info.urls[provider.to_s.capitalize],
        })
      end
      sign_in_and_redirect user, :event => :authentication, :notice => I18n.t("devise.omniauth_callbacks.success", :kind => provider)
    end
end