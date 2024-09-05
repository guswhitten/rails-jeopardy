# README

### Setup
`rails db:create`
`rails db:setup`

To view seed data in your SQL client, choose SQLite connection Type and Database File 
`<path-to-repo>/rails-jeopardy/storage/development.sqlite3`


### TODO (right now)
* CSS styling
  * improve quality of alerts
* navbar
* footer?

### TODO (eventually)
* convert remaining .tsv data to usable question data and import
* allow popover for looking at past question metadata:
  * clue, value, answer
  * who answered and result
* end of game...announce winner
* sounds?
* simplify Javascript (do more on backend)


## Limitations
* handle <a> links in the data (remove)