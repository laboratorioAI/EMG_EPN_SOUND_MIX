function [Wmoos_response,TargetPredictionUnion] = Wmoos_correction_module_three(Wmoos_compacted)
%fprintf(' ***** Paper X  Module Three Correction ****  \n');
% tic
Wmoos_response        = 'noGesture';
TargetPredictionUnion = 'noGesture';

emgCounterCompact   =  evalin('base', 'emgCounterCompact');
Wmoos_local_counter =  evalin('base', 'Wmoos_counter');

check_compact=emgCounterCompact-1;

if check_compact==0
    
    TargetPrediction_fixed_up  =  Wmoos_compacted;    
    TargetPredictionHorzcat  = evalin('base', 'TargetPredictionHorzcat');
    TargetPredictionHorzcat  = horzcat(TargetPredictionHorzcat,TargetPrediction_fixed_up);
    assignin('base','TargetPredictionHorzcat', TargetPredictionHorzcat);
    
    if Wmoos_local_counter==5
        tic
        TargetPredictionHorzcat  =  evalin('base', 'TargetPredictionHorzcat');
        TargetPredictionHorzcat  =  TargetPredictionHorzcat(1,2:end);
        
        TargetPredictionUnion= emgCompactedTotal(TargetPredictionHorzcat,length (TargetPredictionHorzcat));
        Wmoos_response=summaryClass(TargetPredictionUnion);
        
        clear TargetPredictionHorzcat
        TargetPredictionHorzcat{1,1}='';
        assignin('base','TargetPredictionHorzcat', TargetPredictionHorzcat);
        assignin('base','Wmoos_counter', 0);
        
        lapse_module_three=toc;
%         fprintf('Gesture Predicted  = %s \n',Wmoos_response);
%         fprintf('Time Prediction Module Three....[ TBuffer ] = %f \n',lapse_module_three);
%         fprintf('  \n');
        
    end
    assignin('base','Wmoos_counter', Wmoos_local_counter+1);   

end


end

