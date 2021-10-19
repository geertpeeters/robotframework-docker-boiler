*** Settings ***
Library       REST    https://jsonplaceholder.typicode.com  ssl_verify=false
Library    OperatingSystem

Documentation   Test data can be read from variables and files.
...             Both JSON and Python type systems are supported for inputs.
...             Every request creates a so-called instance. Can be `Output`.
...             Most keywords are effective only for the last instance.
...             Initial schemas are autogenerated for request and response.
...             You can make them more detailed by using assertion keywords.
...             The assertion keywords correspond to the JSON types.
...             They take in either path to the property or a JSONPath query.
...             Using (enum) values in tests optional. Only type is required.
...             All the JSON Schema validation keywords are also supported.
...             Thus, there is no need to write any own validation logic.
...             Not a long path from schemas to full Swagger/OpenAPI specs.
...             The persistence of the created instances is the test suite.
...             Use keyword `Rest instances` to output the created instances.


*** Variables ***
${json}         { "id": 11, "name": "Gil Alexander" }
&{dict}         name=Julie Langford


*** Test Cases ***
GET an existing user, notice how the schema gets more accurate
    GET         /users/1                  # this creates a new instance
    Output schema   response body
    Output      $.name
    Output      $.address
    Output      $.address.geo.lat
    Object      response body           # values are fully optional
    Integer     response body id        1
    String      response body name      Leanne Graham
    String      $.address.geo.lat       -37.3159
    [Teardown]  Output schema           # note the updated response schema

GET existing users, use JSONPath for very short but powerful queries
    GET         /users?_limit=7           # further assertions are to this
    Array       response body
    Integer     $[0].id                   1           # first id is 1
    String      $[0]..lat                 -37.3159    # any matching child
    Integer     $..id                     maximum=5   # multiple matches
    [Teardown]  Output  $[*].email        # outputs all emails as an array

POST with valid params to create a new user, can be output to a file
    POST        /users                    ${json}
    Integer     response status           201
    [Teardown]  Output  response body     ${OUTPUTDIR}/new_user.demo.json

PUT with valid params to update the existing user, values matter here
    PUT         /users/2                  { "isCoding": true }
    Boolean     response body isCoding    true
    PUT         /users/2                  { "sleep": null }
    Null        response body sleep
    PUT         /users/2                  { "pockets": "", "money": 0.02 }
    String      response body pockets     ${EMPTY}
    Number      response body money       0.02
    Missing     response body moving      # fails if property moving exists

PATCH with valid params, reusing response properties as a new payload
    &{res}=     GET   /users/3
    String      $.name                    Clementine Bauch
    PATCH       /users/4                  { "name": "${res.body['name']}" }
    String      $.name                    Clementine Bauch
    PATCH       /users/5                  ${dict}
    String      $.name                    ${dict.name}

DELETE the existing successfully, save the history of all requests
    DELETE      /users/6                  # status can be any of the below
    Integer     response status           200    202     204
    Rest instances  ${OUTPUTDIR}/all.demo.json  # all the instances so far