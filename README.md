# Prosalud
 
## Development set up.

1. Clone the project.
2. Install Docker
3. Run `docker-compose up -d`.
4. Run `docker-compose run --rm web bash`.
5. In the running container run `rails db:create`.
6. In the same container run `rails db:migrate`.
7. Exit the container with `exit`.
8. Visit localhost:3000 and you should now see the index page.

