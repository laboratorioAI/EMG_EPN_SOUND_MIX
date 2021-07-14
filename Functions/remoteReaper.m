function [] = remoteReaper(WMip,WMport,Wave,quat_pitch,~)
setVol_1  =  evalin('base', 'setVol_1');
setVol_2  =  evalin('base', 'setVol_2');

switch Wave
    case 1
        %play
        u = udp(WMip,WMport);
        fopen(u);
        oscsend(u,'/1/play','f', 1);
        fclose(u);
        pause(1)
    case 2
        %stop
        u = udp(WMip,WMport);
        fopen(u);
        oscsend(u,'/1/stop','f', 1);
        fclose(u);
        pause(1)
        
    case 3


        track_1  =  evalin('base', 'vol_1');                
        track_2  =  evalin('base', 'vol_2');
        

        if setVol_1>=setVol_2
            %volume on track 1
            u = udp(WMip,WMport);
            fopen(u);            
            while  track_1>=0.08                
                oscsend(u,'/1/volume1','f',track_1);
                oscsend(u,'/1/volume2','f',track_2);
                track_1=track_1-0.05;
                track_2=track_2+0.05;
                pause(0.2)
            end
            assignin('base','vol_1',  0);
            oscsend(u,'/1/volume1','f',0);
            
            assignin('base','vol_2',  0.75);
            oscsend(u,'/1/volume2','f',0.75);
            
            fclose(u);
            assignin('base','setVol_1',  0);
            assignin('base','setVol_2',  1);
        else
           %volume on track 2
            u = udp(WMip,WMport);
            fopen(u);            
            while  track_2>=0.08                
                oscsend(u,'/1/volume1','f',track_1);
                oscsend(u,'/1/volume2','f',track_2);
                track_1=track_1+0.05;
                track_2=track_2-0.05;
                pause(0.2)
            end
            assignin('base','vol_1',  0.75);
            oscsend(u,'/1/volume1','f',0.75);
            
            assignin('base','vol_2',  0);
            oscsend(u,'/1/volume2','f',0);
            fclose(u);
            
            assignin('base','setVol_1',  1);
            assignin('base','setVol_2',  0);          
        end
              
        
    case 5
        %volume
        
        u = udp(WMip,WMport);
        fopen(u);
        
        if setVol_1>setVol_2
            %rise on track1
            oscsend(u,'/1/volume1','f',quat_pitch);
            assignin('base','vol_1', quat_pitch);
        else
            %rise on track2
            oscsend(u,'/1/volume2','f',quat_pitch);
            assignin('base','vol_2', quat_pitch);
        end

        fclose(u);
        
end


end

