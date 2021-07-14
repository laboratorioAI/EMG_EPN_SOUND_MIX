function [TargetFixed,aux,two_counter] = Wmoos_correction_module_two(emgTargetPostprocessed,mean_)
fprintf(' ***** Paper X  Module Two Correction ****  \n');
tic
emgCounterCompact  =  evalin('base', 'emgCounterCompact');
buffer_compact     =  evalin('base', 'buffer_compact');


if emgCounterCompact==mean_
    two_counter=emgCounterCompact+1;
       
    buffer_compact{1,emgCounterCompact}=emgTargetPostprocessed;
    assignin('base','emgCounterCompact', 1);
    
        idwaveOut = strfind(buffer_compact, 'waveOut');
        idwaveOut = find(not(cellfun('isempty', idwaveOut)));
        waveOut_  = length(idwaveOut);
        
        idwaveIn  = strfind(buffer_compact, 'waveIn');
        idwaveIn  = find(not(cellfun('isempty', idwaveIn)));
        waveIn_   = length(idwaveIn);
        
        idfist    = strfind(buffer_compact, 'fist');
        idfist    = find(not(cellfun('isempty', idfist)));
        fist_     = length(idfist);
        
        idopen    = strfind(buffer_compact, 'open');
        idopen    = find(not(cellfun('isempty', idopen)));
        open_     = length(idopen);
        
        idpinch   = strfind(buffer_compact, 'pinch');
        idpinch   = find(not(cellfun('isempty', idpinch)));
        pinch_    = length(idpinch);
        
        vector      = [waveOut_ waveIn_ fist_ open_ pinch_ ];
        [val_vector,checkVector] = max(vector);
           
        if checkVector==0
            TargetFixed='noGesture';
        else
            
           if val_vector>=1       %2 
            [~,pos]=max(vector);
            
            switch pos
                
                case 1
                    TargetFixed='waveOut';
                case 2
                    TargetFixed='waveIn';
                case 3
                    TargetFixed='fist';
                case 4
                    TargetFixed='open';
                case 5
                    TargetFixed='pinch';
                    
            end
            
            idfixed   = strfind(buffer_compact, TargetFixed);
            idempty    = find((cellfun('isempty', idfixed)));
            index_zero    = length(idempty);
            
            for j=1:index_zero
                k=idempty(j);
                idfixed{1,k}=0;
            end
            aux_fixed=cell2mat(idfixed);
            aux_logical=(aux_fixed>0);
            
            buffer_compact_fixed={};
            assignin('base','buffer_compact_fixed', buffer_compact_fixed);
            control=0;
            
            for k=1:mean_
                buffer_compact_fixed  =  evalin('base', 'buffer_compact_fixed');
                
                if aux_logical(k)==0 && control==0
                    buffer_compact_fixed{1,k}='noGesture';
                    assignin('base','buffer_compact_fixed', buffer_compact_fixed);
                else
                    control=1;
                    buffer_compact_fixed{1,k}=TargetFixed;
                    assignin('base','buffer_compact_fixed', buffer_compact_fixed);
                end
                
            end
            
           else
               TargetFixed='noGesture';
               
               for i=1: mean_
                   buffer_compact_fixed{1,i}='noGesture';
               end
           end
        end
        
    Wmoos_correction_buffer(mean_);
    
    lapse_module_two=toc;    
%     fprintf('Gesture Predicted 1 = %s \n',buffer_compact_fixed{1,1});
%     fprintf('Gesture Predicted 2 = %s \n',buffer_compact_fixed{1,2});
%     fprintf('Gesture Predicted 3 = %s \n',buffer_compact_fixed{1,3});
%     fprintf('Gesture Predicted 4 = %s \n',buffer_compact_fixed{1,4});
%     fprintf('Time Prediction Module Two ....[ Buffers ] = %f \n',lapse_module_two);
%     fprintf('  \n'); 
    
    aux=buffer_compact_fixed;
    
    clear buffer_compact_fixed
    buffer_compact_fixed={};
    assignin('base','buffer_compact_fixed', buffer_compact_fixed);
    

else
    
    buffer_compact{1,emgCounterCompact}=emgTargetPostprocessed;
    TargetFixed='noGesture';
    
    two_counter=emgCounterCompact+1;
    
    assignin('base','emgCounterCompact', emgCounterCompact+1);
    assignin('base','buffer_compact', buffer_compact);
    aux='noGesture';
    
    
    
    lapse_module_two=toc;
    fprintf('Gesture Predicted 1 = %s \n',aux);
    fprintf('Gesture Predicted 2 = %s \n',aux);
    fprintf('Gesture Predicted 3 = %s \n',aux);
    fprintf('Gesture Predicted 4 = %s \n',aux);
    fprintf('Time Prediction Module Two    .[ Buffers ] = %f \n',lapse_module_two);
    fprintf('  \n');   
    

end


end

