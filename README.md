# Subscription-Based Content Access Contract

This smart contract allows content creators to monetize their content by offering subscription-based access. Users can subscribe by paying a monthly fee to gain access to exclusive content.

## Features

- **Subscription Management:** Users can purchase and renew subscriptions to access content.
- **Content Access Control:** Only subscribed users can access the premium content.
- **Flexible Pricing:** The owner can change the subscription price and duration.
- **Funds Management:** The owner can withdraw the collected subscription fees.

## How to Use

### Installation

1. Deploy the contract using [Remix](https://remix.ethereum.org/) or [Truffle](https://www.trufflesuite.com/).
2. Set the initial subscription price and duration during the deployment.

### Usage

1. **Purchase Subscription:**
   - Call `purchaseSubscription()` with the required ETH amount to start the subscription.
2. **Renew Subscription:**
   - Call `renewSubscription()` before your current subscription expires to extend access.
3. **Access Content:**
   - Call `accessContent()` to view the premium content if you have an active subscription.
4. **Admin Functions:**
   - The owner can call `changeSubscriptionPrice()` and `changeSubscriptionDuration()` to update the pricing and duration of subscriptions.
   - Call `withdrawFunds()` to withdraw the collected subscription fees.

### Example

```solidity
SubscriptionBasedContent content = new SubscriptionBasedContent(1 ether, 30 days);
content.purchaseSubscription{value: 1 ether}();
content.accessContent(); // Returns the exclusive content
content.renewSubscription{value: 1 ether}(); // Renews the subscription
