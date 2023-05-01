// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define the smart contract
contract ProductContract {
    // Define the product struct
    struct Product {
        uint256 productID;
        string temperature;
        string qualityAssurance;
        string packagingMaterial;
        string fssaiCode;
        string batchID;
        string handlingInstructions;
        bool verified;
    }

    // Define the mapping that will store the products
    mapping(uint256 => Product) products;

    // Define an event that will be emitted when a product is added
    event ProductAdded(uint256 productID);

    // Define a function to add a product to the mapping
    function addProduct(
        uint256 _productID,
        string memory _temperature,
        string memory _qualityAssurance,
        string memory _packagingMaterial,
        string memory _fssaiCode,
        string memory _batchID,
        string memory _handlingInstructions
    ) public {
        Product memory newProduct = Product({
            productID: _productID,
            temperature: _temperature,
            qualityAssurance: _qualityAssurance,
            packagingMaterial: _packagingMaterial,
            fssaiCode: _fssaiCode,
            batchID: _batchID,
            handlingInstructions: _handlingInstructions,
            verified: false
        });
        products[_productID] = newProduct;
        emit ProductAdded(_productID);
    }

    // Define a function to verify a product
    function verifyProduct(uint256 _productID) public {
        products[_productID].verified = true;
    }

    // Define a function to get the details of a product
    function getProductDetails(
        uint256 _productID
    )
        public
        view
        returns (
            string memory temperature,
            string memory qualityAssurance,
            string memory packagingMaterial,
            string memory fssaiCode,
            string memory batchID,
            string memory handlingInstructions,
            bool verified
        )
    {
        Product memory currentProduct = products[_productID];
        temperature = currentProduct.temperature;
        qualityAssurance = currentProduct.qualityAssurance;
        packagingMaterial = currentProduct.packagingMaterial;
        fssaiCode = currentProduct.fssaiCode;
        batchID = currentProduct.batchID;
        handlingInstructions = currentProduct.handlingInstructions;
        verified = currentProduct.verified;
    }
}
