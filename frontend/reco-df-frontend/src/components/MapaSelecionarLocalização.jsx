// components/MapaSelecionarLocalizacao.js
import { MapContainer, TileLayer, Marker, useMapEvents } from 'react-leaflet';
import { useState } from 'react';
import 'leaflet/dist/leaflet.css';
import L from 'leaflet';

// Corrige o ícone padrão do Leaflet no React
const icon = new L.Icon({
  iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
  iconSize: [25, 41],
  iconAnchor: [12, 41],
});

function LocationMarker({ setLatitude, setLongitude }) {
  const [position, setPosition] = useState(null);

  useMapEvents({
    click(e) {
      const { lat, lng } = e.latlng;
      setPosition(e.latlng);
      setLatitude(lat.toFixed(6));
      setLongitude(lng.toFixed(6));
    },
  });

  return position ? <Marker position={position} icon={icon} /> : null;
}

export default function MapaSelecionarLocalizacao({ setLatitude, setLongitude }) {
  return (
    <div className="col-span-full mt-4">
      <p className="text-sm text-gray-700 mb-2">Clique no mapa para definir latitude e longitude:</p>
      <MapContainer center={[-15.78, -47.93]} zoom={12} style={{ height: '300px', width: '100%' }}>
        <TileLayer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          attribution="&copy; OpenStreetMap contributors"
        />
        <LocationMarker setLatitude={setLatitude} setLongitude={setLongitude} />
      </MapContainer>
    </div>
  );
}
