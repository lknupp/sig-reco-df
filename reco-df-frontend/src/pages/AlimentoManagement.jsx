import React, { useState, useEffect } from 'react';
import { useAuth } from '../context/AuthContext'; // Importa o hook customizado

// Formulário de Alimento (mantido aqui por enquanto)
const AlimentoForm = ({ alimento, tiposAlimento, onSave, onCancel }) => {
  const [formData, setFormData] = useState({
    ...alimento,
    tipoAlimentoId: alimento.tipoAlimento ? alimento.tipoAlimento.cdTipoAlimento : ''
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const selectedTipoAlimento = tiposAlimento.find(t => t.cdTipoAlimento === parseInt(formData.tipoAlimentoId));
    onSave({
      ...formData,
      tipoAlimento: selectedTipoAlimento // Conecta o objeto completo do tipo de alimento
    });
  };

  return (
    <div className="mt-6 p-6 border border-gray-200 rounded-lg bg-gray-50">
      <h4 className="text-xl font-medium text-gray-800 mb-4">{alimento.cdAlimento ? 'Editar Alimento' : 'Novo Alimento'}</h4>
      <form onSubmit={handleSubmit} className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <label className="block">
          <span className="text-gray-700">Descrição:</span>
          <input type="text" name="descricao" value={formData.descricao || ''} onChange={handleChange} required className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" />
        </label>
        <label className="block">
          <span className="text-gray-700">Tipo de Alimento:</span>
          <select
            name="tipoAlimentoId"
            value={formData.tipoAlimentoId}
            onChange={handleChange}
            required
            className="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50"
          >
            <option value="">Selecione um tipo</option>
            {tiposAlimento.map(t => (
              <option key={t.cdTipoAlimento} value={t.cdTipoAlimento}>
                {t.nome}
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

// Lista de Alimentos (mantida aqui por enquanto)
const AlimentoList = ({ alimentos, onEdit, onDelete }) => {
  return (
    <div className="mt-6">
      <h4 className="text-xl font-medium text-gray-800 mb-4">Lista de Alimentos</h4>
      {alimentos.length === 0 ? (
        <p className="text-gray-600">Nenhum alimento cadastrado.</p>
      ) : (
        <div className="overflow-x-auto">
          <table className="min-w-full bg-white border border-gray-200 rounded-lg">
            <thead className="bg-gray-100">
              <tr>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">ID</th>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">Descrição</th>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">Tipo</th>
                <th className="py-2 px-4 border-b text-left text-sm font-semibold text-gray-600">Ações</th>
              </tr>
            </thead>
            <tbody>
              {alimentos.map((alimento) => (
                <tr key={alimento.cdAlimento} className="hover:bg-gray-50">
                  <td className="py-2 px-4 border-b text-sm text-gray-800">{alimento.cdAlimento}</td>
                  <td className="py-2 px-4 border-b text-sm text-gray-800">{alimento.descricao}</td>
                  <td className="py-2 px-4 border-b text-sm text-gray-800">{alimento.tipoAlimento?.nome}</td>
                  <td className="py-2 px-4 border-b text-sm">
                    <button onClick={() => onEdit(alimento)} className="text-blue-600 hover:text-blue-800 transition duration-150 mr-2">
                      Editar
                    </button>
                    <button onClick={() => onDelete(alimento.cdAlimento)} className="text-red-600 hover:text-red-800 transition duration-150">
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

// Componente principal de gerenciamento de alimentos
const AlimentoManagement = () => {
  // Aqui você pode adicionar o estado e lógica para buscar, criar, editar e excluir alimentos,
  // utilizando os componentes AlimentoForm e AlimentoList definidos acima.
  // Exemplo de estrutura inicial:
  const [alimentos, setAlimentos] = useState([]);
  const [tiposAlimento, setTiposAlimento] = useState([]);
  const [editingAlimento, setEditingAlimento] = useState(null);
  const [showForm, setShowForm] = useState(false);

  // Exemplo de useEffect para buscar dados (substitua pelas suas chamadas de API)
  useEffect(() => {
    // Buscar alimentos e tipos de alimento aqui
    // setAlimentos([...]);
    // setTiposAlimento([...]);
  }, []);

  const handleSave = (alimento) => {
    // Lógica para salvar alimento (criar ou editar)
    setShowForm(false);
    setEditingAlimento(null);
    // Atualize a lista de alimentos conforme necessário
  };

  const handleEdit = (alimento) => {
    setEditingAlimento(alimento);
    setShowForm(true);
  };

  const handleDelete = (cdAlimento) => {
    // Lógica para excluir alimento
    // Atualize a lista de alimentos conforme necessário
  };

  const handleCancel = () => {
    setShowForm(false);
    setEditingAlimento(null);
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <h2 className="text-2xl font-bold mb-6">Gerenciamento de Alimentos</h2>
      <button
        onClick={() => { setShowForm(true); setEditingAlimento({}); }}
        className="mb-4 bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition duration-150"
      >
        Novo Alimento
      </button>
      {showForm && (
        <AlimentoForm
          alimento={editingAlimento || {}}
          tiposAlimento={tiposAlimento}
          onSave={handleSave}
          onCancel={handleCancel}
        />
      )}
      <AlimentoList
        alimentos={alimentos}
        onEdit={handleEdit}
        onDelete={handleDelete}
      />
    </div>
  );
};

export default AlimentoManagement;