const pinataSDK = require('@pinata/sdk');


const pinata = new pinataSDK({ pinataApiKey: '000', pinataSecretApiKey: '000' });



const text = { message: "Hello, IPFS!" };
pinata.pinJSONToIPFS(text).then(response => {
    console.log(response.IpfsHash);
}).catch(error => {
    console.log(error);
});