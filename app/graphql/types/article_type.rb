class Types::ArticleType < Types::BaseObject
  graphql_name 'Article'
  field :id, ID, null: false
  field :title, String, null: false
  field :desc, String, null: false
end