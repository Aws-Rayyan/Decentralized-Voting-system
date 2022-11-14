 var vote = artifacts.require("Dvoting");

 module.exports = function(deployer) {
   // deployment steps
   deployer.deploy(vote,30);
 };