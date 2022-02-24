const QRCode = require('easyqrcodejs-nodejs');
const { faker } = require('@faker-js/faker');
var glob = require("glob")
const fs = require('fs');
const { create  } = require('ipfs-http-client')

let rawdata = fs.readFileSync('data.json');
let parsed_data = JSON.parse(rawdata);

const ipfsClient = create('https://ipfs.infura.io:5001/api/v0')

const upload = async (file) => {
    const added = await ipfsClient.add(file)
    console.log(`https://ipfs.infura.io/ipfs/${added.path}`)
}


const sendFilesToIPFS =  async () => {

     glob("*png",   function (er, files) {
        if (!er ) {
            files.forEach( async file => {

                let testFile = await fs.readFileSync(file)
                let testBuffer = new Buffer(testFile);
                await upload(testBuffer)
            }
            )
        }
      })
    

}










const generateQrcPng = async () => {

const new_data = await Promise.all(parsed_data.data.map( async (record) => {
    let dr =  await `Dr. ${faker.name.findName()}`
    let date =  await record

    let newItem = { doctor: dr, date: date }
    return newItem

}))

 writeToDisc(new_data)

}

const writeToDisc =  (arr) => {

    arr.forEach( async (data, index) => {
        
        var options = { text: JSON.stringify(data)  };              
        var qrcode = new QRCode(options);              
        await qrcode.saveImage({ path: `appt_${index}.png`  });   
       
        
        })    

}


// generateQrcPng()
sendFilesToIPFS()





