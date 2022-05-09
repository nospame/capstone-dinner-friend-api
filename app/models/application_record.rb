class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  Whereable = Struct.new(
    :valid,
    :where,
    keyword_init: true
  )

end
