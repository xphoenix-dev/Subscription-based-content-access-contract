// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SubscriptionBasedContent {
    address public owner;
    uint256 public subscriptionPrice;
    uint256 public subscriptionDuration;

    struct Subscriber {
        bool isSubscribed;
        uint256 expiryTime;
    }

    mapping(address => Subscriber) public subscribers;

    event SubscriptionPurchased(address indexed subscriber, uint256 expiryTime);
    event SubscriptionRenewed(address indexed subscriber, uint256 newExpiryTime);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlySubscribed() {
        require(subscribers[msg.sender].isSubscribed, "You are not subscribed");
        require(block.timestamp < subscribers[msg.sender].expiryTime, "Subscription has expired");
        _;
    }

    constructor(uint256 _subscriptionPrice, uint256 _subscriptionDuration) {
        owner = msg.sender;
        subscriptionPrice = _subscriptionPrice;
        subscriptionDuration = _subscriptionDuration;
    }

    function purchaseSubscription() external payable {
        require(msg.value == subscriptionPrice, "Incorrect subscription fee");
        require(!subscribers[msg.sender].isSubscribed, "You are already subscribed");

        subscribers[msg.sender] = Subscriber({
            isSubscribed: true,
            expiryTime: block.timestamp + subscriptionDuration
        });

        emit SubscriptionPurchased(msg.sender, block.timestamp + subscriptionDuration);
    }

    function renewSubscription() external payable {
        require(msg.value == subscriptionPrice, "Incorrect subscription fee");
        require(subscribers[msg.sender].isSubscribed, "You are not subscribed");

        subscribers[msg.sender].expiryTime += subscriptionDuration;

        emit SubscriptionRenewed(msg.sender, subscribers[msg.sender].expiryTime);
    }

    function accessContent() external view onlySubscribed returns (string memory) {
        return "Here is your exclusive content!";
    }

    function changeSubscriptionPrice(uint256 _newPrice) external onlyOwner {
        subscriptionPrice = _newPrice;
    }

    function changeSubscriptionDuration(uint256 _newDuration) external onlyOwner {
        subscriptionDuration = _newDuration;
    }

    function withdrawFunds() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
