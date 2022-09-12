import { EthProvider } from "./contexts/EthContext";
import "./App.css";
import Web3 from "web3";
import detectEthereumProvider from "@metamask/detect-provider";
import { useEffect, useState } from "react";
import { loadContract } from "./utils/load-contract";

function App() {
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null,
    contract: null
  });

   const [account, setAccount] = useState(null);

  useEffect(() => {
    const web3Provider = async () => {
      const  provider = await detectEthereumProvider();
      const contract = await loadContract("Faucet");

      if(provider){
         provider.request({ method: "eth_requestAccounts" });
         setWeb3Api({
           web3: new Web3(provider),
           provider,
            contract
         });
      }else{
        console.error("Please install MetaMask!");
      }
    
    };

    web3Provider();
  }, []);
 
  useEffect(()=>{
    const getAccount = async () =>{
      const accounts = await web3Api.web3.eth.getAccounts();
      // console.log(accounts);
      setAccount(accounts[0]);
    }

    web3Api.web3 && getAccount();
  },[web3Api.web3])

  return (
    <EthProvider>
      <>
        <div className="faucet-wrapper">
          <div className="faucet">
            <div className="is-flex is-align-items-center">
              <span>
                <strong className="mr-2">Account: </strong>
              </span>
              {account ? (
                <div>{account}</div>
              ) : (
                <button
                  className="button is-small"
                  onClick={() =>
                    web3Api.provider.request({ method: "eth_requestAccounts" })
                  }
                >
                  Connect Wallet
                </button>
              )}
            </div>
            <div className="balance-view is-size-2 my-4">
              Current Balance: <strong>10</strong> ETH
            </div>
            <button className="button is-link mr-2">Donate</button>
            <button className="button is-primary">Withdraw</button>
          </div>
        </div>
      </>
    </EthProvider>
  );
}

export default App;
