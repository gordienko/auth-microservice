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

### Sign up

```
curl --request POST \
  --url 'http://localhost:3001/sign_up/v1?name=Alexey&email=alx%40anadyr.org&password=Pa%24%24W0Rd'
```

### Sign in

```
curl --request POST \
  --url 'http://localhost:3001/sign_in/v1?email=alx%40example.com&password=Pa%24%24W0Rd' 
```

### Auth

```
curl --request POST \
  --url 'http://localhost:3001/auth/v1?token=eyJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiMDU4N2QxMzAtOTg2ZC00YzIzLTkxMzYtMGI2MGI0ZTdiN2MwIn0.Z2hwnaaWPNpcn9Jg2a7GttgtO4wJFrwdbXbEW9H14HY' 
```

## Rspec

1. createdb auth_microservice_test
2. RACK_ENV=test rake db:migrate
3. rspec
