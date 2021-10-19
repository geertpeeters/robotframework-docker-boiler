# robotframework-docker-boiler
Firing tests against a robotframework in docker

* Execute docker build -f ./Dockerfile -t robot .
* Run docker-compose up
* View resuts in reports/report.html

Robot container is built with following libraries

* robotframework-sshlibrary
* robotframework-requests
* robotframework-selenium2library
* robotframework-browser
* RESTinstance

Test suite contains

* Selenium example
* Browser (playright) example
* REST examples
