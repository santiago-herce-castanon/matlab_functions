function [] = CheckKeyboardCodes

pause(1),WaitPressButton = 0;
%Wait for Subject to press a Button to initiate the task...
x = [];
while WaitPressButton==0;
    [kdown secs keyCode] = KbCheck;  % check for key press
    if kdown == 1
        KeyPressed = find(keyCode)
        x = [x; KeyPressed];
        KbName(keyCode)
        if KeyPressed == 41
            WaitPressButton = 1;
        end
        pause(.3)
    end
    
    
end

x