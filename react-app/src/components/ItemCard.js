import React, { useState } from 'react';

const ItemCard = ({ item, onEdit, onDelete }) => {
  const [isEditing, setIsEditing] = useState(false);
  const [editForm, setEditForm] = useState({
    name: item.name,
    description: item.description
  });

  const handleEdit = () => {
    setIsEditing(true);
  };

  const handleSave = () => {
    onEdit(item.id, editForm);
    setIsEditing(false);
  };

  const handleCancel = () => {
    setEditForm({
      name: item.name,
      description: item.description
    });
    setIsEditing(false);
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setEditForm(prev => ({
      ...prev,
      [name]: value
    }));
  };

  if (isEditing) {
    return (
      <div className="item-card editing">
        <div className="item-form">
          <input
            type="text"
            name="name"
            value={editForm.name}
            onChange={handleInputChange}
            placeholder="Item name"
            className="form-input"
          />
          <textarea
            name="description"
            value={editForm.description}
            onChange={handleInputChange}
            placeholder="Item description"
            className="form-textarea"
            rows="3"
          />
          <div className="form-actions">
            <button onClick={handleSave} className="btn btn-primary">
              Save
            </button>
            <button onClick={handleCancel} className="btn btn-secondary">
              Cancel
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="item-card">
      <div className="item-header">
        <h3 className="item-title">{item.name}</h3>
        <div className="item-actions">
          <button onClick={handleEdit} className="btn btn-small btn-primary">
            Edit
          </button>
          <button onClick={() => onDelete(item.id)} className="btn btn-small btn-danger">
            Delete
          </button>
        </div>
      </div>
      <p className="item-description">{item.description}</p>
      <div className="item-meta">
        <span className="item-id">ID: {item.id}</span>
      </div>
    </div>
  );
};

export default ItemCard;

