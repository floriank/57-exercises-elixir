# 57 exercises for programmers - Elixir

This is the base repository for my take on the [book 57 exercises](https://pragprog.com/book/bhwb/exercises-for-programmers) for programmers. This is done to keep record of all the exercises I've done to increase my fluency in [Elixir](https://elixir-lang.org).

For some of these execises I used dependencies (it's cumbersome to do HTTP requests or JSON parsing without a library), so make sure to run

```
mix deps.get
```

List of exercises
=================

### 01. Saying Hello - simple output

```
mix run 01-saying-hello.exs
```

Simple "Hello World" with no special constraints.

### 02. Counting characters - String operations

```
mix run 02-counting-characters
```

Simple output with String operations.

### 03. Printing quotes

```
mix run 03-printing-quotes
```

Simple test for String concatenation without interpolation and escaping quotes

### 04. Mad Libs - Dealing Multiple inputs

```
mix run 04-mad-libs.exs
```

Concatenating multiple inputs.

### 05. Simple math

```
mix run 05-simple-math.exs
```

Do simple math operations while sanitizing and converting user input.

### 06. Retirement Calculator

```
mix run 06-retirement-calculation.exs
```

Simple math in combination with basic DateTime functionality.

### 07. Rectangular Room

```
mix run 07-recatngular-room.exs
```

Calculating an area while using conversion.

### 08. Pizza Party

```
mix run 08-pizza-party.exs
```

Calculate the number of slices from a pizza (remainder division)

### 09. Paint calculator

```
mix run 09-paint-calculator.exs
```

Given the area of a room, calculate the number of buckets needed to cover the rooms area with paint.

### 10. Item checkout

```
mix run 10-item-checkout.exs
```

Implement a calculation for arbitrary items during checkout (e.g. at a super market).

### 11. Currency exchange

```
mix run 11-currency-exchange.exs
```

Implement a calculation for arbitrary items during checkout (e.g. at a super market), optionally using the OpenExchangeRates API.

### 12. Computing interest

```
mix run 12-computing-interest.exs
```

Computes the simple interest value over a number of years:

Challenges:

- Ensure that the values entered for principal, rate, and number of years are numeric 
- Calculate the end value of the investment
- print the amount at the end of each year

### 13. Computing compound interest

```
mix run 13-computing-compound-interest.exs
```

Computes compound interest over a number of years.

### 14. Tax calculator

```
mix run 14-tax-calculator.exs
```

A simple program that checks for the users state and displays a total amount in- or excluding tax.

### 15. Validating passwords

```
mix run 15-validating-passwords.exs
```

Simple password validation to test if/else branches.

### 16. Legal driving age

```
mix run 16-legal-driving-age.exs
```

Asks the user for their age and then decides if they're old enough to drive.

### 17. Blood alcohol calculator

```
mix run 17-blood-alcohol-calculator.exs
```

Asks the user for their body measurements and drinks had and decides whether or not they are allowed to drive.

### 18. Temperature converter

```
mix run 18-temperature-converter.exs
```

Simple temperature conversion between Fahrenheit and Celsius. Uses an input loop.

### 19. BMI calculator

```
mix run 19-bmi-calculator.exs
```

Given measurements of a person, calculate their BMI (Body mass index).

### 20. Multistate Tax Calculator 

```
mix run 20-multistate-tax-calculator.exs
```

Calculate tax rates for different states in the US, with some branching options for different counties.


### 21. Numbers to names

```
mix run 21-numbers-to-names.exs
```

Converts numbers to month names.
