### Let the best take win

A bet between Balaji Srinivasan & James Medlock : https://twitter.com/balajis/status/1636797265317867520?s=20

To deploy the contract, the following information is needed

    James' Ethereum wallet address
    Balaji's Ethereum wallet address
    The custodian's Ethereum wallet address
    The Chainlink ETH/USD price feed contract address
    The WBTC (Wrapped Bitcoin) ERC20 token contract address

The contract addresses for the Chainlink ETH/USD price feed and WBTC on Ethereum mainnet here:

    Chainlink ETH/USD price feed: https://docs.chain.link/docs/ethereum-addresses/#Ethereum%20Mainnet
    WBTC (Wrapped Bitcoin) ERC20 token: https://etherscan.io/token/0x2260fac5e5542a773aa44fbcfedf7c193bc2c599
    
Features of the contract:

1. Chainlink price oracle to obtain the latest ETH price in USD
2. Ether (ETH) as collateral and use a price oracle to convert the USD amount into ETH at the time of deposit and withdrawal.
3. WBTC is an ERC20 token that is pegged 1:1 with Bitcoin for James to transfer
