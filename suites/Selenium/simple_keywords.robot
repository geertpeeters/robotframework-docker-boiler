*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Search for
    [Arguments]    ${browser_type}    ${search_string}
    Open browser    http://google.com/   ${browser_type}
    Press Keys      name:q    ${search_string}+ENTER
