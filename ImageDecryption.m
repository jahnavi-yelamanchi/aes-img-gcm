function [ImageOut,authTagResult] = ImageDecryption(secretKey,iv,outputCipher,aad,authTag)
%
%Algorithm for the Authentiated Image Decryption Function using
%Galois Counter Mode (GCM) Block Cipher using AES-128,192,256 based on key
%length. Implimentation based on NIST Special Publication 800-38D.
%Inputs: secretKey - hexidecimal (128,192, or 256 bits), iv -
%initialization vector (random 96-bit hexidecimal), outputCipher -
%uint8 encrypted matrix of same size as original image, aad - additional
%authenticated data (plaintext string), authTag - authentication tag
%(hexidecimal). Outputs: ImageOut - decrypted uint8 matrix of original image,
%authTagResult - logical (true or false, true is tag is validated).
%
%David Hill
%Version 1.0.0
%Date: 22 February 2022
%
Size=size(outputCipher);
H=Cipher(secretKey,zeros(1,128));
t=96;%authentication tag bit-length (fixed for this code)
a=dec2bin(double(aad)',8)';
a=a(:)'-'0';%convert a to binary array
iv=dec2bin(hex2dec(reshape(iv,2,[])'),8)';
iv=iv(:)'-'0';%convert iv to binary array
C=dec2bin(outputCipher(:))';
C=C(:)'-'0';%convert C to binary array
T=dec2bin(hex2dec(reshape(authTag,2,[])'),8)';
T=T(:)'-'0';%convert T to binary array
J=[iv,zeros(1,31),1];
P=GCTR(secretKey,inc(32,J),C);
u=128*ceil(length(C)/128)-length(C);
v=128*ceil(length(a)/128)-length(a);
S=ghash([a,zeros(1,v),C,zeros(1,u),dec2bin(length(a),64)-'0',dec2bin(length(C),64)-'0'],H);
Tp=GCTR(secretKey,J,S);
Tp=Tp(1:t);
authTagResult=isequal(T,Tp);
P=num2str(P);
P=P(P~=' ');
ImageOut=reshape(uint8(bin2dec(reshape(P,8,[])')),Size);
imshow(ImageOut);