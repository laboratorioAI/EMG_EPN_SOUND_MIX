function emgDataTarget = Wmoos_names_convertion_back(emgDataTarget)

switch emgDataTarget
    case 'waveOut'
        emgDataTarget=1;
    case 'waveIn'
        emgDataTarget=2;
    case 'fist'
        emgDataTarget=3;
    case 'open'
        emgDataTarget=4;
    case 'pinch'
        emgDataTarget=5;
    case 'noGesture'
        emgDataTarget=6;
    otherwise
        
        emgDataTarget=6;
end

end
