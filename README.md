# README

### URL

DEMO: https://testofumai.herokuapp.com/


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
- In your command line run - `rake db:seed` (_It'll populate the database with default data_)


### Problem Statement

Consider an example where List has many ListItem.

1. Build a page to create, edit and list all the lists and their list items
2. Display all the items of the list below each list
3. Provide a button called destroy alongside the list and the list items to soft delete the list and their items
4. If the list is destroyed the items should also be destroyed
5. If the items are destroyed the list should not get destroyed

Write the soft delete logic in a module that can be re-used in other models as well.
7. Provide a button called delete alongside the list and the list items to hard delete the list and their items
8. Build another page called trash to list all the list and list items that are soft deleted
9. Provide a button called restore alongside the item/list that is soft deleted. Clicking on the button should restore the list or the list item correspondingly.

Deploy the app in Heroku.

Things to remember for this task,

1. There should be no code duplication.
2. The page should not reload while doing any actions available on a page.
3. IMPORTANT: Do not use any gems for soft delete feature.
4. Write test cases for all the actions that you are doing.