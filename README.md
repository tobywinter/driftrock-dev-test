Viagogo Coding Challenge
========================

## Approach

#### TDD the building of these key features:
- a script that will run in the command line taking one parameter as a command to select which question it will answer

- the script should implement:
- total_spend [EMAIL]: "What is the total spend of the user with this email address[EMAIL]?"
- average_spend[EMAIL]: "What is the average spend of the user with this email address [EMAIL]?"
- most_loyal: "What is the email address of the most loyal user(most purchases)?"
- highest_value: "What is the email address of the highest value user?"
- most_sold: "What is the name of the most sold item"

e.g.
```
$ ruby app.rb total_spend drift.rock@email.com
22.98
$ ruby app.rb most_loyal drift.rock@email.com
```

- A call trying to access the data of ALL purchases or ALL users should run (loop) WHILE checking the number of elements returned on each page. WHEN the number of users or purchases returned is less than the total requested per page - the loop should finish as this is the end of the available data.(Since the only way to know you've reached the end is that the number of entries returned is less than the amount requested per page)

## Structure


## To Run

- clone repository

```
git clone git@github.com:tobywinter/driftrock-dev-test.git
```

Once in the driftrock-dev-test directory

- run the tests

```
rspec
```

- run the App in the console with a command to select your query

e.g.
```
ruby app.rb highest_value
```


## Screenshots
#### Running the App

![Running the App](imgs/run_app.png)

#### Displaying the results
![Displaying the results](imgs/results_display.png)

## Improvements
