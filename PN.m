% COMMUNICATION LABORATORY - I
% SIMULATION EXPERIMENT 2: Properties of PN sequences
% AUTHORS: Prachi Shahi - 14EC239, Samhita Varambally - 14EC244

close all;

%   GENERATION OF  PN SEQUENCES
% Generates two PN sequences of length 255

pn1 = [];
pn2 = [];
out1 = [];
out2 = [];

initial_state = [1 0 0 1 1 0 0 1];
pn1(1:8) = initial_state;
pn2(1:8) = initial_state;

for i = 1:256
    
    pn1(8*i+2:8*i+8) = pn1(8*(i-1)+1:8*(i-1)+7);
    pn1(8*i+1) = xor(xor(pn1(8*(i-1)+8),pn1(8*(i-1)+4)),xor(pn1(8*(i-1)+2),pn1(8*(i-1)+3)));    % feedback taps are 8,4,3,2
    out1 = [out1 pn1(8*i)];
    
    pn2(8*i+2:8*i+8) = pn2(8*(i-1)+1:8*(i-1)+7);
    pn2(8*i+1) = xor(xor(pn2(8*(i-1)+8),pn2(8*(i-1)+6)),xor(pn2(8*(i-1)+5),pn2(8*(i-1)+3)));    % feedback taps are 8,6,5,3
    out2 = [out2 pn2(8*i)];
        
end


figure;
stairs(out1);
figure;
stairs(out2);