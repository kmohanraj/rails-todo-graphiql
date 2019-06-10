## Rails with GraphQL

## 1.Installation

Create a new rails project
```
rails new rails-graphql 
```

We are going to use the graphql-ruby gem,
```
gem 'graphql'
```

THEN, run bundle install
```
bundle install
```

Then, Generate graphql
```
rails generate graphql:install
```

Then, create database,
```
rails db:create
```

Then, Start rails server and url like this,
```
http://localhost:3000/graphiql
```

## 2.Create Model

Create an article model
```
rails g model article title:string description:text
```

Add, Validation to the [article.rb](article.rb)
```
class Article < ApplicationRecord
 validates :title, :desc, presence: true
end
```

Then, Migrate
```
rails db:migrate
```

## 2.Queries

Create the new [Article type](article_type.rb)
```
class Types::ArticleType < Types::BaseObject
 graphql_name 'Article'
 field :id, ID, null: false
 field :title, String, null: false
 field :desc, String, null: false
end
```

Update [QueryType](query_type.rb)
```
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

```

## 3.Mutations

>GraphQL allows you to easily modify the data by means of mutation.
Creating, updating, and deleting database records.
Creating associations.
Cleaning the cache.
Working with files.


you need a new mutation
```
rails g graphql:mutation create_article
```

Then, Create a new file

```
app/graphql/mutations/created_article.rb
``` 

create a new file [Mutations](created_article.rb),
```
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
  end
end
```

Then Field for [Mutation](mutation_type.rb),
```
module Types
  class MutationType < Types::BaseObject
    field :createArticle, mutation: Mutations::CreateArticle
  end
end

```

