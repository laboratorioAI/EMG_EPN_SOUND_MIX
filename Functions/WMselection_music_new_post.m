function Wave = WMselection_music_new_post(WMip,WMport)
countMyos=1;
m = MyoMex(countMyos);
m1 = m.myoData(1);
m1.timeEMG;
m1.emg;
m1.stopStreaming();
m.myoData.clearLogs();
m1.startStreaming();
emg=zeros(40,8);

y=0;
assignin('base','y',y);
order      =  evalin('base', 'order');
high_limit =  evalin('base', 'umbral_high');
low_limit  =  evalin('base', 'umbral_low');

assignin('base','track_1',  1);
assignin('base','track_2',  0);
track_1  =  evalin('base', 'track_1');
track_2  =  evalin('base', 'track_2');


previous_=0;
pp=0;
ss=0;
ss3=0;
ss33=0;
ss4=0;
ss44=0;
next_=0;
ok_wave=0;
runMYO=1;
Wmoos_local_counter=1;
Wmoos_response=0;
qw=0;
qx=0;
qy=0;
qz=0;
imuData=0;



% ======================= Commands ======================
% waveOut   = next 
% waveIn    = previous 
% fist      = exit
% open      = pause/resume
% pinch     = control mode on / control mode off
% noGesture = no action
% =======================================================
pause(1)

while runMYO==1
    
    timeEMG = m1.timeEMG_log;
    timeIMU = m1.timeIMU_log; 
    
    if ~isempty(timeEMG)
        
        T_emg=timeEMG(:,1)>=(timeEMG(end,1) - 0.8 );
        emg=m1.emg_log(T_emg,:);
        umbral=Wsumenv(emg');
        
        T_imu=timeIMU(:,1)>=(timeIMU(end,1)-0.8);
        imu = m1.quat_log(T_imu,:);              
        matrix_quat=imu(end,:);        
        qw=matrix_quat(1,1);
        qx=matrix_quat(1,2);
        qy=matrix_quat(1,3);
        qz=matrix_quat(1,4);
        
        
        if umbral(1:4,:) > high_limit | umbral(5:8,:) > low_limit
            
            emg=m1.emg_log(T_emg,WMoos_X(order));

            tic
            [selected,scores]=Recognition_5waves(emg);
            lapse_recog=toc; 
            [selected_mod_zero,~]  = Wmoos_correction_module_zero(scores,selected,lapse_recog);             
             selected_mod_one      = Wmoos_correction_module_one(selected_mod_zero);
            [  ~ ,com,two_counter] = Wmoos_correction_module_two(selected_mod_one,4);
            
            fprintf(' ***** Paper X Module Three Correction ****  \n');
         
            emgCounterCompact   =  evalin('base', 'emgCounterCompact');            
            check_compact=emgCounterCompact-1;

            pause(0.05)
            
            if check_compact==0 && two_counter==5
                
                
                TargetPrediction_fixed_up  =  com;
                TargetPredictionHorzcat  = evalin('base', 'TargetPredictionHorzcat');
                TargetPredictionHorzcat  = horzcat(TargetPredictionHorzcat,TargetPrediction_fixed_up);
                assignin('base','TargetPredictionHorzcat', TargetPredictionHorzcat);
                
                if Wmoos_local_counter==1
  
                    TargetPredictionHorzcat  =  evalin('base', 'TargetPredictionHorzcat');
                    TargetPredictionHorzcat  =  TargetPredictionHorzcat(1,2:end);
                    
                    TargetPredictionUnion    =  emgCompactedTotal(TargetPredictionHorzcat,length (TargetPredictionHorzcat));
                    Wmoos_response           =  Wmoos_summary_class(TargetPredictionUnion);
                    
                    clear TargetPredictionHorzcat TargetPredictionUnion
                    TargetPredictionHorzcat{1,1}='';
                    assignin('base','TargetPredictionHorzcat', TargetPredictionHorzcat);
                    Wmoos_local_counter=0;
                    
                end
                Wmoos_local_counter=Wmoos_local_counter+1;
                
            else
                
                 Wmoos_response  = 'noGesture';
                
            end

        else
            [selected_mod_zero,~]  = Wmoos_correction_module_zero(0,6,0);
                                     Wmoos_correction_module_one(selected_mod_zero);
                                     Wmoos_correction_module_two('noGesture',4);
                 fprintf(' ***** Paper X  Module Three Correction ****  \n');
                 Wmoos_response  = 'noGesture';
            
        end
        
    end

 Wmoos_response

     Wave=Wmoos_names_convertion_back(Wmoos_response);
     
     %============================= IMU 1 =====================================
     
     quat_roll  = atan2(2*(qw*qx + qy*qz),1- 2* (qx*qx + qy*qy));
     quat_pitch = asin(max(-1, min(1,2 * (qw * qy - qz * qx))));
     quat_yaw   = atan2(2*(qw * qz + qx * qy),1 - 2 * (qy * qy + qz * qz));
     
     rpy=[quat_roll,quat_pitch,quat_yaw];    
     %=========================================================================
     
   
     if ok_wave==0
         
         %waveOut
         if Wave==1
             %Play/pause
             remoteReaper(WMip,WMport,Wave,0,0);
         end
         %waveIn
         if Wave==2
             %Stop
             remoteReaper(WMip,WMport,Wave,0,0);
         end
         
         %fist
         if Wave==3
             %mix
             pause(1)
             track_1  =  evalin('base', 'track_1');
             track_2  =  evalin('base', 'track_2');
             remoteReaper(WMip,WMport,Wave,track_1,track_2);
         end
         
%          %open
%          if Wave==4
%              %cycle/ exit program
%              remoteReaper(WMip,WMport,Wave,4,0);
%          end
%          
%          %pinch
%          if Wave==5
%              %Volume
%              
%              if quat_pitch>=0 && quat_pitch<=1
%                  
%                  remoteReaper(WMip,WMport,3,quat_pitch,0);
%              end
%              
%          end
%          
%          
%          if Wave==4 && ss==0
%              runMYO=0;
%              pause(2);
%          end
%          
%   
         
         
     end
     
%      
%      if Wave==5
%          if ss==0
%              ok_wave=1;
%          end
%          pause(1)
%          if ss==1
%              ok_wave=0;
%          end
%          pause(1)
%          ss=ss+1;
%          if ss>=2
%              ss=0;
%          end
%      end
%     
%     if ss==0
%         disp('OSC REAPER Control: ON')
%     else
%         disp('OSC REAPER Control: OFF')
%         disp('Mode: Control Volume')
%         
%             if Wave==3
%                 if ss3==0
%                     disp('Control Volume enabled')
%                     ss33=1;
%                     pause(3);
%                 end
% 
%                 if ss3==1
%                     disp('Control Volume disabled')
%                     ss33=0;
%                     pause(3);
%                 end
% 
%                 ss3=ss3+1;
%                 if ss3>=2
%                     ss3=0;
%                 end
%             end
%             
%             
%             if Wave==4
%                 if ss4==0
%                     disp('Control Mix enabled')
%                     ss44=1;
%                     pause(4);
%                 end
%                 
%                 if ss4==1
%                     disp('Control Mix disabled')
%                     ss44=0;
%                     pause(4);
%                 end
%                 
%                 ss4=ss4+1;
%                 if ss4>=2
%                     ss4=0;
%                 end
%             end
%             
%  
%     end  
%     
%   
%     if ss33==1
%         disp('REAPER Volume: ON')
%         if quat_pitch>=0 && quat_pitch<=1
%             remoteReaper(WMip,WMport,3,quat_pitch,0);           
%         end   
%     end
%     
%     
%     if ss44==1
%         disp('REAPER MIX: ON')
%             remoteReaper(WMip,WMport,44,quat_pitch,quat_yaw);
%     end
%     
  
end

m1.stopStreaming();    %Stop streaming Myo_1 all data
m.myoData.clearLogs();
m.delete;              %Delete variable for Myo_1
clear m                %Clear variable for Myo_1

end