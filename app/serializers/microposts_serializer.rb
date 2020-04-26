class MicropostsSerializer < ActiveModel::Serializer
    attributes :id, :title , :content
end