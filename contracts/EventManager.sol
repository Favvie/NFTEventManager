// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";


// nft - 0x5FbDB2315678afecb367f032d93F642f64180aa3

contract EventManager {
    address owner;

    struct Event {
        string title;
        address NFTAddress;
        uint startDate;
        uint maxAttendees;
        address[] attendees;

    }
    mapping(address => bool) public isRegistered;

    mapping (string => Event) events;
    mapping (string => address) eventNFTS;
    uint eventCount;

    event EventCreated(string title);
    event Registered(address user);

    function createEvent(string memory _title, address _NFTaddress, uint _startDate ) external {
        require(msg.sender != address(0), "Address Zero Detected");
        require(bytes(_title).length > 0, "Add event name");
        require(_startDate > block.timestamp, "Event has already started");

        eventCount++;
        Event memory eventItem;
        eventItem.title = _title;
        eventItem.attendees;
        eventItem.startDate = block.timestamp + (_startDate * 3 days);

        eventItem.NFTAddress = _NFTaddress;
        eventNFTS[_title] = eventItem.NFTAddress;

        emit EventCreated(_title);

    }


    function registerEvent(string memory _eventName) external {
        Event storage _event = events[_eventName];
         require(msg.sender != address(0), "Address Zero Detected");
        require(!isRegistered[msg.sender], "Already Registered");
        require(IERC721(_event.NFTAddress).balanceOf(msg.sender) > 0, "NFT not missing");

        _event.attendees.push(msg.sender);
        isRegistered[msg.sender] = true;

    }

    function checkUserRegistration() external view returns (bool) {
        return isRegistered[msg.sender];
    }

    function getAttendees(string memory _eventName) external view returns (address[] memory) {
        return events[_eventName].attendees;
        
    }
}