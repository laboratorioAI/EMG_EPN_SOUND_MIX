function [] =WMbase()
data=load('WMbase_data.mat','SVM20Waves');

SVM20Waves=data.SVM20Waves;

assignin('base','SVM20Waves',SVM20Waves);

end

