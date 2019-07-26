# README


### Features

- Create Lists
- Insert List Items under Lists
- Soft Delete: Lists/List Items
- Restore Lists/List Items
- CRUD: List/List Items

### Requirements

- Ruby: `2.5.1`
- Rails: `5.2.2`
- PostgreSQL/MySQL/Sqlite3

### Installation

- Clone the repository.
- Goto cloned repository using - `cd soft_deletable_umaitest/` (or whatever your local project folder name)
- Install required gems(libraries) - `bundle install`
- In your command line run - `rake db:create`  (_It'll create a new database in mysql_)
- In your command line run - `rake db:migrate`  (_It'll add tables to your  newly created database_)
- In your command line run - `rspec spec/controllers/`  (_It'll do the controller tests, results can be found inside coverage folder_)