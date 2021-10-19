*** Test Cases ***
Say Hello Critical
	[Tags]            crit
    Log To Console    Hello Critical Donkey
    No Operation
    Comment           Hello ${bob}

Say Hello Non-Critical
	[Tags]            non-crit
    Log To Console    Hello Nice Donkey
    No Operation
    Comment           Hello ${bob}