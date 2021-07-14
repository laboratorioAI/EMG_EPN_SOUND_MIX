function [] = Wmoos_init_parameters_(WMip,WMport,vol_main,setVol,setVol_1,setVol_2,vol_1,vol_2)

% app.ip_
% app.port_
% pb.variables.setVol
% pb.variables.setVol_1
% pb.variables.setVol_2
% pb.variables.vol_1
% pb.variables.vol_2

conditionBuffer       = false;
conditionBuffer_one   = false;
conditionBuffer_two   = false;

responseBuffer      = 'noGesture';  % First   buffer gesture located the buffer is "noGesture"
responseBuffer_one  = 'noGesture';  % Second  buffer gesture located the buffer is "noGesture"
responseBuffer_two  = 'noGesture';  % Third   buffer gesture located the buffer is "noGesture"

assignin('base','conditionBuffer',     conditionBuffer);
assignin('base','conditionBuffer_one', conditionBuffer_one);
assignin('base','conditionBuffer_two', conditionBuffer_two);

assignin('base','responseBuffer',     responseBuffer);
assignin('base','responseBuffer_one', responseBuffer_one);
assignin('base','responseBuffer_two', responseBuffer_two);
assignin('base','counter_target', 0);


assignin('base','emgCounterCompact', 1);
TargetPredictionHorzcat{1,1}='';
assignin('base','TargetPredictionHorzcat', TargetPredictionHorzcat);
assignin('base','Wmoos_counter', 1);


for i=1:4
buffer_compact{1,i}='noGesture';
end
assignin('base','buffer_compact', buffer_compact);


%% Reaper parameters
% vol_main  =  0;
% vol_1     =  0;
% vol_2     =  0;
% vol_3     =  0;
% vol_4     =  0;
% vol_5     =  0;

if setVol==1
    
    vol_main  =  evalin('base', 'vol_main');
    vol_1     =  evalin('base', 'vol_1');
    vol_2     =  evalin('base', 'vol_2');
%     vol_3     =  evalin('base', 'vol_3');
%     vol_4     =  evalin('base', 'vol_4');
%     vol_5     =  evalin('base', 'vol_5');
    
    assignin('base','vol_main', vol_main);    
    assignin('base','vol_1', vol_1);
    assignin('base','vol_2', vol_2);
else
%    vol_main=0.7;
    assignin('base','vol_main', vol_main);    
%    vol_1=0.6;
    assignin('base','vol_1', vol_1);
%    vol_2=0.0;
    assignin('base','vol_2', vol_2);
% %    vol_3=0.0;
%     assignin('base','vol_3', vol_3);
% %    vol_4=0.0;
%     assignin('base','vol_4', vol_4);
%     vol_5=0.0;
%     assignin('base','vol_5', vol_5);
    
    assignin('base','setVol', setVol);
    assignin('base','setVol_1', setVol_1);
    assignin('base','setVol_2', setVol_2);
    
   
end

u = udp(WMip,WMport);
fopen(u);
oscsend(u,'/1/volume0','f',vol_main);
oscsend(u,'/1/volume1','f',vol_1);
oscsend(u,'/1/volume2','f',vol_2);
oscsend(u,'/1/volume3','f',0);
oscsend(u,'/1/volume4','f',0);
oscsend(u,'/1/volume5','f',0);
oscsend(u,'/1/volume6','f',0);
fclose(u);

end

