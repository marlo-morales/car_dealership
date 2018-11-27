# Code Challenge

Make sure you read all of this document, and follow any guidelines in it. We recommend you pay particular attention to the "What We Care About" section.

To keep things fair we ask that you do not publish this code or your completed version anywhere, thanks.

## Background

We had an intern start building our new blog which will offer a teaser of information before expecting users to pay to continue reading the content. There are a number of features we need implemented to consider this a minimum viable product.

The features we require to be completed are:

* Allow posts to be tagged.
* Allow someone to be able to comment on a post and reply to a comment using AJAX.
* Show a preview of the post, asking the user to purchase access to the full post using Stripe.

The features we wouldn't mind if you have some spare time, but aren't required are:

* Allow someone to react to a comment like Facebook.
* Ability to search for a post by author, keywords and tags.
* When writing a blog post, a user should be able to add basic formatting to the post.

## Prerequisites

* Ruby (check `.ruby-version` for the version required)

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

once setup is complete, run

```
bin/rails server
```

alternatively you can run using Foreman, Overmind or similar.

## Submitting The Challenge

1. Please create a PR for each feature, then
1. merge your PR and continue working on the next feature.

## What We Care About

**We value quality over feature-completeness**. Due to the time constraints. The goal of this code sample is to help us identify what you consider production-ready code and how you approach and solve problems. Your application will be reviewed by at least two of our developers. We'll go through the code with you afterwards, and you can tell us about how you tackled it, why you chose the approach you did, etc.

Here is what you should aim for with your code:

* **Architecture** How clean is the separation between front-end and back-end. Good object modelling. Is your code easily extensible?

* **Code Quality** Is your code simple, easy to understand and maintain? Are there any code smells or red flags? Does the code follow object-oriented principles such as single responsibility principle? Is the code style consistent throughout the code. Is your code production ready?

* **Security** Are there any obvious vulnerabilities?

* **Testing** How thorough are the automated tests? Will they be difficult to change if the requirements of the application were to change? Are there some unit and some integration tests? What kinds of tests did you focus on?