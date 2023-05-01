// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SeafoodSupplyChain {
    enum TransitState {
        Processing,
        InTransit,
        Delivered
    }

    struct Shipment {
        uint256 shipmentId;
        address processor;
        address distributor;
        address recipient;
        TransitState state;
        uint256 batchId;
    }

    struct ShipmentLocation {
        uint256 shipmentId;
        uint256 batchId;
        string location;
        uint256 date;
        uint256 timestamp;
    }

    mapping(uint256 => Shipment) public shipments;
    mapping(uint256 => ShipmentLocation[]) public shipmentLocations;

    function initiateShipment(
        uint256 _shipmentId,
        address _processor,
        address _distributor,
        address _recipient,
        uint256 _batchId
    ) public {
        shipments[_shipmentId] = Shipment({
            shipmentId: _shipmentId,
            processor: _processor,
            distributor: _distributor,
            recipient: _recipient,
            state: TransitState.Processing,
            batchId: _batchId
        });

        shipmentLocations[_shipmentId].push(
            ShipmentLocation({
                shipmentId: _shipmentId,
                batchId: _batchId,
                location: "Processor",
                date: block.timestamp,
                timestamp: block.timestamp
            })
        );
    }

    function updateShipmentLocation(
        uint256 _shipmentId,
        uint256 _batchId,
        string memory _location
    ) public {
        require(
            shipments[_shipmentId].shipmentId == _shipmentId,
            "Shipment does not exist"
        );
        shipmentLocations[_shipmentId].push(
            ShipmentLocation({
                shipmentId: _shipmentId,
                batchId: _batchId,
                location: _location,
                date: block.timestamp,
                timestamp: block.timestamp
            })
        );
    }

    // function getShipmentLocations(uint256 _batchId) public view returns (ShipmentLocation[] memory) {
    // return shipmentLocations[_batchId];

    function getShipmentLocations(
        uint256 _batchId
    ) public view returns (ShipmentLocation[] memory) {
        ShipmentLocation[] memory locations = shipmentLocations[_batchId];
        require(locations.length > 0, "No locations found for batch ID");

        ShipmentLocation[] memory result = new ShipmentLocation[](
            locations.length
        );
        for (uint i = 0; i < locations.length; i++) {
            result[i] = ShipmentLocation(
                locations[i].shipmentId,
                locations[i].batchId,
                locations[i].location,
                locations[i].date,
                locations[i].timestamp
            );
        }
        return result;
    }
}
// 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
