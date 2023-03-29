class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  extend DatabaseListenable
  # Be sure to check out a connection, so we stay thread-safe.
end
