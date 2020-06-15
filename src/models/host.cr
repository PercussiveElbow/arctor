class Host < Granite::Base
  connection pg
  table hosts

  column id : Int64, primary: true
  column ipv4 : String?
  column ipv4 : String?
  column source : String?
  timestamps
end
