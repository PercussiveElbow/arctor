class Screenshot < Granite::Base
    connection pg
    table screenshots 
    belongs_to :subdomain
    column id : Int64, primary: true
    column port : Int32
    column image : String 
    timestamps
  end
  