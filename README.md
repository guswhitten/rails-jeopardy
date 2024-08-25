# README

### Setup
`rails db:create`
`rails db:setup`

To view seed data in your SQL client, choose SQLite connection Type and Database File 
`<path-to-repo>/rails-jeopardy/storage/development.sqlite3`


### TODO (right now)
* simplify Javascript (do more on backend)
* CSS styling
  * improve quality of alerts
  * make timer match jeopardy timer
* fix score so negative comes before money sign

### TODO (eventually)
* implement bots (easy, medium, hard)

* double jeopardy (and the rest of the game)
* sounds
* deploy to prod
* use Postgres in prod

## Limitations
* handle <a> links in the data
  * jarchive does not have actual images for these links