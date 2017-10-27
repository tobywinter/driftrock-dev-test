Viagogo Coding Challenge
========================

## Approach

#### TDD the building of these key features:
- a script that will run in the command line taking one parameter as a command to select which question it will answer

- the script should impliment:
- total_spend [EMAIL]: "What is the total spendof the user with this email address[EMAIL]?"
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
