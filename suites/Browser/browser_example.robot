*** Settings ***
Library   Browser

*** Test Cases ***
Example Test
    New Page    https://www.google.com
    Click       button[id='L2AGLb'] > div
    Fill TexT   input[name='q']   belgium
    Click       'div > .A8SBwf
    Take Screenshot