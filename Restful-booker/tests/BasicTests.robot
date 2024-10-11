*** Settings ***
Documentation   These tests are based on the functionality of restful-booking API
Library         RequestsLibrary

# Copy/paste the line below (without #) into the terminal tab below to execute:
# robot -d results tests/BasicTests.robot

*** Variables ***
${base_url}     https://restful-booker.herokuapp.com/
${id}           24
&{JSON_data_authenticate}    username=admin    password=password123

*** Test Cases ***
TC_GET_req
    [Documentation]     Use GET request to check all Booking id's at restful-booker

    Create Session          get_bookings     ${base_url}
    ${response}=            GET On Session  get_bookings     /booking
    log to console          STATUS CODE: ${response.status_code}
    log to console          CONTENT: ${response.content}

    # VALIDATIONS
    ${status_code}=     convert to string    ${response.status_code}
    should be equal     ${status_code}      200

TC_GET_req_with_ID
    [Documentation]     Use GET request to check a certain booking with id at restful-booker

    Create Session          get_bookings     ${base_url}
    ${response}=            GET On Session  get_bookings     /booking/${id}
    log to console          STATUS CODE: ${response.status_code}
    log to console          CONTENT: ${response.content}

    # VALIDATIONS
    ${status_code}=     convert to string    ${response.status_code}
    should be equal     ${status_code}      200

TC_POST_authenticate
    [Documentation]     Use PUT request to get authentication token from restful-booker

    Create Session      token     ${base_url}
    ${header}=          create dictionary   Content-Type=application/json
    ${response}=        POST On Session    token   /auth   json=&{JSON_data_authenticate}    headers=${header}
    log to console      STATUS CODE: ${response.status_code}

    # VALIDATION
    ${status_code}=         convert to string    ${response.status_code}
    should be equal         ${status_code}      200
    ${my_token}=            convert to string    ${response.json()['token']}
    should not be empty     ${my_token}
    log to console          TOKEN: ${my_token}
