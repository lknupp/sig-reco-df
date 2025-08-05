import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext'; // Importa o hook customizado

// Formulário de Restaurante (mantido aqui por enquanto, pode ser movido para components/forms se houver muitos formulários complexos)
const RestauranteForm = ({ restaurante, onSave, onCancel }) => {
  const [formData, setFormData] = useState(restaurante);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSave(formData);
  };

  return (
    <div className="mt-6 p-6 border border-gray-200 rounded-lg bg-gray-50">
      <h4 className="text-xl font-medium text-gray-800 mb-4">{restaurante.cdRest ? 'Editar Restaurante' : 'Novo Restaurante'}</h4>
      <form onSubmit={handleSubmit} className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <label className="block">
          <span className="text-gray-700">Nome:</span>
          <input type="text" name="nome" value={formData.nome || ''} onChange={handleChange} required className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Latitude:</span>
          <input type="number" step="any" name="latitude" value={formData.latitude || ''} onChange={handleChange} required className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Longitude:</span>
          <input type="number" step="any" name="longitude" value={formData.longitude || ''} onChange={handleChange} required className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Hora Abertura:</span>
          <input type="time" name="hrAber" value={formData.hrAber || ''} onChange={handleChange} required className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Hora Fechamento:</span>
          <input type="time" name="hrFech" value={formData.hrFech || ''} onChange={handleChange} required className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Logradouro:</span>
          <input type="text" name="logradouro" value={formData.logradouro || ''} onChange={handleChange} required className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Número:</span>
          <input type="number" name="numero" value={formData.numero || ''} onChange={handleChange} className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Complemento:</span>
          <input type="text" name="complemento" value={formData.complemento || ''} onChange={handleChange} className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Bairro:</span>
          <input type="text" name="bairro" value={formData.bairro || ''} onChange={handleChange} required className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">CEP:</span>
          <input type="text" name="cep" value={formData.cep || ''} onChange={handleChange} className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Cidade:</span>
          <input type="text" name="cidade" value={formData.cidade || ''} onChange={handleChange} required className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Estado (UF):</span>
          <input type="text" name="sgEstado" value={formData.sgEstado || ''} onChange={handleChange} required maxLength="2" className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
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

// Lista de Restaurantes (mantida aqui por enquanto)
const RestauranteList = ({ restaurantes, onEdit, onDelete }) => {
  return (
    <div className="mt-6">
      <h4 className="text-xl font-medium text-gray-800 mb-4">Lista de Restaurantes</h4>
      {restaurantes.length === 0 ? (
        <p className="text-gray-600">Nenhum restaurante cadastrado.</p>
      ) : (
        <div className="overflow-x-auto">
          <table className="min-w-full bg-white border border-gray-200 rounded-lg">
            <thead className="bg-gray-100">
              <tr>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">ID</th>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">Nome</th>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">Cidade/Estado</th>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">Horário</th>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">Ações</th>
              </tr>
            </thead>
            <tbody>
              {restaurantes.map((restaurante) => (
                <tr key={restaurante.cdRest} className="hover:bg-gray-50">
                  <td className="py-2 px-4 border-b text-sm text-gray-800">{restaurante.cdRest}</td>
                  <td className="py-2 px-4 border-b text-sm text-gray-800">{restaurante.nome}</td>
                  <td className="py-2 px-4 border-b text-sm text-gray-800">{restaurante.cidade} - {restaurante.sgEstado}</td>
                  <td className="py-2 px-4 border-b text-sm text-gray-800">{restaurante.hrAber} - {restaurante.hrFech}</td>
                  <td className="py-2 px-4 border-b text-sm">
                    <button onClick={() => onEdit(restaurante)} className="text-blue-600 hover:text-blue-800 transition duration-150 mr-2">
                      Editar
                    </button>
                    <button onClick={() => onDelete(restaurante.cdRest)} className="text-red-600 hover:text-red-800 transition duration-150">
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

// Componente de Gerenciamento de Restaurantes
const RestauranteManagement = () => {
  const [restaurantes, setRestaurantes] = useState([]);
  const [editingRestaurante, setEditingRestaurante] = useState(null);
  const { user } = useAuth(); // Usa o hook para acessar o usuário do contexto

  useEffect(() => {
    fetchRestaurantes();
  }, []);

  const fetchRestaurantes = async () => {
    // Simulação de chamada API para o backend Quarkus
    // Em produção: const response = await fetch('/restaurantes', { headers: { 'Authorization': `Bearer ${user.token}` } });
    // const data = await response.json();
    // setRestaurantes(data);
    setRestaurantes([
      { cdRest: 1, nome: 'Restaurante Central', latitude: -15.79, longitude: -47.88, hrAber: '08:00', hrFech: '18:00', logradouro: 'Rua Principal', numero: 123, bairro: 'Centro', cep: '70000000', cidade: 'Brasília', sgEstado: 'DF' },
      { cdRest: 2, nome: 'Restaurante Norte', latitude: -15.75, longitude: -47.90, hrAber: '09:00', hrFech: '17:00', logradouro: 'Avenida Norte', numero: 456, bairro: 'Asa Norte', cep: '70000001', cidade: 'Brasília', sgEstado: 'DF' },
    ]);
  };

  const handleSaveRestaurante = async (restaurante) => {
    // Simulação de chamada API para o backend Quarkus
    if (restaurante.cdRest) {
      // Editar
      // await fetch(`/restaurantes/${restaurante.cdRest}`, { method: 'PUT', headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${user.token}` }, body: JSON.stringify(restaurante) });
      setRestaurantes(restaurantes.map(r => r.cdRest === restaurante.cdRest ? restaurante : r));
    } else {
      // Criar
      // await fetch('/restaurantes', { method: 'POST', headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${user.token}` }, body: JSON.stringify(restaurante) });
      setRestaurantes([...restaurantes, { ...restaurante, cdRest: Math.max(...restaurantes.map(r => r.cdRest), 0) + 1 }]);
    }
    setEditingRestaurante(null);
  };

  const handleDeleteRestaurante = async (id) => {
    // Simulação de chamada API
    // await fetch(`/restaurantes/${id}`, { method: 'DELETE', headers: { 'Authorization': `Bearer ${user.token}` } });
    setRestaurantes(restaurantes.filter(r => r.cdRest !== id));
  };

  return (
    <div className="p-6 bg-white rounded-lg shadow-md">
      <h3 className="text-2xl font-semibold text-gray-800 mb-4">Gerenciar Restaurantes</h3>
      <button
        onClick={() => setEditingRestaurante({})}
        className="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition duration-150 mb-4"
      >
        Adicionar Novo Restaurante
      </button>

      {editingRestaurante && (
        <RestauranteForm restaurante={editingRestaurante} onSave={handleSaveRestaurante} onCancel={() => setEditingRestaurante(null)} />
      )}

      <RestauranteList
        restaurantes={restaurantes}
        onEdit={setEditingRestaurante}
        onDelete={handleDeleteRestaurante}
      />
    </div>
  );
};

export default RestauranteManagement;