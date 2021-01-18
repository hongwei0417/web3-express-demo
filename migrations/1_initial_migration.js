const Migrations = artifacts.require("Migrations");
const Storedata = artifacts.require("Storedata");
const UserManagement = artifacts.require("UserManagement");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Storedata);
  deployer.deploy(UserManagement);
};
