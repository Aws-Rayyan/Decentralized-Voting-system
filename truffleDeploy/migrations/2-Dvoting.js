 var vote = artifacts.require("Dvoting");

 module.exports = function(deployer) {
   // deployment steps
   deployer.deploy(vote,30,["Aws Rayyan","Mahmoud Atari","Aws Al-Masri"]);
 };