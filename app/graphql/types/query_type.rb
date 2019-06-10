module Types
  class QueryType < Types::BaseObject
    
    field :all_articles, [ArticleType], null: false

    field :get_articel, Types::ArticleType, null: true do
      argument(:id, ID, required: true)
    end

    def all_articles
      Article.all
    end

    def get_articel(id:)
      Article.find(id)
    end
  end
end
