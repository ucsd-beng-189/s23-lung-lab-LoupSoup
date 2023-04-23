%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI B pci parts Patm adapt;
%global variables B for changing beta and parts to save partial pressure
%values for each run

%for task 5 want mean alveolar, mean arterial, and venous partial pressure
%and O2 concentrations
tPAbar = [];
tPabar = [];
tPv = [];
tcAbar = [];
tcabar = [];
tcv = [];

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

%Task 7 altitude variation - varying atm pressure which calcs PI in setup_lung; using the relationship
%Patm=101325(1-(2.25577*10^-5)*h)^5.25588 in pascals and converting to mmhg
%This relationship varies with humidity and temperature, so this is
%somewhat arbitrary but gives a somewhat realistic pressure gradient to use
Patm=760;
alt=0:100:15000;%altitude every 100 meters; 150 values
atmPs=101325*((1-(2.25577*10^-5)*alt).^5.25588); %in Pascals
atmPs=atmPs/133.3; %convert to mmHg
adapt=1; %1 for task 6, 1.5 for task 7

%task 9 adapt now goes below 1 to reflect worse hemoglobin in the blood
adp=adapt:-.05:.1;   %not 0 bc no hemoglobin at all is trivial



%for task 3 onward, suppressing the outchecklung graph outputs
for i=1:size(adp,2)
adapt=adp(i);

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
maxMs(1,end+1)=M;
m=0; %reset m for next beta
mcheck=1;
%using task 3 to allow for very low inspired O2 levels to run

cvsolve
outchecklung
% %outchecklung saved parts as [PAbar Pabar Pv cAbar cabar cv]
tPAbar(1,end+1)=parts(1);
tPabar(1,end+1)=parts(2);
tPv(1,end+1)=parts(3);
tcAbar(1,end+1)=parts(4);
tcabar(1,end+1)=parts(5);
tcv(1,end+1)=parts(6);
end


%Task 9 plots
anemic=adp*cref;
presspart=[tPAbar' tPabar' tPv'];
concpart=[tcAbar' tcabar' tcv'];
figure(4)
plot(anemic,presspart,'.')
title('partial pressures v. blood ox conc')
xlabel('blood oxygen concentration')
ylabel('pressures mmHg')
legend('mean alveolar','mean arterial','venous')
figure(5)
plot(anemic,concpart,'.')
title('O2 conc v. blood ox conc')
xlabel('blood oxygen concentration')
ylabel('O2 conc mol/liter')
legend('mean alveolar','mean arterial','venous')
%determining altitude at which normal resting O2 consumption rate is
%unsustainable: ^^rate is defined as .25*cref*5.6 = 0.0110
Mrest=.25*cref*5.6;
Mdead=find(maxMs(:)<Mrest,1)
anemiadead=anemic(Mdead-1)  %the one before it is unsustainable
cstardead=anemiadead*cref*5.6
%altdead=alt(Mdead)

% %Task 6 and 7 plots
% presspart=[cIPAbar' cIPabar' cIPv'];
% concpart=[cIcAbar' cIcabar' cIcv'];
% figure(4)
% plot(alt,presspart,'.')
% title('partial pressures v. altitude')
% xlabel('altitude (m)')
% ylabel('pressures mmHg')
% legend('mean alveolar','mean arterial','venous')
% figure(5)
% plot(alt,concpart,'.')
% title('O2 conc v. altitude')
% xlabel('altitude (m)')
% ylabel('O2 conc mol/liter')
% legend('mean alveolar','mean arterial','venous')
% %determining altitude at which normal resting O2 consumption rate is
% %unsustainable: ^^rate is defined as .25*cref*5.6 = 0.0110
% Mrest=.25*cref*5.6;
% Mdead=find(maxMs(:)<Mrest,1)
% altdead=alt(Mdead)


% %Task 5 plots
% civals=0:interval:1;
% civals=civals.*(0.2/(22.4*(310/273)));
% presspart=[cIPAbar' cIPabar' cIPv'];
% concpart=[cIcAbar' cIcabar' cIcv'];
% figure(4)
% plot(civals,presspart,'.')
% title('partial pressures v. cI')
% xlabel('inspired air O2 conc')
% ylabel('pressures mmHg')
% legend('mean alveolar','mean arterial','venous')
% figure(5)
% plot(civals,concpart,'.')
% title('O2 conc v. cI')
% xlabel('inspired air O2 conc')
% ylabel('O2 conc mol/liter')
% legend('mean alveolar','mean arterial','venous')

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


