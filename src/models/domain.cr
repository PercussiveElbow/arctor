class Domain < Granite::Base
  connection pg
  table domains
  has_many :subdomains, class_name: SubDomain
  column id : Int64, primary: true
  column fqdn : String?
  timestamps
end
