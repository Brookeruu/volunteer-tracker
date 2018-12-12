## Volunteer Tracker ##
=================

Author:
Brooke Perry

### Description: ###
------------
Week 3 of Ruby, Independent Project:


A website where a user can create a project, then add volunteers to it. Both projects and volunteers can be updated and deleted.

### Setup instructions: ###
-------------------
Make sure ruby is installed on your system, if not go here for instructions on installing ruby: https://www.ruby-lang.org/en/documentation/installation/

run:
```
git clone https://github.com/Brookeruu/volunteer-tracker.git
```
```
cd volunteer-tracker
```
```
ruby app.rb
```
and in your browser go to: http://localhost:4567/

Spec:
-----
| Spec                                      | origin                                 | input                  | output                   |
|-------------------------------------------|----------------------------------------|------------------------|--------------------------|
| save a project                            | n/a                                    | "Teaching Code"        | "Teaching code"          |
| get all names of volunteers for a project | n/a                                    | "Teaching Code"        | "Luc", "Xavier"          |
| Update a project's title                  | "Summer Lunch for Kids"                | "Helping Hungry Kids"  | "Helping Hungry Kiddos"  |
| Delete a project                          | "Litter Cleanup", "Humane Society      | "Litter Cleanup        | "Humane Society          |
| get all volunteer names                   | n/a                                    | n/a                    | "Anouk", "Lise", "Adele" |


##### Technologies Used
* Ruby
* Sinatra

##### Contact
* Brooke Perry perrysbrooke@gmail.com

_This software is licensed under the MIT licensed_
Copyright(c) 2018 Brooke Perry
