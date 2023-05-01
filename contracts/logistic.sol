// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract SupplyChain {
    event Added(uint256 index);

    struct State {
        string description;
        address person;
    }

    struct Product {
        address creator;
        string productName;
        uint256 productId;
        string date;
        uint256 totalStates;
        uint256[] positions;
    }

    mapping(uint => Product) allProducts;
    mapping(uint => mapping(uint => State)) productStates;
    uint256 items = 0;

    function concat(
        string memory _a,
        string memory _b
    ) public returns (string memory) {
        bytes memory bytes_a = bytes(_a);
        bytes memory bytes_b = bytes(_b);
        string memory length_ab = new string(bytes_a.length + bytes_b.length);
        bytes memory bytes_c = bytes(length_ab);
        uint k = 0;
        for (uint i = 0; i < bytes_a.length; i++) bytes_c[k++] = bytes_a[i];
        for (uint i = 0; i < bytes_b.length; i++) bytes_c[k++] = bytes_b[i];
        return string(bytes_c);
    }

    function newItem(
        string memory _text,
        string memory _date
    ) public returns (bool) {
        Product memory newItem = Product({
            creator: msg.sender,
            totalStates: 0,
            productName: _text,
            productId: items,
            date: _date,
            positions: new uint256[](0)
        });

        allProducts[items] = newItem;
        items = items + 1;

        emit Added(items - 1);

        return true;
    }

    function addState(
        uint _productId,
        string memory info
    ) public returns (string memory) {
        require(_productId < items);

        uint256 stateId = allProducts[_productId].totalStates;
        productStates[_productId][stateId] = State({
            person: msg.sender,
            description: info
        });

        allProducts[_productId].positions.push(stateId);
        allProducts[_productId].totalStates =
            allProducts[_productId].totalStates +
            1;
        return info;
    }

    function searchProduct(uint _productId) public returns (string memory) {
        require(_productId < items);
        string memory output = "Product Name: ";
        output = concat(output, allProducts[_productId].productName);
        output = concat(output, "<br>Manufacture Date: ");
        output = concat(output, allProducts[_productId].date);

        uint256[] memory states = allProducts[_productId].positions;
        for (uint256 j = 0; j < states.length; j++) {
            uint256 stateId = states[j];
            output = concat(
                output,
                productStates[_productId][stateId].description
            );
        }
        return output;
    }
}
