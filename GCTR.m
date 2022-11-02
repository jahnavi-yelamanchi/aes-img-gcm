function y = GCTR(key,icb,x)
%input: key is hex,icb is binary array, x binary array
%output: y is binary array
if isempty(x)
    y=[];
    return;
end
n=ceil(length(x)/128);
cb(1,:)=icb;
for i=2:n
    cb(i,:)=inc(32,cb(i-1,:));
end
y=[];
for i=1:n-1
    y=[y,xor(x((i-1)*128+1:i*128),Cipher(key,cb(i,:)))];
end
l=length(x)-(n-1)*128;
c=Cipher(key,cb(n,:));
y=[y,xor(x((n-1)*128+1:end),c(1:l))];