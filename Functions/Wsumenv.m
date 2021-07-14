function Y = Wsumenv(X)

        envol=hilbert(X);
        out_partial=abs(envol);
        %% Filter  Savitzky-Golay 
        aux = sgolayfilt(out_partial,1,7);
        Y=trapz(aux,2);        
        
end

%Y=trapz(b); 
%Y2=trapz(b');
%y3=Y2';
