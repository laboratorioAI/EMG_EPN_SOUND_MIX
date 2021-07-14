function [Wave,Tool,Mass,Color] = WMselection()


countMyos=1;                
m = MyoMex(countMyos);
m1 = m.myoData(1);
m1.timeEMG; 
m1.emg;
m1.stopStreaming();
m.myoData.clearLogs();
m1.startStreaming();

emg=zeros(40,8);

counter1=0;
counter2=0;
counter3=0;
counter9=0;
counter5=0;
counter6=0;

Mass_sel=0;
Color_sel=0;

order =  evalin('base', 'order');
mass  =  evalin('base', 'mass');
color =  evalin('base', 'color');
high_limit =  evalin('base', 'umbral_high');
low_limit  =  evalin('base', 'umbral_low');

line=1;
tool=0;


out_wave=0;
in_wave=0;
close_wave=0;
spread_wave=0;
ok_wave=0;
relax_wave=0;

selected=0;

runMYO=1; 

while runMYO==1  
    
    timeEMG = m1.timeEMG_log;
    if ~isempty(timeEMG)
        
        T_emg=timeEMG(:,1)>=(timeEMG(end,1)-0.8);
        
        emg=m1.emg_log(T_emg,:);
        umbral=Wsumenv(emg');
        
        if umbral(1:4,:) > high_limit | umbral(5:8,:) > low_limit
            
            
            switch order
                case 1
                    emg=m1.emg_log(T_emg,[1,2,3,4,5,6,7,8]);
                case 2
                    emg=m1.emg_log(T_emg,[2,3,4,5,6,7,8,1]);
                case 3
                    emg=m1.emg_log(T_emg,[3,4,5,6,7,8,1,2]);
                case 4
                    emg=m1.emg_log(T_emg,[4,5,6,7,8,1,2,3]);
                case 5
                    emg=m1.emg_log(T_emg,[5,6,7,8,1,2,3,4]);
                case 6
                    emg=m1.emg_log(T_emg,[6,7,8,1,2,3,4,5]);
                case 7
                    emg=m1.emg_log(T_emg,[7,8,1,2,3,4,5,6]);
                case 8
                    emg=m1.emg_log(T_emg,[8,1,2,3,4,5,6,7]);
                    
                otherwise
                    
            end
            
            %%
            pause(0.05)
            tic
            selected=Recognition_5waves(emg);
            toc
            delay=10;%4
            %%
            switch selected
                
                case 1
                    counter1=counter1+1;
                    if counter1>=delay
                        out_wave=tool+1;
                        tool=out_wave;
                        beep;
                        counter1=0;
                        
                        if tool>3 && line==1
                            tool=1;
                        end
                        if tool>6 && line==2
                            tool=4;
                        end
                    end
                    counter2=0;
                    counter3=0;
                    counter9=0;
                    counter5=0;
                    counter6=0;
                    
                case 2
                    counter2=counter2+1;
                    if counter2>=delay
                        in_wave=tool-1;
                        tool=in_wave;
                        beep;
                        counter2=0;
                        if tool<1 && line==1
                            tool=3;
                        end
                        if tool<4 && line==2
                            tool=6;
                        end
                    end
                    counter1=0;
                    counter3=0;
                    counter9=0;
                    counter5=0;
                    counter6=0;
                    
                case 3
                    counter3=counter3+1;
                    if counter3>=delay*3
                        runMYO=0;
                        counter3=0;
                    end
                    counter1=0;
                    counter5=0;
                    counter9=0;
                    counter2=0;
                    counter6=0;
                    
                case 4
                case 5
                    counter5=counter5+1;
                    if counter5>=delay*3
                        ok_wave=ok_wave+1;
                        if ok_wave==1
                            mass=tool;
                            line=2;
                            tool=4;
                            beep;
                        end
                        pause(0.8)
                        if ok_wave==2
                            color=tool;
                            line=1;
                            tool=1;
                            beep;
                        end
                        if ok_wave>=2
                            ok_wave=0;
                        end
                        counter5=0;
                    end
                    counter1=0;
                    counter2=0;
                    counter9=0;
                    counter3=0;
                    counter6=0;
                    
                case 6
                    counter6=counter6+1;
                    if counter6>=delay*3
                        counter6=0;
                    end
                    counter2=0;
                    counter3=0;
                    counter9=0;
                    counter5=0;
                    counter1=0;
                    
                case 7
                case 8
                case 9
                    counter9=counter9+1;
                    if counter9>=delay*1.5
                        ok_wave=0;
                        mass=0;
                        color=0;
                        line=1;
                        tool=0;
                        counter9=0;
                        beep;
                    end
                    
                    counter1=0;
                    counter3=0;
                    counter2=0;
                    counter5=0;
                    counter6=0;
                    
                case 10
                case 11
                case 12
                    
                otherwise
                    
            end
            %%
            switch tool
                case 0;Mass_sel="No Grams";mass=1;Color_sel="No color";color=1;
                    
                case 1;Mass_sel="0 Grams";mass=1;
                case 2;Mass_sel="20 Grams";mass=2;
                case 3;Mass_sel="0-100 Grams";mass=3;
                    
                case 4;Color_sel="Red";color=1;
                case 5;Color_sel="Green";color=2;
                case 6;Color_sel="Blue";color=3;
                    
            end
            
            
        else
        selected=0;
            
        end
        
    end
    

 %%       
Wave=selected;
Tool=tool;
Mass=mass;
Color=color;
Data=[Wave,Mass_sel,Color_sel]


end 

m1.stopStreaming();    %Stop streaming Myo_1 all data
m.myoData.clearLogs();
m.delete;              %Delete variable for Myo_1   
clear m                %Clear variable for Myo_1
 
end

