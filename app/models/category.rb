class Category < ApplicationRecord
  enum kind: { sample: 0 , study: 1 } 
end
