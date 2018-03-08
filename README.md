# Code Challenge

Make sure you read all of this document, and follow any guidelines in it. We recommend you pay particular attention to the "What We Care About" section.

## Background

## Requirements

## Getting Started

If you haven't already start by cloning the repository

```
git clone git@github.com:reinteractive/code_challenge
cd code_challenge
```

To setup the project ensure you have the prerequisites installed then simply run

```
bin/setup
```

Once setup is complete, you can run the services using overmind or by running each of the services from the `Procfile` manually.

```
overmind start
```

## Testing

```
bin/rspec
```

## Submitting The Challenge


## What We Care About

**We value quality over feature-completeness**. Due to the time constraints. The goal of this code sample is to help us identify what you consider production-ready code and how you approach and solve problems. Your application will be reviewed by at least two of our developers. We'll go through the code with you afterwards, and you can tell us about how you tackled it, why you chose the approach you did, etc.

Here is what you should aim for with your code:

* **Architecture** How clean is the separation between front-end and back-end. Good object modelling. Is your code easily extensible?

* **Code Quality** Is your code simple, easy to understand and maintain? Are there any code smells or red flags? Does the code follow object-oriented principles such as single responsibility principle? Is the code style consistent throughout the code. Is your code production ready?

* **Security** Are there any obvious vulnerabilities?

* **Testing** How thorough are the automated tests? Will they be difficult to change if the requirements of the application were to change? Are there some unit and some integration tests? What kinds of tests did you focus on?
