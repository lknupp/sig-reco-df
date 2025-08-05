// Este arquivo é um placeholder para suas futuras chamadas de API reais.
// Exemplo de como você poderia estruturar as chamadas:

const API_BASE_URL = 'http://localhost:8080'; // Substitua pela URL do seu backend Quarkus

const getHeaders = (token) => {
  const headers = {
    'Content-Type': 'application/json',
  };
  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }
  return headers;
};

export const fetchRestaurantes = async (token) => {
  const response = await fetch(`${API_BASE_URL}/restaurantes`, {
    headers: getHeaders(token),
  });
  if (!response.ok) {
    throw new Error('Falha ao buscar restaurantes');
  }
  return response.json();
};

export const saveRestaurante = async (restaurante, token) => {
  const method = restaurante.cdRest ? 'PUT' : 'POST';
  const url = restaurante.cdRest ? `${API_BASE_URL}/restaurantes/${restaurante.cdRest}` : `${API_BASE_URL}/restaurantes`;
  const response = await fetch(url, {
    method,
    headers: getHeaders(token),
    body: JSON.stringify(restaurante),
  });
  if (!response.ok) {
    throw new Error('Falha ao salvar restaurante');
  }
  return response.json();
};

export const deleteRestaurante = async (id, token) => {
  const response = await fetch(`${API_BASE_URL}/restaurantes/${id}`, {
    method: 'DELETE',
    headers: getHeaders(token),
  });
  if (!response.ok) {
    throw new Error('Falha ao excluir restaurante');
  }
  // Retorna true se a exclusão foi bem-sucedida (status 204 No Content)
  return response.status === 204;
};

// Adicione funções semelhantes para Cardapio e Alimento
// export const fetchCardapios = async (token) => { ... };
// export const saveCardapio = async (cardapio, token) => { ... };
// export const deleteCardapio = async (id, token) => { ... };

// export const fetchAlimentos = async (token) => { ... };
// export const saveAlimento = async (alimento, token) => { ... };
// export const deleteAlimento = async (id, token) => { ... };

// Exemplo para buscar tipos de alimento
// export const fetchTiposAlimento = async (token) => {
//   const response = await fetch(`${API_BASE_URL}/tipoalimentos`, {
//     headers: getHeaders(token),
//   });
//   if (!response.ok) {
//     throw new Error('Falha ao buscar tipos de alimento');
//   }
//   return response.json();
// };