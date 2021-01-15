const Migrations = artifacts.require("Migrations");
const Storedata = artifacts.require("Storedata");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Storedata);
};
