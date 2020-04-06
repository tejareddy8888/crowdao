//const Web3 = require('web3')
const rpcURL = 'http://127.0.0.1:7545'
if(typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
  }
else{
  // Set the Web3 provider
   web3 = new Web3(new Web3.providers.HttpProvider(rpcURL));
   //console.log("Connection extablished");
  }

const abi = [{"constant":false,"inputs":[{"name":"recipient","type":"address"},{"name":"value","type":"uint256"}],"name":"deposit","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"to","type":"address"},{"name":"value","type":"uint256"}],"name":"transfer","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"constant":true,"inputs":[{"name":"addr","type":"address"}],"name":"balance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"}]
const address = "0xa815AF62Ca0e16C26DB9B3ba5DA82893929F2d61"


var Contract_ABI = new web3.eth.Contract(abi,address)
console.log("entered the js")


async function run() {

    
let result

const account1 = document.getElementById('maddr').value
const account2 = document.getElementById('taddr').value
const amount = document.getElementById('amt').value
const tamount = document.getElementById('tamt').value


console.log("amount   =" +amount )

await Contract_ABI.methods.deposit(account1,amount).send({from: account1})
console.log("deposited amount   =" +amount+"in this address "+ account1)
await Contract_ABI.methods.transfer(account2,tamount).send({from: account1})
console.log("Transfered amount   =" +amount+"from  address"+ account1 + "to address"+account2 )
result = await Contract_ABI.methods.balance(account1).call()
console.log(result)

}

