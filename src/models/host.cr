class Host < Granite::Base
  connection pg
  table hosts
  has_many :sub_domain_host_links, class_name: SubDomainHostLink
  has_many :subdomains, class_name: Subdomain, through: :sub_domain_host_link
  has_one :shodan_info, class_name: ShodanInfo
  has_many :port_scans, class_name: PortScan
  column id : Int64, primary: true
  column ipv4 : String?
  column ipv6 : String?
  column source : String?
  timestamps
end
