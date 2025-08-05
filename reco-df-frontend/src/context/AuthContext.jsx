import { createContext, useContext } from 'react';

const AuthContext = createContext(null);

// Provedor para envolver a aplicação e fornecer o contexto de autenticação
export const AuthProvider = AuthContext.Provider;

// Hook customizado para fácil acesso ao contexto de autenticação
export const useAuth = () => {
  return useContext(AuthContext);
};

export default AuthContext;