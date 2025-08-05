import React from 'react';
import { useAuth } from '../context/AuthContext'; // Importa o hook customizado

const Navbar = ({ onNavigate, onLogout }) => {
  const { user } = useAuth(); // Usa o hook para acessar o usuário do contexto

  return (
    <nav className="bg-blue-700 p-4 text-white shadow-md">
      <div className="container mx-auto flex justify-between items-center">
        <h1 className="text-2xl font-bold">Reco-DF Admin</h1>
        <div className="flex items-center space-x-4">
          <button onClick={() => onNavigate('restaurantes')} className="hover:text-blue-200 transition duration-150">
            Restaurantes
          </button>
          <button onClick={() => onNavigate('cardapios')} className="hover:text-blue-200 transition duration-150">
            Cardápios
          </button>
          <button onClick={() => onNavigate('alimentos')} className="hover:text-blue-200 transition duration-150">
            Alimentos
          </button>
          {user && (
            <span className="ml-4 text-blue-200">Olá, {user.username}!</span>
          )}
          <button onClick={onLogout} className="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded-md transition duration-150">
            Sair
          </button>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;