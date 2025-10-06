import React, { useState, useEffect } from 'react';
import ItemList from './components/ItemList';
import ItemForm from './components/ItemForm';
import ApiService from './services/api';
import './App.css';

function App() {
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [showForm, setShowForm] = useState(false);

  // Load items on component mount
  useEffect(() => {
    loadItems();
  }, []);

  const loadItems = async () => {
    try {
      setLoading(true);
      setError(null);
      const data = await ApiService.getAllItems();
      setItems(data);
    } catch (err) {
      setError('Failed to load items. Please check if the Spring service is running.');
      console.error('Error loading items:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleCreateItem = async (itemData) => {
    try {
      const newItem = await ApiService.createItem(itemData);
      setItems(prev => [...prev, newItem]);
      setShowForm(false);
    } catch (err) {
      setError('Failed to create item');
      console.error('Error creating item:', err);
    }
  };

  const handleUpdateItem = async (id, itemData) => {
    try {
      const updatedItem = await ApiService.updateItem(id, itemData);
      setItems(prev => prev.map(item => 
        item.id === id ? updatedItem : item
      ));
    } catch (err) {
      setError('Failed to update item');
      console.error('Error updating item:', err);
    }
  };

  const handleDeleteItem = async (id) => {
    if (!window.confirm('Are you sure you want to delete this item?')) {
      return;
    }

    try {
      await ApiService.deleteItem(id);
      setItems(prev => prev.filter(item => item.id !== id));
    } catch (err) {
      setError('Failed to delete item');
      console.error('Error deleting item:', err);
    }
  };

  if (loading) {
    return (
      <div className="App">
        <div className="loading">
          <h2>Loading items...</h2>
        </div>
      </div>
    );
  }

  return (
    <div className="App">
      <header className="App-header">
        <h1>Item Management System</h1>
        <p>Full-stack application with React frontend and Spring Boot backend</p>
      </header>

      <main className="App-main">
        {error && (
          <div className="error-message">
            <p>{error}</p>
            <button onClick={loadItems} className="btn btn-secondary">
              Retry
            </button>
          </div>
        )}

        <div className="actions">
          <button 
            onClick={() => setShowForm(!showForm)} 
            className="btn btn-primary"
          >
            {showForm ? 'Cancel' : 'Add New Item'}
          </button>
          <button onClick={loadItems} className="btn btn-secondary">
            Refresh
          </button>
        </div>

        {showForm && (
          <ItemForm
            onSubmit={handleCreateItem}
            onCancel={() => setShowForm(false)}
          />
        )}

        <ItemList
          items={items}
          onEdit={handleUpdateItem}
          onDelete={handleDeleteItem}
        />
      </main>
    </div>
  );
}

export default App;
