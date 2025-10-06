import React, { useState } from 'react';

const ItemForm = ({ onSubmit, onCancel, initialData = null }) => {
  const [formData, setFormData] = useState({
    name: initialData?.name || '',
    description: initialData?.description || ''
  });

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (formData.name.trim() && formData.description.trim()) {
      onSubmit(formData);
      setFormData({ name: '', description: '' });
    }
  };

  const handleCancel = () => {
    setFormData({ name: '', description: '' });
    if (onCancel) {
      onCancel();
    }
  };

  return (
    <div className="item-form-container">
      <form onSubmit={handleSubmit} className="item-form">
        <h3>{initialData ? 'Edit Item' : 'Add New Item'}</h3>
        
        <div className="form-group">
          <label htmlFor="name">Name:</label>
          <input
            type="text"
            id="name"
            name="name"
            value={formData.name}
            onChange={handleInputChange}
            placeholder="Enter item name"
            className="form-input"
            required
          />
        </div>

        <div className="form-group">
          <label htmlFor="description">Description:</label>
          <textarea
            id="description"
            name="description"
            value={formData.description}
            onChange={handleInputChange}
            placeholder="Enter item description"
            className="form-textarea"
            rows="3"
            required
          />
        </div>

        <div className="form-actions">
          <button type="submit" className="btn btn-primary">
            {initialData ? 'Update Item' : 'Add Item'}
          </button>
          <button type="button" onClick={handleCancel} className="btn btn-secondary">
            Cancel
          </button>
        </div>
      </form>
    </div>
  );
};

export default ItemForm;

