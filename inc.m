function x = inc(s,x)
%input: x is a binary array of length >s, s is integer
%output: x is binary array right shifted s
l=length(x);
x=num2str(x);
x=x(x~=' ');
x=[x(1:l-s)-'0',dec2bin(mod(bin2dec(x(end-s+1:end))+1,2^s),s)-'0'];