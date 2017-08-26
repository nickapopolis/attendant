# Attendant:
- take picture of vehincle in a parking lot -> automatically saves picture with license plate, location, time
- take picture of same vehicle, tells how long vehicle spent at that location.
- asks if want to issue ticket, if active tickets are present
- uses OpenALPR to process pictures

## Setup
1. Make sure to have all operating system dependencies installed
```bash
brew install nvm
brew install rbenv
brew install postgresql
brew cask install docker
```
2. Clone the repo from GitHub and navigate to the project directory
```bash
git clone git@github.com:kirka121/attendant.git
cd attendant
```
3. Set your node and ruby versions
```bash
nvm install
nvm use
rbenv install
rbenv local
``` 
4. Bundle and NPM install dependencies
```bash
bundle && yarn
```
5. Start your services inside of Docker
```bash
docker-compose up -d
```
6. Export environment variables to configure your environment
```bash
export AWS_ATTENDANT_BUCKET=test
export AWS_ATTENDANT_ENDPOINT=http://localhost:5000
export AWS_SECRET_ACCESS_KEY=test
export AWS_ACCESS_KEY_ID=test
```
7. Start your webpack and rails server and then navigate to localhost:5000 to view the app
```bash
foreman start -f Procfile.dev
open localhost:5000
```

## Stack:
server - ruby on rails 5 - ActionCable, ActiveJob
  - landing, registration, login
  - api

client - react - webpack, yarn, EC6
  - everything after login

mobile - react native
  - login
  - light version of app

## Resources:
invitation only
- trello: https://trello.com/b/hcuqOvEP/attendant-backlog
- slack: https://kkattendant.slack.com
