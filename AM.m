% COMMUNICATION LABORATORY - I
% SIMULATION EXPERIMENT 1: Amplitude Modulation and Demodulation
% AUTHORS: Prachi Shahi - 14EC239, Samhita Varambally - 14EC244

close all;

%   MODULATION

L = 2^12;           % Length of the signals
Fs = 10^6;          % Sampling frequency; much higher than Nyquist frequency
t = (0:L-1)/Fs;

fc = 20e3;          % Carrier frequency
Ac = 1.5;           % Carrier - 3Vp-p
c = Ac*cos(2*pi*fc*t);
figure;
plot(t,c);
title('Carrier'); xlabel('Time (s)'); ylabel('Amplitude (V)');

fm = 1e3;          % Message frequency
Am = 1;            % Message - 2Vp-p
m = Am*cos(2*pi*fm*t);
figure;
plot(t,m);
title('Modulating Signal'); xlabel('Time (s)'); ylabel('Amplitude (V)');

mod_index = 0.5;        % Adjust this value for undermodulation, overmodulation or perfect modulation
am = (1+mod_index*m).*c;
figure;
plot(t,am);
title('Amplitude Modulated Signal'); xlabel('Time (s)'); ylabel('Amplitude (V)');


%   SYNCHRONOUS DEMODULATION

% The recieved AM signal is multiplied with the carrier and then passed
% through a low pass filter with cutoff frequency greater than the maximum
% frequency in the message and less than the carrier frequency to get the 
% message signal.

c_r = cos(2*pi*fc*t);       % cos(wct) at the receiver
x = c_r.*am;
% Low pass filter with cutoff frequency 1.5kHz
n = 50;
Wn = 1.5e3/(Fs/2);
b = fir1(n,Wn);
output = filter(b,1,x);
figure;
plot(t,output);
title('Synchronously Demodulated Signal'); xlabel('Time (s)'); ylabel('Amplitude (V)');


%   NON-COHERENT DETECTION

Vc(1) = 0;                              % initial capacitor voltage
for i = 2:length(am)
    if am(i) > Vc(i-1)                   % diode on (charging)
        Vc(i) = am(i);
    else                                % diode off (discharging)
        Vc(i) = Vc(i-1)*exp(-0.0025);
    end
end

n = 50;
Wn = 1.5e3/(Fs/2);                      % 1.5kHz cutoff frequency
b = fir1(n,Wn);
output = filter(b,1,Vc);
figure;
plot(t, Vc);
title('Envelope Detector Output'); xlabel('Time (s)'); ylabel('Amplitude (V)');


