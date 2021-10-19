*** Settings ***
Library       REST    https://jsonplaceholder.typicode.com  ssl_verify=false

*** Variables ***
${json}=      {"foo": "bar" }   # JSON object, represented as Python str
&{dict}=      foo=bar           # Python dict, corresponds to JSON object
${array}=     ["foo", "bar"]    # JSON array, represented as Python str
@{list}=      foo   bar         # Python list, corresponds to JSON array
${new_props}=   { "pockets": "", "money": 0.02 }


*** Test cases ***
This is soon to be the name of our test
  No operation

Get all users
  GET         /users
  Output

Get one user and output what we call an instance
  GET         /users/1
  Output

Get one user, output the response
  GET         /users/1
  Output      response

Get one user, write response body to file user_1.json
  GET         /users/1
  Output      response body   file_path=${CURDIR}/user_1.json

Get one user, output the address of the first user
  GET         /users/1
  Output      response body address

Demonstrate different uses of Output keyword
  Output      "Use double quotes to distinct JSON string from a property"
  Output      { "key": "value" }
  Output      ${json}
  Output      ${dict}
  Output      ${array}
  Output      ${list}

GET all the existing users
  GET           /users

GET the existing user
  GET           /users/1

POST to create a new user
  POST          /users      ${CURDIR}/user_1.json

PUT to update the existing user - might allow creating one too
  PUT           /users/1    ${new_props}

PATCH to update a single property of the existing user
  PATCH         /users/1    { "name": "Gil Alexander" }

DELETE an existing user
  DELETE        /users/1

# The next two methods are implemented by web servers mostly to give
# info to clients. They should not do anything related to the data.

HEAD is identical to GET, but has nothing in response body
  HEAD          /users/1

OPTIONS is used to gain info on the allowed communication options
  OPTIONS       /users/1

GET all the existing users, timeout if takes more than a second
  GET           /users      timeout=1.0

GET the existing user, prevent any redirects
  GET           /users/1    allow_redirects=false

HEAD to get headers, allow redirects that normally would not happen
  HEAD          /users/1    allow_redirects=true

