# Simple Calendar Events

Easily access your Google Calendar events for today, classified by calendar names.

Deployed here: https://calendars-vc.herokuapp.com/

## Features
- When a user connects the Google account, all the calendars and events are imported to the App.
- The subsequent events which get created/updated/deleted are sync'd to the app automatically

## Implementation Details
- Ruby on Rails app with PostreSQL as database
- Implements a basic authentication system using Google OAuth. (without passwords)
- Uses OAuth2 flow for authorization to user's resources (calendars/events)
- Implements a service to talk with Google Calendars API which handles:
  - fetching calendars for a user
  - fetching events for a calendar of user
  - registering webhooks for listening to changes to events/calendars
- Does not use background processing jobs for any tasks yet
  - potential to use for some use-cases
- Uses Rspec for testing
  - Test coverage still low

## Possible improvements/pending tasks
- Please take a look at **Issues** section of this repository.
- Will be working on these as I get time.

## Run locally
- Ruby '2.7.0'
- Ruby on Rails 6.0.2
- Install & setup PostgreSQL locally
- Setup Google Calendar API & OAuth consent screen and get client_id & client_secret.
- Save your keys in environment variables (ENV[:google_client_id] and ENV[:google_client_secret])
- `bundle install`
- `rails db:schema:load`
- `rails s`
