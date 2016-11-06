% COMMUNICATION LABORATORY - I
% SIMULATION EXPERIMENT 3: Properties of PN sequences

close all;

%   GENERATION OF  PN SEQUENCES
% Generates two PN sequences of with num_bits length shift register

pn1 = [];
pn2 = [];
out1 = [];
out2 = [];
num_bits = 8;
initial_state = [1 0 0 1 1 0 0 1];
pn1(1:num_bits) = initial_state;
pn2(1:num_bits) = initial_state;
N = 2^num_bits-1;

for i = 1:N
    
    pn1(num_bits*i+2:num_bits*i+8) = pn1(num_bits*(i-1)+1:num_bits*(i-1)+7);
    pn1(num_bits*i+1) = xor(xor(pn1(num_bits*(i-1)+8),pn1(num_bits*(i-1)+4)),xor(pn1(num_bits*(i-1)+2),pn1(num_bits*(i-1)+3)));    % feedback taps are 8,4,3,2
    out1 = [out1 pn1(num_bits*i)];
    
    pn2(num_bits*i+2:num_bits*i+8) = pn2(num_bits*(i-1)+1:num_bits*(i-1)+7);
    pn2(num_bits*i+1) = xor(xor(pn2(num_bits*(i-1)+8),pn2(num_bits*(i-1)+6)),xor(pn2(num_bits*(i-1)+5),pn2(num_bits*(i-1)+3)));    % feedback taps are 8,6,5,3
    out2 = [out2 pn2(num_bits*i)];
        
end

for i = 1:length(out1)
    if out1(i)==0
        out1(i)=-1;
    end
    if out2(i)==0
        out2(i) = -1;
    end
end

figure;
stairs(out1);
axis([0 N+1 -1.2 1.2]);
title('PN Sequence 1');
figure;
stairs(out2);
axis([0 N+1 -1.2 1.2]);
title('PN Sequence 2');

%   AUTOCORRELATION

% Generating the circulant matrix to obtain the autocorrelation sequences

C(1,1:N) = out1;
for i = 2:N
    C(i,1) = C(i-1,N);
    C(i,2:N) = C(i-1,1:N-1);
end

for i = 1:N-1
    R(i) = (1/N)*sum(C(1,1:N).*C(i,1:N));
end


figure;
plot(R);
title('Autocorrelation');

%   CROSS-CORRELATION

for i = 1:N-1
    A(i) = (1/N)*sum(out2(1,1:N).*C(i,1:N));
end

figure;
plot(A);
title('Cross-correlation');