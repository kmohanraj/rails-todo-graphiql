module Types
  class MutationType < Types::BaseObject
    field :createArticle, mutation: Mutations::CreateArticle
  end
end
