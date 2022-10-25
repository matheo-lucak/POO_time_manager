# Users
- [ ] a GET method
  - http://localhost:4000/api/users?email=XXX&username=YYY
  - Get all users. Can be filtered.

- [ ] a GET method
  - http://localhost:4000/api/users/:userID
  - Get a specific user

- [ ] a POST method
  - http://localhost:4000/api/users
  - Create a user

- [ ] a PUT method
  - http://localhost:4000/api/users/:userID
  - Update a user

- [ ] a DELETE method
  - http://localhost:4000/api/users/:userID
  - Delete a user

# Working Times
- [ ] a GET (ALL) method
  - http://localhost:4000/api/workingtimes/:userID?start=XXX&end=YYY
  - Get all working times from a given user. Can be filtered.

- [ ] a GET (ONE) method
  - http://localhost:4000/api/workingtimes/:userID/:id
  - Get one user working time

- [ ] a POST method
  - http://localhost:4000/api/workingtimes/:userID
  - Create one user working time

- [ ] a PUT method
  - http://localhost:4000/api/workingtimes/:id
  - 
  - Update working time

- [ ] a DELETE method
  - http://localhost:4000/api/workingtimes/:id
  - Delete working time

# Clocks
- [ ] a GET method
  - http://localhost:4000/api/clocks/:userID
  - Get all clocks of a given user

- [ ] a POST method
  - http://localhost:4000/api/clocks/:userID
  - If no clock exists for given user, create new clock with status to true
  - If clock exists.
