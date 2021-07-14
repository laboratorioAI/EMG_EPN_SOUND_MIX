function Y_org = WMoos_X(mad)
% This code calcutates new order if "orientationCorrection" option is set "on"
% if "orientationCorrection" option is set "off" the order value turns to
% default=1 (no correction)

X_org=zeros(1,7);
k_sync=1;
madDefault=1;

if mad >8 || mad<=0
    Sx=madDefault;
else
    Sx=mad;
end


for y=1:(8-Sx)
    sx=mod(Sx+y,9);
    X_org(1,k_sync)=sx;
    k_sync=k_sync+1;
end

for y=0:(Sx-2)
    sx=mod(1+y,9);
    X_org(1,k_sync)=sx;
    k_sync=k_sync+1;
end
Y_org=[Sx X_org];
end

