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
c = Ac*sin(2*pi*fc*t);
figure;
plot(t,c);
title('Carrier'); xlabel('Time (s)'); ylabel('Amplitude (V)');

fm = 1e3;          % Message frequency
Am = 1;            % Message - 2Vp-p
m = Am*sin(2*pi*fm*t);
figure;
plot(t,m);
title('Modulating Signal'); xlabel('Time (s)'); ylabel('Amplitude (V)');

mod_index = 0.5;        % Adjust this value for undermodulation, overmodulation or perfect modulation
am = (1+mod_index*m).*c;
figure;
plot(t,am);
title('Amplitude Modulated Signal'); xlabel('Time (s)'); ylabel('Amplitude (V)');
