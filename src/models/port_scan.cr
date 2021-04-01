class PortScan < Granite::Base
    connection pg
    table port_scans
    belongs_to :host
    column id : Int64, primary: true
    column ports : Array(Int32)?
    column services : Array(String)?
    timestamps
  end
  