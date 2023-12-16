import React from 'react';
import './styles/App.scss';
import Navbar from "./components/NavBar";

function Home() {

  const buttonClicked = () => {
    throw new Error('error!')
  }

  return (
    <div className="App">
      <Navbar />
      <div className="AppContent">
        <p>
          Welcome to Kartoza Django React Base
        </p>
        <div
          className="App-link"
          onClick={buttonClicked}
        >
          Error Test
        </div>
      </div>
    </div>
  );
}

export default Home;
