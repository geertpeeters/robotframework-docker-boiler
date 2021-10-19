*** Settings ***
Resource    simple_keywords.robot

*** Test Cases ***
Run A Google Search
    Search for      firefox    emoji wars
    Sleep           10s
    Close All Browsers


