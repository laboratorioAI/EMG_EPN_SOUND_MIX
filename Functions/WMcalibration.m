function [Order,umbral_high,umbral_low] = WMcalibration(EV,device)
WMbase;

flag = device;

if flag ==1
    countMyos=1;
    m = MyoMex(countMyos);
    m1 = m.myoData(1);
    m1.timeEMG;
    m1.emg;
    m1.stopStreaming();
    m.myoData.clearLogs();
    m1.startStreaming();
else
    bits=8;
    res=gForce_mex('setEmgResolution', bits);
    res=gForce_mex('setEmgSamplingRate', 200);
    
end
beep
pause(0.5)
%% VARIABLES -----------------------------------------
ventana=0.8;
if flag ==1
    rep_cal=20;
else
    rep_cal=1;
    ventana=4;
end
order=1;
sensor=1;
ref_sensor=1;
calibration_umbral=zeros(8,rep_cal);
calibration_reference=zeros(1,rep_cal);

for i=1:rep_cal
    %% EMG_1 get stream data
    if flag ==1
        timeEMG = m1.timeEMG_log;
        
        if ~isempty(timeEMG)
            T_emg=timeEMG(:,1)>=(timeEMG(end,1)-ventana);
            emg = m1.emg_log(T_emg,:);
            umbral=WMoos_F2(emg');%Wsumenv(emg');
            calibration_umbral(:,i)=umbral;
            medias=mean(emg);
            [~,sensor]= max(medias);
            calibration_reference(i)=sensor;
            
        end
        pause(ventana);
        
    else
        clc
        gForce_mex('clearEmg');
        pause(ventana)
        emg = gForce_mex('getEmg');
        emg=double(emg);
        mean_=mean(emg,2);
        norm_=((2^bits)-1)*ones(8,1)- mean_;
        emg=emg-mean_;
        emg=emg./norm_;
        
        figure(1)
        subplot(4,2,1)
        plot(emg(1,:)')
        ylim([-1 1])
        xlim([1 200*ventana])
        title('emg1')
        
        subplot(4,2,2)
        plot(emg(2,:)')
        ylim([-1 1])
        xlim([1 200*ventana])
        title('emg2')
        
        subplot(4,2,3)
        plot(emg(3,:)')
        ylim([-1 1])
        xlim([1 200*ventana])
        title('emg3')
        
        subplot(4,2,4)
        plot(emg(4,:)')
        ylim([-1 1])
        xlim([1 200*ventana])
        title('emg4')
        
        subplot(4,2,5)
        plot(emg(5,:)')
        ylim([-1 1])
        xlim([1 200*ventana])
        title('emg5')
        
        subplot(4,2,6)
        plot(emg(6,:)')
        ylim([-1 1])
        xlim([1 200*ventana])
        title('emg6')
        
        subplot(4,2,7)
        plot(emg(7,:)')
        ylim([-1 1])
        xlim([1 200*ventana])
        title('emg7')
        
        subplot(4,2,8)
        plot(emg(8,:)')
        ylim([-1 1])
        xlim([1 200*ventana])
        title('emg8')
        
        
        umbral=WMoos_F5(emg);
        calibration_umbral(:,i)=umbral;
        medias=calibration_umbral;%mean(emg,2);
        [~,sensor]= max(medias);
        calibration_reference(i)=sensor;
        
    end
    
end

if flag ==1
[times,sensor]=max(histc(calibration_reference,1:length(calibration_reference)));
clc
    if times>(length(calibration_reference)/4)
        disp('Sistema sincronizado')
        ref_sensor=sensor;
        
    else
        disp('Repita la sincronizacion')
        ref_sensor=32;
    end
else
%     if times>=(length(calibration_reference)/2)
        disp('Sistema sincronizado')
        ref_sensor=calibration_reference;
        
%     else
%         disp('Repita la sincronizacion')
%         ref_sensor=32;
%     end
    
end

pause(2)
%close all


%% EMG_1 Set sensor reference
switch ref_sensor
    case 1;order=1;
    case 2;order=2;
    case 3;order=3;
    case 4;order=4;
    case 5;order=5;
    case 6;order=6;
    case 7;order=7;
    case 8;order=8;
    otherwise
        order=1;
end

%% Calibartion umbral

calibration_umbral=calibration_umbral';
switch ref_sensor
    
    case 1
        calibration_umbral=calibration_umbral(:,[1,2,3,4,5,6,7,8]);
    case 2
        calibration_umbral=calibration_umbral(:,[2,3,4,5,6,7,8,1]);
    case 3
        calibration_umbral=calibration_umbral(:,[3,4,5,6,7,8,1,2]);
    case 4
        calibration_umbral=calibration_umbral(:,[4,5,6,7,8,1,2,3]);
    case 5
        calibration_umbral=calibration_umbral(:,[5,6,7,8,1,2,3,4]);
    case 6
        calibration_umbral=calibration_umbral(:,[6,7,8,1,2,3,4,5]);
    case 7
        calibration_umbral=calibration_umbral(:,[7,8,1,2,3,4,5,6]);
    case 8
        calibration_umbral=calibration_umbral(:,[8,1,2,3,4,5,6,7]);
        
    otherwise
end

mean_umbral=calibration_umbral;
if flag ==1
    mean_umbral=mean_umbral(end-(rep_cal-5):end,:);
    mean_umbral=mean(mean_umbral);
    [val,pos]=max(mean_umbral);
else
    %mean_umbral=mean(mean_umbral);
    [val,pos]=max(mean_umbral);
end
val_umbral_high = EV*sum(mean_umbral(1:4))/4;
val_umbral_low  = EV*sum(mean_umbral(5:8))/4;


Order = order;
umbral_high=val_umbral_high;
umbral_low=val_umbral_low;

assignin('base','order',  order);
assignin('base','umbral_low',  umbral_low);
assignin('base','umbral_high', umbral_high);

if flag ==1
    %% Close MYO
    m1.stopStreaming();
    m.myoData.clearLogs();
    m.delete;
else
    clear gForce_mex
end
clc
% figure(2)
% histogram(calibration_reference)
end

