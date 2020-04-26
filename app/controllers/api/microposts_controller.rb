class Api::MicropostsController < ActionController::API
  def index
    results = Micropost.search(params)
    # render json: { result: 'OK' }

    render json: ActiveModel::Serializer::CollectionSerializer.new(
      results,
      serializer: MicropostsSerializer
    ).to_json
  end
end
