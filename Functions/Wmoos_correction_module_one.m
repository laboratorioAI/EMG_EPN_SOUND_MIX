function TargetFixed = Wmoos_correction_module_one(emgDataTarget)

fprintf(' ***** Paper X  Module One Correction ****  \n');
tic
emgDataTarget=Wmoos_names_convertion(emgDataTarget);

conditionBuffer       =  evalin('base','conditionBuffer');
conditionBuffer_one   =  evalin('base','conditionBuffer_one');
conditionBuffer_two   =  evalin('base','conditionBuffer_two');


responseBuffer        =  evalin('base', 'responseBuffer');
responseBuffer_one    =  evalin('base', 'responseBuffer_one');
responseBuffer_two    =  evalin('base', 'responseBuffer_two');
counter_target        =  evalin('base', 'counter_target');

% =========================================================================
if counter_target>=2
    emgDataTarget='noGesture';
    counter_target=0;
    assignin('base','counter_target', counter_target);
end
%==========================================================================
if conditionBuffer_two == true
    
    if string(emgDataTarget)=="noGesture"
        
        assignin('base','conditionBuffer',     false);
        assignin('base','conditionBuffer_one', false);
        assignin('base','conditionBuffer_two', false);
        assignin('base','responseBuffer',     'noGesture');
        assignin('base','responseBuffer_one', 'noGesture');
        assignin('base','responseBuffer_two', 'noGesture');
        TargetFixed     = 'noGesture';
        
    elseif string(emgDataTarget)~=string(responseBuffer_one)
        TargetFixed=responseBuffer_one;
        counter_target=counter_target+1;
        assignin('base','counter_target', counter_target);
    else
        TargetFixed=emgDataTarget;
        assignin('base','responseBuffer', TargetFixed);
        assignin('base','responseBuffer_one', TargetFixed);
        
    end
%     fprintf('Buffer 2 = %s \n',responseBuffer_two);
%     fprintf('Buffer 1 = %s \n',responseBuffer_one);
%     fprintf('Buffer 0 = %s \n',responseBuffer);
%     fprintf('BINGO!!....\n');
end

%==========================================================================
if conditionBuffer_one == true && conditionBuffer_two == false
    
    if (string(emgDataTarget)~= string(responseBuffer_two))
        
        responseBuffer_two=emgDataTarget;
        assignin('base','responseBuffer_two', responseBuffer_two);
        
        if string(responseBuffer_one)==string(responseBuffer_two)
            conditionBuffer_two = true;
            assignin('base','conditionBuffer_two',conditionBuffer_two);
            TargetFixed     = emgDataTarget;
        else
            conditionBuffer_one = false;
            assignin('base','conditionBuffer_one',conditionBuffer_one);
            TargetFixed     = 'noGesture';
        end
    else
        TargetFixed     = emgDataTarget;
        conditionBuffer_two = true;
        assignin('base','conditionBuffer_two',conditionBuffer_two);
        
    end
%     fprintf('Buffer 2 = %s \n',responseBuffer_two);
%     fprintf('Buffer 1 = %s \n',responseBuffer_one);
%     fprintf('Buffer 0 = %s \n',responseBuffer);
end

%==========================================================================
if conditionBuffer == true && conditionBuffer_one == false
    % noGesture
    if (string(emgDataTarget)~= string(responseBuffer_one))
        
        responseBuffer_one=emgDataTarget;
        assignin('base','responseBuffer_one', responseBuffer_one);
        
        %conditionBuffer_one = true;
        % assignin('base','conditionBuffer_one',conditionBuffer_one);
        %Buffer 0              Buffer 1
        if string(responseBuffer)==string(responseBuffer_one)
            conditionBuffer_one = true;
            assignin('base','conditionBuffer_one',conditionBuffer_one);
            TargetFixed     = emgDataTarget;
        else
            conditionBuffer_one = false;
            assignin('base','conditionBuffer_one',conditionBuffer_one);
            
            conditionBuffer = false;
            assignin('base','conditionBuffer',conditionBuffer);
            assignin('base','responseBuffer',     'noGesture');
            TargetFixed     = 'noGesture';
        end
        
    else
        TargetFixed     = emgDataTarget;
        % conditionBuffer_one = true;
        % assignin('base','conditionBuffer_one',conditionBuffer_one);
        % fprintf('Buffer 1 is real noGesture %s \n',TargetFixed);
    end
%     fprintf('Buffer 1 = %s \n',responseBuffer_one);
%     fprintf('Buffer 0 = %s \n',responseBuffer);
end


%==========================================================================
if (string(emgDataTarget)~= string(responseBuffer)) && conditionBuffer == false
    
    responseBuffer=emgDataTarget;
    assignin('base','responseBuffer', responseBuffer);
    % habilito el siguiente buffer 1
    conditionBuffer = true;
    assignin('base','conditionBuffer',conditionBuffer);
    
    TargetFixed     = 'noGesture';%envio noGesture la primera vez
    %fprintf('Buffer zero 0 = %s \n',responseBuffer);
    
elseif (string(emgDataTarget)== string(responseBuffer)) && conditionBuffer == false
    %condicion inicial
    
%     fprintf('Buffer 2 = %s \n',responseBuffer_two);
%     fprintf('Buffer 1 = %s \n',responseBuffer_one);
%     fprintf('Buffer 0 = %s \n',responseBuffer);
    TargetFixed     = 'noGesture';
end


%=================================================
lapse_modeule_one=toc;
fprintf('Gesture Predicted = %s \n',TargetFixed);
fprintf('Time Prediction Module One  [ Buffers ] = %f \n',lapse_modeule_one);
fprintf('  \n');



end

