function z = mdot(x,y)
%input: x is binary array, y is binary array
%output: z is binary array
z=zeros(1,128);
R=[1 1 1 0 0 0 0 1,zeros(1,120)];
v=y;
for k=0:127
    if x(k+1)
        z=xor(z,v);
    end
    v=circshift(v,1);
    t=v(1);
    v(1)=0;
    if t
        v=xor(v,R);
    end
end