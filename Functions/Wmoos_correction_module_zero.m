function [emgDataTarget,probability] = Wmoos_correction_module_zero(scores,emgDataTarget,lapse_recog)
clc
fprintf(' ***** Paper X  Module Zero Correction ****  \n');
tic
aux_scores              =   abs(scores);
aux_scores_max          =   max(aux_scores);
aux_scores              =   aux_scores/aux_scores_max;


% ============== KNN NORMALIZATION ================
%prob_scores             =   aux_scores;
% ============== SVM NORMALIZATION ================
prob_scores             =   1-aux_scores;
% =================================================

[probability,gest_pos]  =   max(prob_scores);


if probability>=0.90
    
    switch gest_pos
        case 1
            emgDataTarget = 1;
        case 2
            emgDataTarget = 2;
        case 3
            emgDataTarget = 3;
        case 4
            emgDataTarget = 4;
        case 5
            emgDataTarget = 5;
        case 6
            emgDataTarget = 6;
    end
else
    emgDataTarget = 6;
end

lapse_modeule_zero=toc;
fprintf('Gesture Module Zero = %d \n',emgDataTarget);
fprintf('Time Prediction Natural without fixing  = %f \n',lapse_recog);
fprintf('Time Prediction Module Zero             = %f \n',lapse_modeule_zero);
fprintf('  \n');

end

