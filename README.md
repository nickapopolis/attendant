# Attendant:
- take picture of vehincle in a parking lot -> automatically saves picture with license plate, location, time
- take picture of same vehicle, tells how long vehicle spent at that location.
- asks if want to issue ticket, if active tickets are present
- uses OpenALPR to process pictures

# stack:
server - ruby on rails 5 - ActionCable, ActiveJob
  - landing, registration, login
  - api

client - react - webpack, yarn, EC6
  - everything after login

mobile - react native
  - login
  - light version of app

# resources:
invitation only
- trello: https://trello.com/b/hcuqOvEP/attendant-backlog
- slack: https://kkattendant.slack.com
