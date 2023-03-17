pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract HyperinflationBet {
    address public james;
    address public balaji;
    address public custodian;
    uint256 public betAmountUSD;
    uint256 public betAmountETH;
    uint256 public betTimestamp;
    uint256 public betDuration;
    IERC20 public wbtc;

    enum BetResult { NotDetermined, JamesWins, BalajiWins }
    BetResult public betResult;

    AggregatorV3Interface internal priceFeed;

    constructor(
        address _james,
        address _balaji,
        address _custodian,
        address _priceFeed,
        address _wbtc
    ) {
        james = _james;
        balaji = _balaji;
        custodian = _custodian;
        betAmountUSD = 1000000; // $1M USD
        betDuration = 90 days;
        betResult = BetResult.NotDetermined;
        priceFeed = AggregatorV3Interface(_priceFeed);
        wbtc = IERC20(_wbtc);
    }

    function buyBTC(uint256 amount) external {
        require(msg.sender == james, "Only James can buy BTC.");
        require(wbtc.transferFrom(james, address(this), amount), "Transfer failed.");
    }

    function deposit() external payable {
        require(msg.sender == balaji, "Only Balaji can deposit.");
        uint256 currentETHPrice = getLatestETHPrice();
        betAmountETH = (betAmountUSD * 1 ether) / currentETHPrice;
        require(msg.value == betAmountETH, "Incorrect deposit amount.");
        betTimestamp = block.timestamp;
    }

    function determineBetResult(bool jamesWins) external {
        require(msg.sender == custodian, "Only the custodian can determine the bet result.");
        require(block.timestamp >= betTimestamp + betDuration, "Bet duration has not elapsed.");
        require(betResult == BetResult.NotDetermined, "Bet result has already been determined.");

        if (jamesWins) {
            betResult = BetResult.JamesWins;
        } else {
            betResult = BetResult.BalajiWins;
        }
    }

    function withdraw() external {
        require(betResult != BetResult.NotDetermined, "Bet result has not been determined.");

        if (betResult == BetResult.JamesWins) {
            require(msg.sender == james, "Only James can withdraw.");
            payable(james).transfer(betAmountETH);
        } else {
            require(msg.sender == balaji, "Only Balaji can withdraw.");
            payable(balaji).transfer(betAmountETH);
        }
    }

    function getLatestETHPrice() public view returns (uint256) {
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price);
    }
}
