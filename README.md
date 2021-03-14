# Backend coding challenge
This project is my answer to the coding challenge for a backend developer position at SeQura.

## The challenge
SeQura provides ecommerce shops (merchants) a flexible payment method so their customers (shoppers) can purchase and receive goods without paying upfront. SeQura earns a small fee per purchase and pays out (disburse) the merchant once the order is marked as completed.

The operations manager is now asking you to make a system to calculate how much money should be disbursed to each merchant based on the following rules:

* Disbursements are done weekly on Monday.
* We disburse only orders which status is completed.
* The disbursed amount has the following fee per order:
  * 1% fee for amounts smaller than 50 €
  * 0.95% for amounts between 50€ - 300€
  * 0.85% for amounts over 300€

We expect you to:

* Create the necessary data structures and a way to persist them for the provided data. You don't have to follow our schema if you think another one suits better.
* Calculate and persist the disbursements per merchant on a given week. As the calculations can take some time it should be isolated and be able to run independently of a regular web request, for instance by running a background job.
* Create an API endpoint to expose the disbursements for a given merchant on a given week. If no merchant is provided return for all of them.

## How to setup
I have created the application with Ruby 2.7.2 and Rails 6.1.3. I have chosen MySQL database because I am used to it but it can be done with another, and I have used [RuboCop gem](https://github.com/rubocop/rubocop) to get code analyzer and formatter.

First, you need to add your database configuration in `config/database.yml` file.

Then, run the following commands to create and populate the database:

```
bundle install
rails db:create
rails db:migrate
rails db:seed
```

And finally, run the server:

```
rails server
```

## Data structures
I have followed the same schema with minor changes, the application has four models:

* Merchant
  * name, email and cif should not be null.
  * email should be valid.
  * cif should be unique and have length 10.
  * timestamps should be added.
* Shopper
  * name, email and nif should not be null.
  * email should be valid.
  * nif should be unique and have length 10.
  * timestamps should be added.
* Order
  * merchant_id, shopper_id and amount should not be null.
  * amount should be positive, read-only and have default 0.
  * timestamps should be added.
* Disbursement
  * merchant_id, week, year, total_orders, total_amount and total_disburse should not be null.
  * total_orders, total_amount and total_disburse should be positive and have default 0.
  * merchant_id, week and year combination should be unique.
  * timestamps should be added.

## API endpoint
I have created a GET route `/api/v1/disbursements` to get the disbursements using API versioning and JSON format. It needs three query parameters, two required (week and year) and one optional (merchant_id). For example:

```
http://localhost:3000/api/v1/disbursements?week=1&year=2018&merchant_id=1
```

The controller `DisbursementsController` has only one method which calls to the service method. The service `DisbursementService` has two methods to get or create disbursements for a week of the year, both with keyword arguments.

The endpoint has a low response time because it makes a single call to the Disbursement table, the data is previously created to avoid calculation time. The body has the following format:

```
{
  "data": [
    {
      "id": 1,
      "merchant_id": 1,
      "week": 1,
      "year": 2018,
      "total_orders": 10,
      "total_amount": 3039.44,
      "total_disburse": 3013.48,
      "created_at": "2018-01-01T00:00:00.000Z",
      "updated_at": "2018-01-01T00:00:00.000Z",
    },
    ...
  ]
}
```

Also, I have used [Apipie gem](https://github.com/Apipie/apipie-rails) to describe endpoints and handle invalid parameters. The documentation is available in `/apipie` route.

## Run tests
I have created 26 tests with 44 assertions in total using Minitest. I usually create the tests at the same time that I create the task and I review them again at the end of every completed task.

Run all tests with the following command:

```
rails test
```

Also, I have used [SimpleCov gem](https://github.com/simplecov-ruby/simplecov) to gather code coverage data of models, services and controllers, which shows 100%.

## Pending tasks

* Create a background job that executes the rake command `rake run:disbursements_weekly` using Sidekiq.
* Ensure and test that new disbursements are created every Monday.
* Implement API key to avoid unauthorized requests, logger, cache, more tests, ...

**THANKS FOR READING!!**
