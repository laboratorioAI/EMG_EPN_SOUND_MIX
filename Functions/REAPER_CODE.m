ipDir='192.168.1.3';
u = udp(ipDir,8005);
fopen(u);
oscsend(u,'/1/volume0','f',0);
oscsend(u,'/1/volume1','f',0);
oscsend(u,'/1/volume2','f',0);
oscsend(u,'/1/volume3','f',0);
oscsend(u,'/1/volume4','f',0);
oscsend(u,'/1/volume5','f',0);
oscsend(u,'/1/volume6','f',0);
fclose(u);

%%
u = udp(ipDir,8005);
fopen(u);
oscsend(u,'/1/volume0','f',0.70);
fclose(u);

%% play
u = udp(ipDir,8005);
fopen(u);
oscsend(u,'t/1/play','f', 1);
fclose(u);

%% stop

u = udp(ipDir,8005);
fopen(u);
oscsend(u,'/1/stop','f', 1);
fclose(u);


%% volume  DOWN 0.0
%IMU DATA 

u = udp(ipDir,8005);
fopen(u);
oscsend(u,'/1/volume5','f',0);
fclose(u);

%% volume  DOWN 0.12
%IMU DATA 

u = udp(ipDir,8005);
fopen(u);
oscsend(u,'/1/volume1','f',0.12);
fclose(u);

%% volume  DOWN 0.32
%IMU DATA 

u = udp(ipDir,8005);
fopen(u);
oscsend(u,'/1/volume3','f',0.12);
fclose(u);

%% =========================================

%% volume UP 0.5
%IMU DATA 

u = udp(ipDir,8005);
fopen(u);
oscsend(u,'/1/volume1','f',0.20);
fclose(u);

%% volume UP 0.7
%IMU DATA 

u = udp(ipDir,8005);
fopen(u);
oscsend(u,'/1/volume5','f',0.85);
fclose(u);

%% volume UP 0.9
%IMU DATA 
u = udp(ipDir,8005);
fopen(u);

oscsend(u,'1/solo/1/@','f', 1);
fclose(u);

%b/1/forward

%% ==================================
%% fader

% u = udp('192.168.1.4',8005);
% fopen(u);
% oscsend(u,'/1/fader1','f', 0.1);
% fclose(u);

%% mute

% u = udp('192.168.1.4',8005);
% fopen(u);
% oscsend(u,'/1/mute','i', 1);
% fclose(u);

