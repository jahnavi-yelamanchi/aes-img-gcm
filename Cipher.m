function Out = Cipher(key,In)
%AES-128,192,256 cipher
%Impliments FIBS-197, key is a 128, 292, or 256-bit hexidecimal input, 
%message (In) is 128-bit binary array. Application does not check lengths of
%keys or message input but will error if they are not of the correct
%length. Output, Out is binary array.

Nk=length(key)/8;
In=num2str(In);
In=bin2dec(reshape(In(In~=' '),8,[])');
w=KeyExpansion(key,Nk);%key expansion per standard
state=reshape(In,4,[]);%reshapes input into state matrix
state=AddRoundKey(state,w(:,1:4));%conducts first round
for k=2:(Nk+6)%conducts follow-on rounds
    state=SubBytes(state);%per standard
    state=ShiftRows(state);%per standard
    state=MixColumns(state);%per standard
    state=AddRoundKey(state,w(:,4*(k-1)+1:4*k));%per standard
end
state=SubBytes(state);
state=ShiftRows(state);
state=AddRoundKey(state,w(:,4*(Nk+6)+1:4*(Nk+7)));
Out=state(:);%changes output to column vector
Out=dec2bin(Out(1:length(In)),8)'-'0';
Out=Out(:)';%converts output to row vector
end