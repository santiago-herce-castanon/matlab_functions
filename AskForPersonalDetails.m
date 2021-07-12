function[PersonalDetails] = AskForPersonalDetails(w,ScreenSize,CentreOfScreen)


WaitPressEnter = 0;
SubjectName = '';
Screen(w,'FillRect',255);
Screen('TextSize', w , floor(ScreenSize(2)*.05) );% Set the font size
Screen('TextFont', w, 'Calibri');% Set the font of text
DrawFormattedText(w,'Type down your NAME', 'Center',CentreOfScreen(2)*.8);%
DrawFormattedText(w,'And press ENTER when finished', 'Center',CentreOfScreen(2)*1.2);%
Screen(w,'Flip');%Print to SCREEN
IsLetter = [4 7:14 17:24 26:29];
%Wait for Subject to press a Button to initiate the task...
while WaitPressEnter==0;
    [kdown secs keyCode]=KbCheck;  % check for key press
    if kdown==1;
        if keyCode(40)==1 || keyCode(40)==1;  % if escape key
            WaitPressEnter = 1;
        elseif keyCode(42)==1
            if numel(SubjectName) > 0
                SubjectName = SubjectName(1:end-1);
            end
            Screen(w,'FillRect',255);
            Screen('TextSize', w , floor(ScreenSize(2)*.05) );% Set the font size
            Screen('TextFont', w, 'Calibri');% Set the font of text
            DrawFormattedText(w,'Type down your NAME', 'Center',CentreOfScreen(2)*.8);%
            DrawFormattedText(w,SubjectName, 'Center',CentreOfScreen(2),[0 0 255]);%
            DrawFormattedText(w,'And press ENTER when finished', 'Center',CentreOfScreen(2)*1.2, [0 0 0]);%
            Screen(w,'Flip');%Print to SCREEN
            pause(.2)
            
        elseif sum(keyCode(IsLetter)) > 0
            NameKeyPressed = KbName(keyCode);
            SubjectName = [SubjectName NameKeyPressed(1)];
            Screen(w,'FillRect',255);
            Screen('TextSize', w , floor(ScreenSize(2)*.05) );% Set the font size
            Screen('TextFont', w, 'Calibri');% Set the font of text
            DrawFormattedText(w,'Type down your name', 'Center',CentreOfScreen(2)*.8);%
            DrawFormattedText(w,SubjectName, 'Center',CentreOfScreen(2), [0 0 255]);%
            DrawFormattedText(w,'And press ENTER when finished', 'Center',CentreOfScreen(2)*1.2, [0 0 0]);%
            Screen(w,'Flip');%Print to SCREEN
            pause(.2)
        end
    end
end

WaitPressEnter = 0;
SubjectAge = '';
Screen(w,'FillRect',255);
Screen('TextSize', w , floor(ScreenSize(2)*.05) );% Set the font size
Screen('TextFont', w, 'Calibri');% Set the font of text
DrawFormattedText(w,'Type down your AGE', 'Center',CentreOfScreen(2)*.8);%
DrawFormattedText(w,'And press ENTER when finished', 'Center',CentreOfScreen(2)*1.2);%
Screen(w,'Flip');%Print to SCREEN
%Wait for Subject to press a Button to initiate the task...
while WaitPressEnter==0;
    [kdown secs keyCode]=KbCheck;  % check for key press
    if kdown==1;
        if keyCode(40)==1 || keyCode(40)==1;  % if escape key
            WaitPressEnter = 1;
        elseif keyCode(42)==1
            SubjectAge = SubjectAge(1:end-1);
            Screen(w,'FillRect',255);
            Screen('TextSize', w , floor(ScreenSize(2)*.05) );% Set the font size
            Screen('TextFont', w, 'Calibri');% Set the font of text
            DrawFormattedText(w,'Type down your AGE', 'Center',CentreOfScreen(2)*.8);%
            DrawFormattedText(w,SubjectAge, 'Center',CentreOfScreen(2));%
            DrawFormattedText(w,'And press ENTER when finished', 'Center',CentreOfScreen(2)*1.2);%
            Screen(w,'Flip');%Print to SCREEN
            pause(.2)
            
        else
            NameOfKey = KbName(keyCode);
            SubjectAge = [SubjectAge NameOfKey(1)];
            Screen(w,'FillRect',255);
            Screen('TextSize', w , floor(ScreenSize(2)*.05) );% Set the font size
            Screen('TextFont', w, 'Calibri');% Set the font of text
            DrawFormattedText(w,'Type down your AGE', 'Center',CentreOfScreen(2)*.8);%
            DrawFormattedText(w,SubjectAge, 'Center',CentreOfScreen(2));%
            DrawFormattedText(w,'And press ENTER when finished', 'Center',CentreOfScreen(2)*1.2);%
            Screen(w,'Flip');%Print to SCREEN
            pause(.2)
        end
    end
end




WaitPressEnter = 0;
Gender = '';
Screen(w,'FillRect',255);
Screen('TextSize', w , floor(ScreenSize(2)*.05) );% Set the font size
Screen('TextFont', w, 'Calibri');% Set the font of text
DrawFormattedText(w,'Are you a male (press m) or a female (press f)?', 'Center',CentreOfScreen(2)*.8);%
Screen(w,'Flip');%Print to SCREEN
%Wait for Subject to press a Button to initiate the task...
while WaitPressEnter==0;
    [kdown secs keyCode]=KbCheck;  % check for key press
    if kdown==1;
        if keyCode(40)==1 || keyCode(40)==1;  % if escape key
            WaitPressEnter = 1;
        elseif keyCode(16)==1 || keyCode(9)==1
            Gender = KbName(keyCode);
            Screen(w,'FillRect',255);
            Screen('TextSize', w , floor(ScreenSize(2)*.05) );% Set the font size
            Screen('TextFont', w, 'Calibri');% Set the font of text
            DrawFormattedText(w,'Are you a male (press m) or a female (press f)?', 'Center',CentreOfScreen(2)*.8);%
            DrawFormattedText(w,Gender, 'Center',CentreOfScreen(2));%
            Screen(w,'Flip');%Print to SCREEN
            pause(.2)
            WaitPressEnter = 1;
        end
    end
end




WaitPressEnter = 0;
RightHanded = 0;
Screen(w,'FillRect',255);
Screen('TextSize', w , floor(ScreenSize(2)*.05) );% Set the font size
Screen('TextFont', w, 'Calibri');% Set the font of text
DrawFormattedText(w,'Are you right handed? yes(y) or no(n)', 'Center',CentreOfScreen(2)*.8);%
Screen(w,'Flip');%Print to SCREEN
%Wait for Subject to press a Button to initiate the task...
while WaitPressEnter==0;
    [kdown secs keyCode]=KbCheck;  % check for key press
    if kdown==1;
        if keyCode(40)==1 || keyCode(40)==1;  % if escape key
            WaitPressEnter = 1;
        elseif keyCode(28)==1
            RightHanded = 1;
            Screen(w,'FillRect',255);
            Screen('TextSize', w , floor(ScreenSize(2)*.05) );% Set the font size
            Screen('TextFont', w, 'Calibri');% Set the font of text
            DrawFormattedText(w,'Are you right handed? yes(y) or no(n)', 'Center',CentreOfScreen(2)*.8);%
            DrawFormattedText(w,'YES', 'Center',CentreOfScreen(2));%
            Screen(w,'Flip');%Print to SCREEN
            pause(.2)
            WaitPressEnter = 1;
        elseif keyCode(17)==1
            Screen(w,'FillRect',255);
            Screen('TextSize', w , floor(ScreenSize(2)*.05) );% Set the font size
            Screen('TextFont', w, 'Calibri');% Set the font of text
            DrawFormattedText(w,'Are you right handed? yes(y) or no(n)', 'Center',CentreOfScreen(2)*.8);%
            DrawFormattedText(w,'NO', 'Center',CentreOfScreen(2));%
            Screen(w,'Flip');%Print to SCREEN
            pause(.2)
            WaitPressEnter = 1;
        end
    end
end

PersonalDetails.SubjectName = SubjectName;
PersonalDetails.SubjectAge = SubjectAge;
PersonalDetails.Gender = Gender;
PersonalDetails.RightHanded = RightHanded;
