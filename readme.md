# Cutlery

A command line tool for creating and attaching Jira tickets to
GitHub pull requests.

## Local Setup

```
$ cp .env.example .env
```

^^ And fill out those values.

## Run Tests

```
$ bundle exec rspec
```

## Run the App

```
$ ruby app.rb
```

You'll be greeted with a prompt to enter a pull request url:

```
enter a pull request url:
  <- https://github.com/owner/repo/pull/1
Issue created successfully:
  -> https://example.atlassian.net/browse/ABCD-1
```