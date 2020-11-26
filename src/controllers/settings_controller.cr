class SettingsController < ApplicationController
    def index
      saved = false
      settings = Settings.first
      render("settings.slang")
    end

    def save 
      if params
        shodan_key = params[:shodan_key] ? params[:shodan_key] : ""
        pushover_user_key = params[:pushover_user_key] ? params[:pushover_user_key] : ""
        pushover_app_key = params[:pushover_app_key] ? params[:pushover_app_key] : ""

        existing_settings = Settings.all
        if existing_settings
          existing_settings.each do |existing_setting|
            existing_setting.destroy
          end
        end
        settings = Settings.create(pushover_user_key: pushover_user_key, pushover_app_key: pushover_app_key, shodan_key: shodan_key)
        puts("Saved settings")

      else
        settings = Settings.first
      end
      saved=true
      render("settings.slang")
    end

  end
  