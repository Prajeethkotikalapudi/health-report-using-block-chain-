// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract HealthReports {
    struct Reports {
        uint256 id;
        string name;
        string disease;
        string prescription;
        uint256 quantity;
               address owner;
    }

    mapping(uint256 => Reports) public report;
    mapping(address=>Reports) private reportowner;
    uint256 public reportsCount;

    event ReportsRegistered(uint256 id, string name,string disease,uint256 quantity);
    event ReportsUpdated(uint256 id, uint256 quantity);

    function addreports(string memory _name, string memory _disease,string memory _prescription,uint256 _quantity) public {
        reportsCount++;
        report[reportsCount] = Reports({
            id: reportsCount,
            name: _name,
            disease: _disease,
            prescription: _prescription,
            quantity: _quantity,
                    owner: msg.sender
        });

        emit ReportsRegistered(reportsCount, _name, _disease,_quantity);
        
    }

    function updateReportsQuantity(uint256 _id, uint256 _quantity) public {
        Reports storage reports = report[_id];
        require(reports.owner == msg.sender, "Only the owner can update the resource");
        require(_quantity >= 0, "Quantity cannot be negative");

        reports.quantity = _quantity;

        emit ReportsUpdated(_id, _quantity);
    }
    
    
 
    function getReports(uint256 _id) public view returns (string memory, string memory,string memory, uint256, address) {
        Reports memory reports = report[_id];
        return (reports.name, reports.disease, reports.prescription, reports.quantity, reports.owner);
    }
}