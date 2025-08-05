import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext'; // Importa o hook customizado

// Formulário de Cardápio (mantido aqui por enquanto)
const CardapioForm = ({ cardapio, restaurantes, onSave, onCancel }) => {
  const [formData, setFormData] = useState({
    ...cardapio,
    restauranteId: cardapio.restaurante ? cardapio.restaurante.cdRest : ''
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const selectedRestaurante = restaurantes.find(r => r.cdRest === parseInt(formData.restauranteId));
    onSave({
      ...formData,
      restaurante: selectedRestaurante // Conecta o objeto completo do restaurante
    });
  };

  return (
    <div className="mt-6 p-6 border border-gray-200 rounded-lg bg-gray-50">
      <h4 className="text-xl font-medium text-gray-800 mb-4">{cardapio.cdCardapio ? 'Editar Cardápio' : 'Novo Cardápio'}</h4>
      <form onSubmit={handleSubmit} className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <label className="block">
          <span className="text-gray-700">Data do Cardápio:</span>
          <input type="date" name="dtCardapio" value={formData.dtCardapio || ''} onChange={handleChange} required className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Restaurante:</span>
          <select
            name="restauranteId"
            value={formData.restauranteId}
            onChange={handleChange}
            required
            className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50"
          >
            <option value="">Selecione um restaurante</option>
            {restaurantes.map(r => (
              <option key={r.cdRest} value={r.cdRest}>
                {r.nome}
              </option>
            ))}
          </select>
        </label>
        <div className="col-span-full flex justify-end space-x-3 mt-4">
          <button type="button" onClick={onCancel} className="bg-gray-400 text-white px-4 py-2 rounded-md hover:bg-gray-500 transition duration-150">
            Cancelar
          </button>
          <button type="submit" className="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 transition duration-150">
            Salvar
          </button>
        </div>
      </form>
    </div>
  );
};

// Lista de Cardápios (mantida aqui por enquanto)
const CardapioList = ({ cardapios, onEdit, onDelete }) => {
  return (
    <div className="mt-6">
      <h4 className="text-xl font-medium text-gray-800 mb-4">Lista de Cardápios</h4>
      {cardapios.length === 0 ? (
        <p className="text-gray-600">Nenhum cardápio cadastrado.</p>
      ) : (
        <div className="overflow-x-auto">
          <table className="min-w-full bg-white border border-gray-200 rounded-lg">
            <thead className="bg-gray-100">
              <tr>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">ID</th>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">Data</th>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">Restaurante</th>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">Ações</th>
              </tr>
            </thead>
            <tbody>
              {cardapios.map((cardapio) => (
                <tr key={cardapio.cdCardapio} className="hover:bg-gray-50">
                  <td className="py-2 px-4 border-b text-sm text-gray-800">{cardapio.cdCardapio}</td>
                  <td className="py-2 px-4 border-b text-sm text-gray-800">{cardapio.dtCardapio}</td>
                  <td className="py-2 px-4 border-b text-sm text-gray-800">{cardapio.restaurante?.nome}</td>
                  <td className="py-2 px-4 border-b text-sm">
                    <button onClick={() => onEdit(cardapio)} className="text-blue-600 hover:text-blue-800 transition duration-150 mr-2">
                      Editar
                    </button>
                    <button onClick={() => onDelete(cardapio.cdCardapio)} className="text-red-600 hover:text-red-800 transition duration-150">
                      Excluir
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
};

// Componente de Gerenciamento de Cardápios
const CardapioManagement = () => {
  const [cardapios, setCardapios] = useState([]);
  const [restaurantes, setRestaurantes] = useState([]); // Para seleção no formulário
  const [editingCardapio, setEditingCardapio] = useState(null);
  const { user } = useAuth();

  useEffect(() => {
    fetchCardapios();
    fetchRestaurantesForSelection();
  }, []);

  const fetchCardapios = async () => {
    // Simulação de chamada API
    setCardapios([
      { cdCardapio: 1, dtCardapio: '2025-07-22', restaurante: { cdRest: 1, nome: 'Restaurante Central' } },
      { cdCardapio: 2, dtCardapio: '2025-07-23', restaurante: { cdRest: 2, nome: 'Restaurante Norte' } },
    ]);
  };

  const fetchRestaurantesForSelection = async () => {
    // Simulação de chamada API (apenas para obter IDs e Nomes)
    // const response = await fetch('/restaurantes');
    // const data = await response.json();
    // setRestaurantes(data.map(r => ({ cdRest: r.cdRest, nome: r.nome })));
    setRestaurantes([
      { cdRest: 1, nome: 'Restaurante Central' },
      { cdRest: 2, nome: 'Restaurante Norte' },
    ]);
  };

  const handleSaveCardapio = async (cardapio) => {
    // Simulação de chamada API
    if (cardapio.cdCardapio) {
      setCardapios(cardapios.map(c => c.cdCardapio === cardapio.cdCardapio ? cardapio : c));
    } else {
      setCardapios([...cardapios, { ...cardapio, cdCardapio: Math.max(...cardapios.map(c => c.cdCardapio), 0) + 1 }]);
    }
    setEditingCardapio(null);
  };

  const handleDeleteCardapio = async (id) => {
    // Simulação de chamada API
    setCardapios(cardapios.filter(c => c.cdCardapio !== id));
  };

  return (
    <div className="p-6 bg-white rounded-lg shadow-md">
      <h3 className="text-2xl font-semibold text-gray-800 mb-4">Gerenciar Cardápios</h3>
      <button
        onClick={() => setEditingCardapio({})}
        className="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition duration-150 mb-4"
      >
        Adicionar Novo Cardápio
      </button>

      {editingCardapio && (
        <CardapioForm cardapio={editingCardapio} restaurantes={restaurantes} onSave={handleSaveCardapio} onCancel={() => setEditingCardapio(null)} />
      )}

      <CardapioList
        cardapios={cardapios}
        onEdit={setEditingCardapio}
        onDelete={handleDeleteCardapio}
      />
    </div>
  );
};

export default CardapioManagement;