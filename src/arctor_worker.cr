require "../config/*"
# Granite::ORM.settings.logger = Mosquito::Base.logger
alias Model = Granite::Base 
# # if not using Quartz, remove
# Quartz.config.logger         = Mosquito::Base.logger
Mosquito::Runner.start