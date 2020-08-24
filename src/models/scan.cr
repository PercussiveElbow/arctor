class Scan < Granite::Base
  connection pg
  table scans
  column id : Int64, primary: true
  # has_many :domains, class_name: Domain
  column target_query : String?
  column scan_status : String?
  column error_reason : String?
  column stages : Array(String)?
  timestamps
end
