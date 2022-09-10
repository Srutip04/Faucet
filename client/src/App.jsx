import { EthProvider } from "./contexts/EthContext";
import "./App.css";
import Web3 from "web3";
import { useEffect, useState } from "react";

function App() {
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null,
  });

  useEffect(() => {
    const web3Provider = async () => {
      let provider = null;
      if (window.ethereum) {
        provider = window.ethereum;
        try {
          await provider.enable();
        } catch {
          console.error("User denied access");
        }
      } else if (window.web3) {
        provider = window.web3.currentProvider;
      } else if (!process.env.production) {
        provider = new Web3.providers.HttpProvider("http://localhost:7545");
      }

      setWeb3Api({
        web3: new Web3(provider),
        provider,
      });
    };

    web3Provider();
  }, []);
  console.log(web3Api.web3);

  return (
    <EthProvider>
      <>
        <div className="faucet-wrapper">
          <div className="faucet">
            <div className="balance-view is-size-2">
              Current Balance: <strong>10</strong> ETH
            </div>
            <button className="btn mr-2">Donate</button>
            <button className="btn">Withdraw</button>
          </div>
        </div>
      </>
    </EthProvider>
  );
}

export default App;
