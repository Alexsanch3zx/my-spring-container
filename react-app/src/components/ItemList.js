import React from 'react';
import ItemCard from './ItemCard';

const ItemList = ({ items, onEdit, onDelete }) => {
  if (!items || items.length === 0) {
    return (
      <div className="item-list-empty">
        <p>No items found. Add your first item to get started!</p>
      </div>
    );
  }

  return (
    <div className="item-list">
      <h2>Items ({items.length})</h2>
      <div className="item-grid">
        {items.map(item => (
          <ItemCard
            key={item.id}
            item={item}
            onEdit={onEdit}
            onDelete={onDelete}
          />
        ))}
      </div>
    </div>
  );
};

export default ItemList;

