function []= Wmoos_correction_buffer(mean_)

for i=1: mean_
buffer_compact{1,i}='noGesture';
end

assignin('base','buffer_compact', buffer_compact);
assignin('base','emgCounterCompact', 1);

end
