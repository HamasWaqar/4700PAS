
Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;


V = linspace(-1.95,0.7,200);
I = zeros(1,200);
I_Rand = zeros(1,200);0.


for j = 1:200
  I(j) = Is * (exp((1.2*V(j))/0.025)-1) + Gp * V(j) - Ib * (exp((-1.2*(V(j) + Vb))/0.025)-1);
  I_Rand(j) = I(j) * 0.5 * (rand()-0.5) + I(j);
end


figure;
subplot (4, 4, 1); 
plot(V, I);
hold on;
plot (V, I_Rand);
title ('Using Plot');
hold off

subplot (4, 4, 2); 
semilogy(V, I);
hold on
semilogy(V, I_Rand);
hold off
title ('Using semilog Plot');

poly4 = polyfit(V,I_Rand,4);
poly7 = polyfit(V,I_Rand,7);
polyVal4 = polyval(poly4,V);
polyVal7 = polyval(poly7,V);

subplot (4, 4, 3); 
plot(V, I);
hold on
plot(V, polyVal4);
hold off
title ('Using polyfit order 4 plot');


subplot (4, 4, 4); 
semilogy(V, abs(I));
hold on
semilogy(V, abs(polyVal4));
hold off
title ('Using polyfit order 4 semilog plot');


subplot (4, 4, 5); 
plot(V, I);
hold on
plot(V, polyVal7);
hold off
title ('Using polyfit order 7 plot');


subplot (4, 4, 6); 
semilogy(V, abs(I));
hold on
semilogy(V, abs(polyVal7));
hold off
title ('Using polyfit order 7 semilog plot');


VT = V.';
I_Rand_T = I_Rand.';
foAll = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)');
ffAll = fit(VT,I_Rand_T,foAll);
IfAll = ffAll(V);

foTwo = fittype('A.*(exp(1.2*x/25e-3)-1) + 0.1.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ffTwo = fit(VT,I_Rand_T,foTwo);
IfTwo = ffTwo(V);

foThree = fittype('A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+1.3))/25e-3)-1)');
ffThree = fit(VT,I_Rand_T,foThree);
IfThree = ffThree(V);


subplot (4, 4, 7); 
plot(V, I, 'r');
hold on
plot(VT, IfAll,'b--');
hold off
title ('Using fit function plot Four');


subplot (4, 4, 8); 
semilogy(V, abs(I), 'r');
hold on
semilogy(VT, abs(IfAll), 'b--');
hold off
title ('Using fit function semilog plot Four');

subplot (4, 4, 9); 
plot(V, I, 'r');
hold on
plot(VT, IfTwo,'b--');
hold off
title ('Using fit function plot Two');


subplot (4, 4, 10); 
semilogy(V, abs(I), 'r');
hold on
semilogy(VT, abs(IfTwo), 'b--');
hold off
title ('Using fit function semilog plot Two');

subplot (4, 4, 11); 
plot(V, I, 'r');
hold on
plot(VT, IfThree,'b--');
hold off
title ('Using fit function plot Three');


subplot (4, 4, 12); 
semilogy(V, abs(I), 'r');
hold on
semilogy(VT, abs(IfThree), 'b--');
hold off
title ('Using fit function semilog plot Three');


inputs = V.';
targets = I_Rand.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs)
view(net)
Inn = outputs


subplot (4, 4, 13); 
plot(V, I, 'r');
hold on
plot(V, Inn,'b--');
hold off
title ('Using NN plot');


subplot (4, 4, 14); 
semilogy(V, abs(I), 'r');
hold on
semilogy(V, abs(Inn), 'b--');
hold off
title ('Using NN semilog plot');






