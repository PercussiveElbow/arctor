class SubDomain < Granite::Base
  connection pg
  table sub_domains
  belongs_to :domain
  has_many :sub_domain_host_link, class_name: SubDomainHostLink
  has_many :hosts, class_name: Host, through: :sub_domain_host_link
  column id : Int64, primary: true
  column fqdn : String?
  column a : String?
  column aaaa : String?
  column ns : String?
  column mx : String?
  column txt : String?
  column source : String?
  timestamps
end
