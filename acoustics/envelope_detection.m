function [envelope] = envelope_detection (signal, fech, fmin, fmax,option)

%function to determine the envelope of a the data vector named signal
%fech is the sampling frequency of the data vector in MHz
%we add a filtering of the signal between fmin and fmax in MHz
%option refer to the option of the zero padding process:
%sigzp is filled with 0 from N to Nzeropad if option = 0
%sigzp is filled with the mean of sig from N to Nzeropad if option != 0
%%%%
%if signal have an offset, the output envelope won't have, but still need to put
%option != 0 if signal have an offset and want a clean envelope

if fmin<0
    fmin=0;
endif
if fmax>fech/2
    fmax=fech/2;
endif
if fmax<fmin
    fmax=fmin;
endif

N=length(signal);
[Nzeropad, sigzp] = zero_padding (signal, option);
Sig=fft(sigzp);
deltaf=fech/Nzeropad;

nmin=floor(fmin/deltaf)+1;
nmax=floor(fmax/deltaf)+1;

Sig(1:nmin)=0;
Sig(nmax:Nzeropad)=0;
tmpenv=abs(ifft(Sig))*2;
envelope=tmpenv(1:N);

endfunction