class Scan < Granite::Base
  connection pg
  table scans
  column id : Int64, primary: true
  column scan_status : String?
  column error_reason : String?
  timestamps
end
