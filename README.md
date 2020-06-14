# README

The whenever command will simply show you your schedule.rb file converted to cron syntax. It does not read or write your crontab file.

```
  bundle exec whenever 
```

To write your crontab file for your jobs, execute this command:

```
  whenever --update-crontab
```

## Background job

To works with background job, in a new console run `sidekiq` and now you can run commands in the console

```
  AutomateActivities.perform_async() -> To create Autotasks
```