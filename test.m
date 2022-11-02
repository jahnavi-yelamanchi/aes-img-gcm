
secretKey='5b0efc93842eca9a89eb5d652018d5713d02a5881be9241be29b8e80c9db4a4e';
iv='6a75d6d0bc29918ffe1fc1c1';
%Encryption
[outputCipher,authTag]=ImageEncryption(secretKey,iv,'AES_image.jpg','AES image');
%Decryption
[ImageOut,authTagResult]=ImageDecryption(secretKey,iv,outputCipher,'AES image',authTag);