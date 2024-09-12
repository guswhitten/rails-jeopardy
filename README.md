# README

### Setup
`rails db:create`
`rails db:setup`

To view seed data in your SQL client, choose SQLite connection Type and Database File 
`<path-to-repo>/rails-jeopardy/storage/development.sqlite3`


### TODO (right now)
* flash error when past game not found

### TODO (eventually)
* CSS styling
  * improve quality of alerts
* convert remaining .tsv data to usable question data and import
* allow popover for looking at past question metadata:
  * clue, value, answer
  * who answered and result
* end of game...announce winner
* sounds?
* simplify Javascript (do more on backend)
* use turbo streams
* add ability to return to current game if navigating away
  * session-based


## Limitations
* remove <a> & </br> tags in the data