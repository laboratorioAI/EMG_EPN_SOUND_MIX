function [Y,Scores] = Recognition_5waves(X)
    
     Data_test1=X';
     Ms1=Data_test1(1,:);
     Ms2=Data_test1(2,:);
     Ms3=Data_test1(3,:);
     Ms4=Data_test1(4,:);
     Ms5=Data_test1(5,:);
     Ms6=Data_test1(6,:);
     Ms7=Data_test1(7,:);
     Ms8=Data_test1(8,:);
     
    TableEmgData = table(Ms1,Ms2,Ms3,Ms4,Ms5,Ms6,Ms7,Ms8);
    %% Additional Feature Extraction
    WM_F1   =   varfun(@WMoos_F1,     TableEmgData);
    WM_F2   =   varfun(@WMoos_F2,     TableEmgData);
    WM_F3   =   varfun(@WMoos_F3,     TableEmgData);
    WM_F4   =   varfun(@WMoos_F4,     TableEmgData);
    WM_F5   =   varfun(@WMoos_F5,     TableEmgData);
    %%
    MYOActivityData = [WM_F1,  WM_F2,  WM_F3,  WM_F4,  WM_F5];
    %%
    MYOModel = evalin('base', 'SVM20Waves'); 
    %% Prediction 
    [Predicted, Scores]=MYOModel.predictFcn(MYOActivityData);
    %pause(0.001) %0.1
    Yp=char(Predicted);
    
    switch Yp
        case "waveOut"
            Y=1; 
        case "waveIn"
            Y=2; 
        case "fist"
            Y=3;  
        case "open"
            Y=4;
        case "pinch"
            Y=5;
        case "noGesture"
            Y=6; 
    end
    
 
end



% function [Y,Scores] = Recognition_5waves(X)
%     
%      Data_test1=X';
%      Ms1=Data_test1(1,:);
%      Ms2=Data_test1(2,:);
%      Ms3=Data_test1(3,:);
%      Ms4=Data_test1(4,:);
%      Ms5=Data_test1(5,:);
%      Ms6=Data_test1(6,:);
%      Ms7=Data_test1(7,:);
%      Ms8=Data_test1(8,:);
%      
%     TableMyoDataTest = table(Ms1,Ms2,Ms3,Ms4,Ms5,Ms6,Ms7,Ms8);
%     %% Additional Feature Extraction
%     Sensor_mean     =   varfun(@Wmean, TableMyoDataTest);
%     Sensor_stdv     =   varfun(@Wstd,  TableMyoDataTest);
%     Sensor_env      =   varfun(@Wsumenv, TableMyoDataTest);
%     
%     Sensor_welch    =   varfun(@Wpwelch, TableMyoDataTest);
%     Sensor_absmean  =   varfun(@Wabsmean, TableMyoDataTest);
%     Sensor_energy   =   varfun(@Wenergy, TableMyoDataTest);
%     %%
%     MYOActivityData = [Sensor_mean, Sensor_stdv, Sensor_env, Sensor_welch, Sensor_absmean, Sensor_energy];
%     %%
%      MYOModel = evalin('base', 'SVM20Waves'); 
%     %% Prediction Model 1 TREE
%     [Predicted, Scores]=MYOModel.predictFcn(MYOActivityData);
%     pause(0.05)
%     Yp=char(Predicted);
%     
%     if Yp=="out"
%         Y=1;
%         
%     end
%     
%     if Yp=="in"
%         Y=2;
%         
%     end
%     
%     if Yp=="close"
%         Y=3;
%         
%         
%     end
%     
%     if Yp=="spread"
%         Y=4;
%         
%     end
%     
%     if Yp=="thumb"
%         Y=5;
%         
%     end
%     
%     if Yp=="relax"
%         Y=6;
%     end
%     
%     if Yp=="index"
%         Y=0;
%         
%     end
%     
%     if Yp=="middle"
%         Y=0;
%         
%     end
%     
%     if Yp=="rock"
%         Y=0;
%         
%     end
%     
%     if Yp=="little"
%         Y=0;
%     end
%     
%     
%  
% end