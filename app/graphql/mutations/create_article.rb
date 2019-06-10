module Mutations
  class CreateArticle < GraphQL::Schema::RelayClassicMutation

    field :article, Types::ArticleType, null: false
    argument(:title, String, required: true)
    argument(:desc, String, required: true)

    def resolve(title:, desc:)
      article = Article.create!(title: title, desc: desc)
      {
        article: article
      }
    end

    def delete_resolve(id:)
      article = Article.find(id)
      article.destroy!
      { article: article }
    end

  end
end
