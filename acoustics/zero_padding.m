function [Nzeropad, sigzp] = zero_padding (sig, option)

%this function is made for making a zero padding to a data vector sig
%zero_padding consiste in changing the number of elements of the the initial vector of size N
%to a number Nzeropad wich is a power of 2 to enjoy the speed of fft algorithm
%sigzp is filled with 0 from N to Nzeropad if option = 0
%sigzp is filled with the mean of sig from N to Nzeropad if option != 0

N=length(sig);

pow=0;

while (2^pow<N)
    if (2^pow != N)
        pow++;
    endif
 endwhile
 
 Nzeropad=2^pow;
 sigzp=zeros(Nzeropad, 1);
 sigzp(1:N)=sig;
 
if option!=0
    mean = sum(sig)/N;
    sigzp(N+1:Nzeropad)=mean;
 endif
    
endfunction