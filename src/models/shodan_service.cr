class ShodanService < Granite::Base
  connection pg
  table shodan_services
  belongs_to :shodan_info
  column id : Int64, primary: true
  column isp : String?
  column asn : String?
  column hostnames : Array(String)?
  column domains : Array(String)?
  column os : String?
  column banner : String? 
  column version : String?
  column cpes : Array(String)?
  column product : String?
  column port : Int32? 
  column hash : Int64?
  timestamps
end
