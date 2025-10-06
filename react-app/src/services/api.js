// API service for communicating with Spring Boot microservice
const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080';

class ApiService {
  async request(endpoint, options = {}) {
    const url = `${API_BASE_URL}${endpoint}`;
    const config = {
      headers: {
        'Content-Type': 'application/json',
        ...options.headers,
      },
      ...options,
    };

    try {
      const response = await fetch(url, config);
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      // Handle 204 No Content responses (like DELETE)
      if (response.status === 204) {
        return null;
      }
      
      return await response.json();
    } catch (error) {
      console.error('API request failed:', error);
      throw error;
    }
  }

  // GET /api/items - Get all items
  async getAllItems() {
    return this.request('/api/items');
  }

  // GET /api/items/{id} - Get item by ID
  async getItem(id) {
    return this.request(`/api/items/${id}`);
  }

  // POST /api/items - Create new item
  async createItem(item) {
    return this.request('/api/items', {
      method: 'POST',
      body: JSON.stringify(item),
    });
  }

  // PUT /api/items/{id} - Update item
  async updateItem(id, item) {
    return this.request(`/api/items/${id}`, {
      method: 'PUT',
      body: JSON.stringify(item),
    });
  }

  // DELETE /api/items/{id} - Delete item
  async deleteItem(id) {
    return this.request(`/api/items/${id}`, {
      method: 'DELETE',
    });
  }
}

const apiService = new ApiService();
export default apiService;
