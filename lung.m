%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI B parts;
%global variables B for changing beta and parts to save partial pressure
%values for each run
%vectors for plotting partial pressures against beta
bPI = [];
bPAbar = [];
bPabar = [];
bPv = [];

%defualt beta is .5; variable beta step
B=.5;
interval=.01;

%loop for beta values 0 to 1 with interval as step
%for task 3, suppressing the outchecklung graph outputs
for i=0:interval:1
B=i;
setup_lung
cvsolve
outchecklung
%outchecklung saved parts as [PI PAbar Pabar Pv]
bPI(1,end+1)=parts(1);
bPAbar(1,end+1)=parts(2);
bPabar(1,end+1)=parts(3);
bPv(1,end+1)=parts(4);
end

pressparts=[bPI' bPAbar' bPabar' bPv'];
Bvals=0:interval:1;
figure(4)
plot(Bvals,pressparts,'.')
title('partial pressures v. beta')
xlabel('betas')
ylabel('pressures')
legend('inspired','mean alveolar','mean arterial','venous')


