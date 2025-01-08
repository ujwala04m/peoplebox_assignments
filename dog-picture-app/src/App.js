// src/App.js
import React, { useState } from 'react';
import DogBreedList from './components/DogBreedList';
import DogImageModal from './components/DogImageModal';
import './App.css';

const App = () => {
  const [selectedBreed, setSelectedBreed] = useState(null);

  const handleSelectBreed = (breed) => {
    setSelectedBreed(breed);
  };

  const handleCloseModal = () => {
    setSelectedBreed(null);
  };

  return (
    <div className="app-container">
      <h1 className="app-title">Dog Picture App</h1>
      <DogBreedList onSelectBreed={handleSelectBreed} />
      {selectedBreed && (
        <DogImageModal breed={selectedBreed} onClose={handleCloseModal} />
      )}
    </div>
  );
};

export default App;
