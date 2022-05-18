# Dinner Party's Friend (API)
Helps plan food-based social events (i.e. "dinner parties") -- search for recipes, filter by tags, save your favorite recipes and mark once cooked, save your favorite search queries for later!

This is the backend search and other API functionality, using a Postgres database. 
Primarily accepts GET requests in the form of:
```
/recipes.json?query=SEARCH_TERM&tags=COMMA,SEPARATED,TAGS
``` 
and 
```
/recipes/:RECIPE_ID.json
```

Find the frontend with full functionality online at: https://nospame-capstone-frontend.netlify.app/

* Ruby version
3.0.3

* Rails version
7.0.2

* Setup
```
bundle install
```

* Database creation
```
rails db:create
```

* Database initialization
```
rails db:migrate
rails db:seed
```
