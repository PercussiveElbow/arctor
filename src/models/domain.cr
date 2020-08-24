class Domain < Granite::Base
  connection pg
  table domains
  has_many :subdomains, class_name: SubDomain
  # belongs_to :scan
  column id : Int64, primary: true
  column fqdn : String?
  timestamps
end
