function emgDataTarget = Wmoos_names_convertion(emgDataTarget)

switch emgDataTarget
    case 1
        emgDataTarget='waveOut';
    case 2
        emgDataTarget='waveIn';
    case 3
        emgDataTarget='fist';
    case 4
        emgDataTarget='open';
    case 5
        emgDataTarget='pinch';
    case 6
        emgDataTarget='noGesture';
    otherwise
        
        emgDataTarget='noGesture';
end

end

