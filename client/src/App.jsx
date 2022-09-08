import { EthProvider } from "./contexts/EthContext";
import "./App.css";
import { useEffect } from "react";

function App() {
  
  useEffect(()=>{
    const web3Provider = async () =>{
      console.log(window.web3);
      console.log(window.ethereum);
      // const web3 = new Web3(window.ethereum);
      // await window.ethereum.enable();
      // const accounts = await web3.eth.getAccounts();
      // console.log(accounts);
    }

    web3Provider();
  },[])

  return (
    <EthProvider>
      <>
        <div className="faucet-wrapper">
          <div className="faucet">
            <div className="balance-view is-size-2">
              Current Balance: <strong>10</strong> ETH
            </div>
            <button
              className="btn mr-2"
              onClick={async () => {
                const accounts = await window.ethereum.request({
                  method: "eth_requestAccounts",
                });
                console.log(accounts);
              }}
            >
              Enable Ethereum
            </button>
            <button className="btn mr-2">Donate</button>
            <button className="btn">Withdraw</button>
          </div>
        </div>
      </>
    </EthProvider>
  );
}

export default App;
