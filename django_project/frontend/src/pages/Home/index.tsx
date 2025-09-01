import React from 'react';

import './style.scss';

function Home() {

  const buttonClicked = () => {
    throw new Error('error!')
  }

  return (
    <div className="App">
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
