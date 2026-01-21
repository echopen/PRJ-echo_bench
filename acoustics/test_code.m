clear all;
close all;

tlim=2.3;
Npoint=1025;
offset=0.5;

t=linspace(-tlim,tlim,Npoint)*10^(-6);
fech=1/(t(2)-t(1))/10^6;
f=3.5*10^6;
om=2*pi*f;
sig=sin(om*t);
tau=1/f*1;
sig=sig.*exp(-(t/tau).^2);
sig=sig+offset;

[Nzeropad, sigzp] = zero_padding (sig, 0);

figure(1)
plot(t,sig);
figure(2)
plot(sigzp);

[env1] = envelope_detection (sig, fech, 0.5, 8,0);
[env2] = envelope_detection (sig, fech, 0.5, 8,1);

figure(3)
plot(t,(sig-offset),t,env1,t,env2);