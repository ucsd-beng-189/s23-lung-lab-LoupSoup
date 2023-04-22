%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI B pci parts;
%global variables B for changing beta and parts to save partial pressure
%values for each run

%for task 5 want mean alveolar, mean arterial, and venous partial pressure
%and O2 concentrations
cIPAbar = [];
cIPabar = [];
cIPv = [];
cIcAbar = [];
cIcabar = [];
cIcv = [];

%defualt beta is .5; variable beta step
%For task 5, varying cI similarly to how beta was varied; using default
%beta=.5
B=.5;
interval=.01;
%Bvals=0:interval:1;

%starting M at .25*cref*5.6; increasing the .25 scalar by .001 which took
%longer to run, .01 works fineish
m=0;
mint=.1;
mcheck=1;
maxMs=[];


%loop for pci values 0 to 1 with interval as step task 5
%for task 3 onward, suppressing the outchecklung graph outputs
for i=0:interval:1
pci=i;
setup_lung          %sets M to .25*cref*5.6

%%task 3
% % %cvsolve throws error when M is too high: Mdiff(0,r)>0
% % %find greatest M by increasing M till Mdiff(0,r)>0
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
m=0; %reset m for next beta
mcheck=1;
%using task 3 to allow for very low inspired O2 levels to run

cvsolve
outchecklung
% %outchecklung saved parts as [PAbar Pabar Pv cAbar cabar cv]
cIPAbar(1,end+1)=parts(1);
cIPabar(1,end+1)=parts(2);
cIPv(1,end+1)=parts(3);
cIcAbar(1,end+1)=parts(4);
cIcabar(1,end+1)=parts(5);
cIcv(1,end+1)=parts(6);
end


%Task 5 plots
civals=0:interval:1;
civals=civals.*(0.2/(22.4*(310/273)));
presspart=[cIPAbar' cIPabar' cIPv'];
concpart=[cIcAbar' cIcabar' cIcv'];
figure(4)
plot(civals,presspart,'.')
title('partial pressures v. cI')
xlabel('inspired air O2 conc')
ylabel('pressures mmHg')
legend('mean alveolar','mean arterial','venous')
figure(5)
plot(civals,concpart,'.')
title('O2 conc v. cI')
xlabel('inspired air O2 conc')
ylabel('O2 conc mol/liter')
legend('mean alveolar','mean arterial','venous')

% %Task 4 beta and M plot
% figure(4)
% plot(Bvals,maxMs,'.')
% title('max oxygen consumption at diff betas')
% xlabel('betas')
% ylabel('moles/min')

%Task 3 plots
% pressparts=[bPI' bPAbar' bPabar' bPv'];
% figure(4)
% plot(Bvals,pressparts,'.')
% title('partial pressures v. beta')
% xlabel('betas')
% ylabel('pressures')
% legend('inspired','mean alveolar','mean arterial','venous')


