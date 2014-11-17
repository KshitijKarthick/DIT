# DIT - [Data Import Tool] :
### Utilised for: https://github.com/KshitijKarthick/Student-Portal
## Program Features : [Implemented for the Reva University]
   * A Lightweight Data Import Tool for the Backend Server implementation of a Student Portal.
   * Individual Ruby Scripts to Perform Individual Relation Importing into the Database.
   * Each Ruby Script is Atomic and can be run Independently.
   * Stores all the Data managed in a Database from the Excel Sheet.
  
## Program Details :
   * Program is written in Ruby.
   * Implements ORM in the Program to map it into the Database.
   * DataMapper utilised for creating the Models and mapping it into the respective Relational Database.
   * Valid Excel file given shall be imported into the Database.
   * Excel Filename -> Table Name
   * Sheet1 is by Default always Imported.
   * Column Names -> Attribute Names in the Table.
   * Rows -> Tuples in the Database.
   * program.rb -> Implemented for all the tables ony by one or individual.

## Program Execution :
```
  # Windows and Posix OS Compliant.[Requirements: Bundler and Ruby]
  > bundle install
  > cd scripts
  > ruby program.rb [script name]/all
    * Example :
      * ruby program.rb course
      * ruby program.rb all

```

## To Do :
  * Add Generic Features for the Data Import Tool.
  * An Web Interface for the Data Import Tool.
  * Better Security incorporation in the Application.