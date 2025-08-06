/** @type {import('tailwindcss').Config} */
export default {
  // Onde o Tailwind deve procurar por classes CSS para otimização (purging/tree-shaking)
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      // Você pode estender o tema padrão do Tailwind aqui
      // Por exemplo, adicionar novas cores, tamanhos de fonte, etc.
      fontFamily: {
        sans: ['Inter', 'sans-serif'], // Define 'Inter' como a fonte padrão sans-serif
      },
      borderRadius: {
        'xl': '1rem', // Exemplo: Adiciona um novo tamanho de border-radius
      }
    },
  },
  plugins: [
    // Você pode adicionar plugins do Tailwind aqui, como @tailwindcss/forms
    // require('@tailwindcss/forms'),
  ],
}