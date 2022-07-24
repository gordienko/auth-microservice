# AUTH Microservice

## Create development database

createdb auth_microservice_development

## Run migration

rake db:migrate

## Run migration

rake db:seed

## Run server
bundle exec puma

## Usage

### Create user

```

```

### Get user

```

```

## Rspec

1. createdb auth_microservice_test
2. RACK_ENV=test rake db:migrate
3. rspec
