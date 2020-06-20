class ShodanInfo < Granite::Base
  connection pg
  table shodan_infos
  belongs_to :host
  has_many :shodan_services, class_name: ShodanService
  column id : Int64, primary: true
  column ports : Array(Int32)?
  column os : String?
  column org : String?
  column last_update : String?
  column tags : Array(String)?
  column country_code : String?
  column region_code : String?
  column area_code : String?
  column postal_code : String?
  column city : String?
  column country_name : String?
  column dma_code : String?
  column longitude : Float64?
  column latitude : Float64?
  column hostnames : Array(String)?
  column domains : Array(String)?
  timestamps
end
