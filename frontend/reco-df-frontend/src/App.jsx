import React, { useState, useEffect } from 'react';
import 'leaflet/dist/leaflet.css';
import MapaSelecionarLocalizacao from './components/MapaSelecionarLocalização';

// Componente principal da aplicação
const App = () => {
  // --- Estado Global da Aplicação ---
  const [user, setUser] = useState(() => {
    const storedUser = localStorage.getItem('recoDfUser');
    return storedUser ? JSON.parse(storedUser) : null;
  });
  const [currentView, setCurrentView] = useState('restaurantes'); // Controla a visão atual (restaurantes, cardapios, alimentos)
  const [restaurantes, setRestaurantes] = useState([]); // Dados dos restaurantes
  const [cardapios, setCardapios] = useState([]); // Dados dos cardápios
  const [alimentos, setAlimentos] = useState([]); // Dados dos alimentos
  const [tiposAlimento, setTiposAlimento] = useState([]); // Dados dos tipos de alimento (para seleção)

  const [editingRestaurante, setEditingRestaurante] = useState(null); // Restaurante sendo editado/criado
  const [editingCardapio, setEditingCardapio] = useState(null);     // Cardápio sendo editado/criado
  const [editingAlimento, setEditingAlimento] = useState(null);     // Alimento sendo editado/criado

  const [loginError, setLoginError] = useState(''); // Mensagem de erro do login
  const [isLoggingIn, setIsLoggingIn] = useState(false); // Estado de carregamento do login

  // --- Efeitos (Simulação de Carregamento de Dados) ---
  useEffect(() => {
    // Simula o carregamento inicial de dados para todas as entidades
    // Em uma aplicação real, estas seriam chamadas API para o backend
    fetchRestaurantes();
    fetchCardapios();
    fetchAlimentos();
    fetchTiposAlimento();
  }, []); // Executa apenas uma vez no carregamento do componente

  // --- Função para buscar restaurantes da API real ---
  const fetchRestaurantes = async () => {

    const storedUser = JSON.parse(localStorage.getItem('recoDfUser'));
    const token = storedUser?.token;
    console.log('TOKEN:', token);

    try {
      const response = await fetch('http://localhost:8080/restaurantes',
        {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        });
      if (!response.ok) {
        throw new Error(`Erro ao buscar restaurantes: ${response.status}`);
      }
      const data = await response.json();
      setRestaurantes(data); // Atualiza o estado com os dados da API
    } catch (error) {
      console.error('Erro ao buscar restaurantes:', error);
    }
  };


  const handleSaveRestaurante = (restaurante) => {
    if (restaurante.cdRest) {
      // Atualiza restaurante existente
      setRestaurantes(prev => prev.map(r => r.cdRest === restaurante.cdRest ? restaurante : r));
    } else {
      // Adiciona novo restaurante
      const newId = Math.max(...restaurantes.map(r => r.cdRest || 0), 0) + 1;
      setRestaurantes(prev => [...prev, { ...restaurante, cdRest: newId }]);
    }
    setEditingRestaurante(null); // Fecha o formulário
  };

  const handleDeleteRestaurante = (id) => {
    if (window.confirm('Tem certeza que deseja excluir este restaurante?')) {
      setRestaurantes(prev => prev.filter(r => r.cdRest !== id));
    }
  };

  // --- Funções de Simulação de API para Cardápios ---
  const fetchCardapios = () => {
    const mockData = [
      { cdCardapio: 1, dtCardapio: '2025-07-22', restaurante: { cdRest: 1, nome: 'Restaurante Central' } },
      { cdCardapio: 2, dtCardapio: '2025-07-23', restaurante: { cdRest: 2, nome: 'Restaurante Norte' } },
    ];
    setCardapios(mockData);
  };

  const handleSaveCardapio = (cardapio) => {
    if (cardapio.cdCardapio) {
      setCardapios(prev => prev.map(c => c.cdCardapio === cardapio.cdCardapio ? cardapio : c));
    } else {
      const newId = Math.max(...cardapios.map(c => c.cdCardapio || 0), 0) + 1;
      setCardapios(prev => [...prev, { ...cardapio, cdCardapio: newId }]);
    }
    setEditingCardapio(null);
  };

  const handleDeleteCardapio = (id) => {
    if (window.confirm('Tem certeza que deseja excluir este cardápio?')) {
      setCardapios(prev => prev.filter(c => c.cdCardapio !== id));
    }
  };

  // --- Funções de Simulação de API para Alimentos ---
  const fetchAlimentos = () => {
    const mockData = [
      { cdAlimento: 1, descricao: 'Arroz Branco', tipoAlimento: { cdTipoAlimento: 1, nome: 'Carboidrato' } },
      { cdAlimento: 2, descricao: 'Feijão Carioca', tipoAlimento: { cdTipoAlimento: 2, nome: 'Proteína' } },
    ];
    setAlimentos(mockData);
  };

  const fetchTiposAlimento = () => {
    const mockData = [
      { cdTipoAlimento: 1, nome: 'Carboidrato' },
      { cdTipoAlimento: 2, nome: 'Proteína' },
      { cdTipoAlimento: 3, nome: 'Vegetal' },
    ];
    setTiposAlimento(mockData);
  };

  const handleSaveAlimento = (alimento) => {
    if (alimento.cdAlimento) {
      setAlimentos(prev => prev.map(a => a.cdAlimento === alimento.cdAlimento ? alimento : a));
    } else {
      const newId = Math.max(...alimentos.map(a => a.cdAlimento || 0), 0) + 1;
      setAlimentos(prev => [...prev, { ...alimento, cdAlimento: newId }]);
    }
    setEditingAlimento(null);
  };

  const handleDeleteAlimento = (id) => {
    if (window.confirm('Tem certeza que deseja excluir este alimento?')) {
      setAlimentos(prev => prev.filter(a => a.cdAlimento !== id));
    }
  };

  const handleLogin = async (username, password) => {
    setLoginError('');
    setIsLoggingIn(true); // Ativa o estado de carregamento do login

    try {
      // Faz a requisição POST para o endpoint de login do seu backend
      const response = await fetch('http://localhost:8080/usuarios/login', { // ⚠️ Substitua pela URL real do seu backend
        method: 'POST',
        headers: {
          'Content-Type': 'application/json', // Indica que o corpo da requisição é JSON
        },
        body: JSON.stringify({ login: username, senha: password }), // Converte os dados para JSON
      });

      if (response.ok) { // Se a resposta for um status 2xx (sucesso)
        const data = await response.json(); // Analisa a resposta JSON
        // Armazena o usuário e o token JWT recebido do backend
        const userWithToken = { username: data.username, role: 'admin', token: data.token };
        setUser(userWithToken);
        localStorage.setItem('recoDfUser', JSON.stringify(userWithToken)); // Persiste no localStorage
      } else if (response.status === 401) { // Se o status for 401 (Não Autorizado)
        setLoginError('Credenciais inválidas. Verifique seu login e senha.');
      } else if (response.status === 400) { // Se o status for 400 (Bad Request - erros de validação)
        const errorData = await response.json();
        let errorMessage = 'Erro de validação: ';
        if (errorData.violations && errorData.violations.length > 0) {
          // Concatena as mensagens de erro de validação do backend
          errorMessage += errorData.violations.map(v => v.message).join('; ');
        } else if (errorData.message) {
          errorMessage += errorData.message;
        } else {
          errorMessage += 'Dados inválidos. Verifique os campos.';
        }
        setLoginError(errorMessage);
      } else { // Para outros erros de servidor (5xx) ou cliente (4xx)
        setLoginError('Erro ao tentar fazer login. Tente novamente mais tarde.');
        console.error("Erro na resposta da API:", response.status, await response.text());
      }
    } catch (error) { // Lida com erros de rede (ex: servidor offline)
      console.error("Erro de rede ou inesperado:", error);
      setLoginError('Não foi possível conectar ao servidor. Verifique sua conexão.');
    } finally {
      setIsLoggingIn(false); // Desativa o estado de carregamento do login
    }
  };

  const handleLogout = () => {
    setUser(null);
    setCurrentView('restaurantes'); // Volta para a visão padrão após logout
  };

  // --- Estado para Login (deve ser sempre chamado no topo do componente) ---
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

  // --- Renderização Condicional ---
  if (!user) {
    // Componente de Login (inline)
    const onSubmitLogin = (e) => {
      e.preventDefault();
      handleLogin(username, password);
    };

    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-100 p-4">
        <div className="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
          <h2 className="text-3xl font-bold text-center text-gray-800 mb-6">Login Reco-DF</h2>
          <form onSubmit={onSubmitLogin} className="space-y-6">
            <div>
              <label htmlFor="username" className="block text-sm font-medium text-gray-700 mb-1">
                Usuário
              </label>
              <input
                type="text"
                id="username"
                className="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                required
              />
            </div>
            <div>
              <label htmlFor="password" className="block text-sm font-medium text-gray-700 mb-1">
                Senha
              </label>
              <input
                type="password"
                id="password"
                className="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />
            </div>
            {loginError && <p className="text-red-500 text-sm text-center">{loginError}</p>}
            <button
              type="submit"
              className="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition duration-150 ease-in-out"
            >
              Entrar
            </button>
          </form>
        </div>
      </div>
    );
  }

  // --- Componente Navbar (inline) ---
  const Navbar = () => (
    <nav className="bg-blue-700 p-4 text-white shadow-md">
      <div className="container mx-auto flex justify-between items-center">
        <h1 className="text-2xl font-bold">Reco-DF Admin</h1>
        <div className="flex items-center space-x-4">
          <button onClick={() => setCurrentView('restaurantes')} className="hover:text-blue-200 transition duration-150">
            Restaurantes
          </button>
          <button onClick={() => setCurrentView('cardapios')} className="hover:text-blue-200 transition duration-150">
            Cardápios
          </button>
          <button onClick={() => setCurrentView('alimentos')} className="hover:text-blue-200 transition duration-150">
            Alimentos
          </button>
          {user && (
            <span className="ml-4 text-blue-200">Olá, {user.username}!</span>
          )}
          <button onClick={handleLogout} className="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded-md transition duration-150">
            Sair
          </button>
        </div>
      </div>
    </nav>
  );

  // --- Componentes de Gerenciamento (inline) ---

  // Formulário de Restaurante (inline)
  const RestauranteForm = ({ restaurante, onSave, onCancel }) => {
    const [formData, setFormData] = useState(restaurante);

    const handleChange = (e) => {
      const { name, value } = e.target;
      setFormData({ ...formData, [name]: value });
    };

    const handleSubmit = async (e) => {
      e.preventDefault();
      const userData = JSON.parse(localStorage.getItem('recoDfUser'));
      const token = userData?.token;
      if (!token) {
        alert('Usuário não autenticado.');
        return;
      }

      formData.hrAber = formData.hrAber?.length === 5 ? formData.hrAber + ':00' : formData.hrAber;

      formData.hrFech = formData.hrFech?.length === 5 ? formData.hrFech + ':00' : formData.hrFech;


        try {
          
          const response = await fetch('http://localhost:8080/restaurantes', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${token}`,
            },
            body: JSON.stringify(formData),
          });

          if(response.ok) {
            const data = await response.json();
      onSave(data); // Atualiza estado/pai com o novo restaurante salvo
    } else if (response.status === 401) {
      alert('Não autorizado. Faça login novamente.');
    } else {
      const errText = await response.text();
      console.error('Erro ao salvar restaurante:', response.status, errText);
      alert('Erro ao salvar restaurante.');
    }
  } catch (err) {
    console.error('Erro de rede:', err);
    alert('Erro de rede ao salvar restaurante.');
  }
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
      <MapaSelecionarLocalizacao
        setLatitude={(lat) => setFormData((prev) => ({ ...prev, latitude: lat }))}
        setLongitude={(lng) => setFormData((prev) => ({ ...prev, longitude: lng }))}
      />

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

// Lista de Restaurantes (inline)
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

// Componente de Gerenciamento de Restaurantes (inline)
const RestauranteManagement = () => (
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

// Formulário de Cardápio (inline)
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

// Lista de Cardápios (inline)
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

// Componente de Gerenciamento de Cardápios (inline)
const CardapioManagement = () => (
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

// Formulário de Alimento (inline)
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

// Lista de Alimentos (inline)
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

// Componente de Gerenciamento de Alimentos (inline)
const AlimentoManagement = () => (
  <div className="p-6 bg-white rounded-lg shadow-md">
    <h3 className="text-2xl font-semibold text-gray-800 mb-4">Gerenciar Alimentos</h3>
    <button
      onClick={() => setEditingAlimento({})}
      className="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition duration-150 mb-4"
    >
      Adicionar Novo Alimento
    </button>

    {editingAlimento && (
      <AlimentoForm alimento={editingAlimento} tiposAlimento={tiposAlimento} onSave={handleSaveAlimento} onCancel={() => setEditingAlimento(null)} />
    )}

    <AlimentoList
      alimentos={alimentos}
      onEdit={setEditingAlimento}
      onDelete={handleDeleteAlimento}
    />
  </div>
);

// --- Renderização da Aplicação Principal ---
return (
  <div className="font-sans antialiased bg-gray-50 min-h-screen">
    <Navbar /> {/* Navbar sempre visível após login */}
    <div className="container mx-auto p-4">
      {currentView === 'restaurantes' && <RestauranteManagement />}
      {currentView === 'cardapios' && <CardapioManagement />}
      {currentView === 'alimentos' && <AlimentoManagement />}
    </div>
  </div>
);
};

export default App;
