class SubDomain < Granite::Base
  connection pg
  table sub_domains
  belongs_to :domain
  has_many :sub_domain_host_link, class_name: SubDomainHostLink
  has_many :hosts, class_name: Host, through: :sub_domain_host_link
  has_many :screenshots, class_name: Screenshot
  column id : Int64, primary: true
  column hijackable : Bool?
  column fqdn : String?
  column a : Array(String)?
  column aaaa : Array(String)?
  column ns : String?
  column mx : String?
  column txt : String?
  column source : String?
  timestamps
end
