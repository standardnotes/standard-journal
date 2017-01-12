Rails.application.routes.draw do

  get "ext/:secret" => "extension#show"

  post "ext/:secret/put" => "extension#put"

  get ":path" => "posts#show"

  root :to => "posts#index"
end
