# README

### Setup
`rails db:create`
`rails db:setup`

To view seed data in your SQL client, choose SQLite connection Type and Database File 
`<path-to-repo>/rails-jeopardy/storage/development.sqlite3`


### TODO (right now)
* simplify Javascript (do more on backend)
* why do not all categories have all 5 questions
  * correct query so categories with a $100 value are grouped together

### TODO (eventually)
* implement bots (easy, medium, hard)
* handle <a> links in the data
* double jeopardy (and the rest of the game)
* CSS styling
  * improve quality of alerts
  * make timer match jeopardy timer
* sounds
* deploy to prod
* use Postgres in prod