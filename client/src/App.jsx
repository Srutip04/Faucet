import { EthProvider } from "./contexts/EthContext";
import "./App.css";

function App() {
  return (
    <EthProvider>
      <div id="App" >
       Hello World 
      </div>
    </EthProvider>
  );
}

export default App;
