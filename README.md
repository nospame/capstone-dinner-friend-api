# Dinner Party's Friend (API)
Helps plan food-based social events (i.e. "dinner parties") by searching for recipes based on ingredient or tags and giving information on drink pairings. 

This is the backend search only, accepting GET requests for `/recipes.json?query=SEARCH_TERM&offset=OPTIONAL_ITEMS_TO_SKIP` and `/recipes/:RECIPE_ID.json`.

* App version
0.3

* Ruby version
3.0.3

* Rails version
7.0.2

* Setup
```bundle install```

* Database creation
```rails db:create```

* Database initialization
```rails db:migrate
rails db:seed
```
