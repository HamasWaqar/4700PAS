clc; close all;  clear all;  %initialization

%--------------------------------------------------------------------------
% List of the components (netlist):
%--------------------------------------------------------------------------
g1 = 1/1;
c = 0.25;
g2 = 1/2;
L = 0.2;
g3 = 1/10;
a = 100;
g4 = 1/0.1;
gro = 1/1000;

% f = 0;
% = 1:1:50;
w = linspace(0,100,100);
k = 1i;
s = k * w;


G = [g1 -g1 0 0 0 0 1 0;
     -g1 g1+g2 0 0 0 1 0 0;
     0 0 g3 0 0 -1 0 0;
     0 0 0 g4 -g4 0 0 1;
     0 0 0 -g4 g4+gro 0 0 0;
     0 1 -1 0 0 0 0 0;
     1 0 0 0 0 0 0 0;
     0 0 -a*g3 1 0 0 0 0]
    

C = [c -c 0 0 0 0 0 0;
    -c c 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0;
     0 0 0 0 0 -L 0 0;
     0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0]
 
%You should enter the entries of the source column vector b:
b = [0;0;0;0;0;0;0;0]

% Time

v = 1;

for n=1:100
    s = k * w(n)
    A = G + s.*C;
    b(7) = v;
    x = A\b;
     v5(n) = (x(5));
     v3(n) = (x(3));
end

% figure;
plot(w,abs(v5));
hold on
plot(w,abs(v5));
hold off
xlabel('Ohm (Omega)');
ylabel ('Vout (V)');
title('AC Case');



