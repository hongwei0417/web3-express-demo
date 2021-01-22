pragma solidity >=0.4.22 <0.9.0;
import "./UserManage.sol";

//儲存交易者資料
contract StockManagement {
    
    UserManagement UM; //global
    // string _name;//哪位使用者
    
    constructor(address um_addr) public {
        UserManagement um = UserManagement(um_addr); //get contract
        UM = um;
    }
    
    mapping(string => mapping(string => stockTxn)) public stock;
    struct stockTxn{
        string stock_Name;      //公司名稱
        uint stock_NowPrice;    //股票價格
        uint stock_Number;      //股票數量
    }
    
    //儲存股票資料
    function setStockId(string memory account, string memory stockId, string memory stock_Name, uint stock_NowPrice, uint stock_Number) public{
        if(UM.userIsExist(account)) {
            stock[account][stockId] = stockTxn(stock_Name, stock_NowPrice, stock_Number); 
        }
    }

    function getStockId(string memory account, string memory stockId) public view returns(string memory, string memory, uint, uint){
        stockTxn memory t = stock[account][stockId]; //txn mapping
        return (t.stock_Name, stockId, t.stock_NowPrice, t.stock_Number);
    }
    
    //處理交易資料
    function tradeStock(string memory account, string memory stockId, string memory stock_Name, uint stock_NowPrice, uint stock_Number) public{
        if(UM.userIsExist(account)) {
            stock[account][stockId] = stockTxn(stock_Name, stock_NowPrice, stock_Number); 
            uint expenseStock = stock_NowPrice * stock_Number * 1000;       //數量*價格 = 花費金額(傳入)
            (uint cash, uint value) = UM.getUserMoney(account);             //拿到UserManage的cash跟value
            cash = cash - expenseStock;     //買股票完後金額
            UM.updateUserMoney(account, cash, value);
        }

        //(如果持有金額 < 花費金額 => 交易失敗)
        //購買價格
        //購買股票代號、企業名稱、股票數量
    }
}