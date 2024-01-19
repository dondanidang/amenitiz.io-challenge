Amenitiz Backend Coding Challenge
--
# Technical Evaluation Amenitiz Problem to Solve**

You are the developer in charge of building a cash register.
This app will be able to add products to a cart and compute the total price.

## Objective

Build an application responding to these needs.

By application, we mean:
- It can be a CLI application to run in command line
- It is usable while remaining as simple as possible
- It is simple
- It is readable
- It is maintainable
- It is easily extendable

## Solution
The solution is implemented on ruby and includes the following features:
- Ability to open/cancel/complete a basket
- Ability to add/remove products from the basket
- Ability to show the basket with all the products that are inside
- Ability to compute the total of the basket by applying discount according
- Ability to list all the products available
- Ability to list all the discounts available

**Caveat:** Only one basket can be opened at a time.

## How does it work?
After setting up all the dependencies necessary for this application to run you can run:
`ruby cli start` to bootstrap the application. It will:
- set up the local storage
- set default products and discounts to make them ready for usage
- show the instructions about how to use this app.
  **Here some important commands:**
  - `ruby cli product list`: Display all the products
  - `ruby cli discount list`: Display all the discounts
  - `ruby cli basket show`: Show the product in the current basket
  - `ruby cli basket add <product code>`: Add the product with the code in the current basket
  - `ruby cli basket remove <product code>`: Remove the product with the code from the current basket if inside
  - `ruby cli basket compute_total`: Show the basket with all the products as well as the total of the basket with all discounts applied
  - `ruby cli basket cancel`: Cancel the current basket
  - `ruby cli basket complete`: Complete the current basket

## How to set up this?
1. Install [asdf]([url](https://asdf-vm.com/)https://asdf-vm.com/)
2. Clone this repository
3. In the root directory, run `asdf install` to install the ruby version used in this project
4. Run `bundle install` to install all ruby dependencies

## Basic testing
**With these products Registered**
| Product Code | Name | Price |  
|--|--|--|
| GR1 |  Green Tea | 3.11€ |
| SR1 |  Strawberries | 5.00 € |
| CF1 |  Coffee | 11.23 € |

**And these special rules**
- If you buy one green tea, you get another one free
- If you buy 3 or more strawberries, the price should drop to 4.50€.
- If you buy 3 or more coffees, the price of all coffees should drop to 2/3 of the original price.

**We should have the following**
| Basket | Total price expected |  
|--|--|
| GR1,GR1 |  3.11€ |
| SR1,SR1,GR1,SR1 |  16.61€ |
| GR1,CF1,SR1,CF1,CF1 |  30.57€ |
