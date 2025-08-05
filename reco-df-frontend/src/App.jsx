// src/App.js
import { useState } from 'react';
import { AuthProvider } from './context/AuthContext';
import Login from './pages/Login';
import Navbar from './components/Navbar';
import RestauranteManagement from './pages/RestauranteManagement';
import CardapioManagement from './pages/CardapioManagement';
import AlimentoManagement from './pages/AlimentoManagement';

const App = () => {
  const [user, setUser] = useState(null);
  const [currentView, setCurrentView] = useState('restaurantes'); // Visão inicial

  const handleLoginSuccess = (userData) => {
    setUser(userData);
    // Em uma aplicação real, você pode armazenar o token em localStorage/sessionStorage
    // localStorage.setItem('userToken', userData.token);
  };

  const handleLogout = () => {
    setUser(null);
    // localStorage.removeItem('userToken');
    setCurrentView('restaurantes'); // Volta para a visão padrão após logout
  };

  // Efeito para verificar o token no carregamento inicial (se armazenado)
  // useEffect(() => {
  //   const storedToken = localStorage.getItem('userToken');
  //   if (storedToken) {
  //     // Aqui você faria uma validação do token com o backend
  //     // Por simplicidade, apenas simula o usuário logado
  //     setUser({ username: 'admin', role: 'admin', token: storedToken });
  //   }
  // }, []);

  return (
    <AuthProvider value={{ user, setUser }}>
      <div className="font-sans antialiased bg-gray-50 min-h-screen">
        {user ? (
          <>
            <Navbar onNavigate={setCurrentView} onLogout={handleLogout} />
            <div className="container mx-auto p-4">
              {currentView === 'restaurantes' && <RestauranteManagement />}
              {currentView === 'cardapios' && <CardapioManagement />}
              {currentView === 'alimentos' && <AlimentoManagement />}
            </div>
          </>
        ) : (
          <Login onLoginSuccess={handleLoginSuccess} />
        )}
      </div>
    </AuthProvider>
  );
};

export default App;