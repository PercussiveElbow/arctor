class Host < Granite::Base
  connection pg
  table hosts
  has_many :sub_domain_host_links, class_name: SubDomainHostLink
  column id : Int64, primary: true
  column ipv4 : String?
  column ipv4 : String?
  column source : String?
  timestamps
end
