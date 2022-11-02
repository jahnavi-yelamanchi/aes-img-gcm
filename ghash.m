function y = ghash(x,H)
%input: x is binary array, H is binary array
%output: y is binary array
y=zeros(1,128);
m=length(x)/128;
for k=1:m
    y=mdot(xor(y,x((k-1)*128+1:k*128)),H);
end