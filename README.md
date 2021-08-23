# wait-for-docker-containers-to-start

If docker images or docker-compose files are started within a github action, by default the next command will be triggered as soon as
the container is created.
Even if there are healthchecks within the dockerfile or the docker-compose.yml file, github action runners will not wait for them.

As a result, you have to wait till all images have completed the init process and have started correctly.

This action delays the execution of all follwoing commands till all docker containers started and left the status `(health: starting)`

# Usage:

<!-- start usage -->
```yaml
- uses: herwig-/wait-for-docker-containers-to-start@v1.1
  with:
    # the delay between two checks for status updates
    # Default: 10
    time-to-wait: ''
```
<!-- end usage -->

# Example:

<!-- start example -->
```yaml
name: PR WorkFlow

on:
  pull_request:
    branches:
      - master
      - staging

jobs:
  app-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Copy .env
        run: php -r "file_exists('.env') || copy('.env.example', '.env');"
      - name: list all files
        run: ls -lah
      - name: executing docker-compose
        run: docker-compose up -d
      - uses: herwig-/wait-for-docker-containers-to-start@v1.1
        with:
          time-to-wait: 13
      - name: try mySqlAdmin ping
        run: docker-compose exec -T mysql mysqladmin ping -ppassword
      ...
```
<!-- end example -->
