class SubDomainHostLink < Granite::Base
    connection pg
    table sub_domain_host_link
    column id : Int64, primary: true
    belongs_to :sub_domain
    belongs_to :host
    timestamps
  end
  