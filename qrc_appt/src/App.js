
import './App.css';
import Navbar from './components/Navbar'
import Sidebar from './components/Sidebar'
import Mainframe from './components/Mainframe'

function App() {
  return (
    <>
   
    <Navbar />
    <div className="mainContent">
  
       <Sidebar />
       <Mainframe />
       <Sidebar />
    </div>
  

    </>
  );
}

export default App;
