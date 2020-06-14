class SubDomain < Granite::Base
  connection pg
  table sub_domains
  belongs_to :domain
  column id : Int64, primary: true
  column fqdn : String?
  column a : String?
  column aaaa : String?
  column ns : String?
  column mx : String?
  column txt : String?
  timestamps
end
