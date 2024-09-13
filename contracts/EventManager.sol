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

    mapping (string => Event) events;
    mapping (string => address) eventNFTS;
    uint eventCount;

    // function generateNFT() internal returns (address ){

    // }
    event EventCreated(string title);

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
        require(events[_eventName], "Event does not exist");
        

         require(msg.sender != address(0), "Invalid input");
        Event storage _event = events[_eventId];
        
        require(_event.isCompleted == false, "Event completed");
        require(_event.endDate > block.timestamp, "Event duration has elapsed");
        require(!hasRegistered[msg.sender][_eventId], "Already Registered");
        require(IERC721(requiredNftAddress).balanceOf(msg.sender) > 0, "Must hold at least one NFT to register");

        _event.attendees += 1;
        hasRegistered[msg.sender][_eventId] = true;
        registeredAddresses[_eventId].push(msg.sender);
    }

    function checkUserRegistration(uint256 _eventId) external view returns (bool) {
        return hasRegistered[msg.sender][_eventId];
    }

    function getAttendees(uint256 _eventName) external view returns (address[] memory) {
        return events[_eventName];
        
    }
}