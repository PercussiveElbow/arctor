class Settings < Granite::Base
  connection pg
  table settings

  column id : Int64, primary: true
  column shodan_key : String?
  column pushover_user_key : String?
  column pushover_app_key : String?
  timestamps
end
