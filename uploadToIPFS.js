const pinataSDK = require('@pinata/sdk');
let fs = require("fs");

const pinata = new pinataSDK({ pinataApiKey: '', pinataSecretApiKey: '' });

const filePath = `${__dirname}/logo.png`;
fs.readFile(filePath, (error, file) => {
    if (error) {
      console.log(error);
      return;
    }
    const readableStreamForFile = fs.createReadStream('./logo.png');
  const options = {
      pinataMetadata: {
          name: 'works',
          keyvalues: {
              customKey: '113',
              customKey2: '222'
          }
      },
      pinataOptions: {
          cidVersion: 0
      }
  };
  
    pinata.pinFileToIPFS(readableStreamForFile, options).then(response => {
        console.log(response.IpfsHash);
      }).catch(error => {
        console.log(error);
      });
  });
  