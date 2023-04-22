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
Bvals=0:interval:1;

%starting M at .25*cref*5.6; increasing the .25 scalar by .001 which took
%longer to run, .01 works fineish
m=.25;
mint=.01;
mcheck=1;
maxMs=[];

%loop for beta values 0 to 1 with interval as step
%for task 3, suppressing the outchecklung graph outputs
for i=0:interval:1
B=i;
setup_lung          %sets M to .25*cref*5.6
%cvsolve throws error when M is too high: Mdiff(0,r)>0
%find greatest M by increasing M till Mdiff(0,r)>0
    while mcheck==1
        M=m*cref*5.6;
        if Mdiff(0,r)>0     %if <- that then M too big
            mcheck=0;
            m=m-2*mint;
        end
        m=m+mint;  
    end
M=m*cref*5.6;
maxMs(1,end+1)=m;
cvsolve
m=.25; %reset m for next beta
mcheck=1;

outchecklung
% %outchecklung saved parts as [PI PAbar Pabar Pv]
% bPI(1,end+1)=parts(1);
% bPAbar(1,end+1)=parts(2);
% bPabar(1,end+1)=parts(3);
% bPv(1,end+1)=parts(4);
end


%Task 4 beta and M plot
figure(4)
plot(Bvals,maxMs,'.')
title('max oxygen consumption at diff betas')
xlabel('betas')
ylabel('moles/min')


%Task 3 plots
% pressparts=[bPI' bPAbar' bPabar' bPv'];
% figure(4)
% plot(Bvals,pressparts,'.')
% title('partial pressures v. beta')
% xlabel('betas')
% ylabel('pressures')
% legend('inspired','mean alveolar','mean arterial','venous')


