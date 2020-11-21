pragma solidity >=0.4.22 <0.8.0;

contract App {
    mapping(string => string) private items;

    function getItem(string memory key) public view returns (string memory) {
        return items[key];
    }

    function addItem(string memory key, string memory value) public {
        items[key] = value;
    }

    function updateItem(string memory key, string memory value) public {
        items[key] = value;
    }

    function deleteItem(string memory key) public {
        delete items[key];
    }
}
