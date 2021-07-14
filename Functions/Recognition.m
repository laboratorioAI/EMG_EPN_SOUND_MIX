function Y = Recognition(X)
%%
%%
    
     Data_test1=X';
     Ms1=Data_test1(1,:);
     Ms2=Data_test1(2,:);
     Ms3=Data_test1(3,:);
     Ms4=Data_test1(4,:);
     Ms5=Data_test1(5,:);
     Ms6=Data_test1(6,:);
     Ms7=Data_test1(7,:);
     Ms8=Data_test1(8,:);
     
    TableMyoDataTest = table(Ms1,Ms2,Ms3,Ms4,Ms5,Ms6,Ms7,Ms8);
    %% Additional Feature Extraction
    Sensor_mean     =   varfun(@Wmean, TableMyoDataTest);
    Sensor_stdv     =   varfun(@Wstd,  TableMyoDataTest);
    Sensor_env      =   varfun(@Wsumenv, TableMyoDataTest);
    
    Sensor_welch    =   varfun(@Wpwelch, TableMyoDataTest);
    Sensor_absmean  =   varfun(@Wabsmean, TableMyoDataTest);
    Sensor_energy   =   varfun(@Wenergy, TableMyoDataTest);
    %%
    MYOActivityData = [Sensor_mean, Sensor_stdv, Sensor_env, Sensor_welch, Sensor_absmean, Sensor_energy];
    %%
    %MYOModel4 = evalin('base', 'Modelper2par6t1'); %MIO Y MADRE ok ok
    %MYOModel4 = evalin('base', 'SVM2persons'); %MIO Y MADRE ok
     MYOModel4 = evalin('base', 'SVM20Waves'); %20waves
    %% Prediction Model 1 TREE
    Predicted=MYOModel4.predictFcn(MYOActivityData);
    Yp=char(Predicted);
    
    if Yp=="out"
        Y=1;
      
    end  
    
        if Yp=="in"
            Y=2;
            
        end 
    
            if Yp=="close"
                Y=3;
                               
                
            end 
    
                if Yp=="spread"
                    Y=4;
               
                end 
    
                    if Yp=="thumb"
                        Y=5;
                        
                    end 
    
                        if Yp=="relax"
                            Y=6;
                        end 
    
                            if Yp=="index"
                                Y=7;
                               
                            end 
    
                                if Yp=="middle"
                                    Y=8;
                                 
                                end 
    
                                    if Yp=="rock0"
                                        Y=9;
                                       
                                    end 
    
                                        if Yp=="little"
                                            Y=10;
                                         
                                        end 
    
                                            if Yp=="vsignal"
                                                Y=11;
                                             
                                            end 
                                                if Yp=="rock1"
                                                    Y=12;
                                                 
                                                end 
                                                %==============
                                                if Yp=="bang"
                                                    Y=13;
                                                 
                                                end
                                                if Yp=="join"
                                                    Y=14;
                                                 
                                                end
                                                if Yp=="capisci"
                                                    Y=15;
                                                 
                                                end
                                                if Yp=="shot"
                                                    Y=16;
                                                 
                                                end
                                                if Yp=="bene"
                                                    Y=17;
                                                 
                                                end
                                                if Yp=="y_signal"
                                                    Y=18;
                                                 
                                                end
                                                if Yp=="alone"
                                                    Y=19;
                                                 
                                                end
                                                if Yp=="par"
                                                    Y=20;
                                                 
                                                end
    
 
end

