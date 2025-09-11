Geocoder.configure(
  # Nominatim é o padrão para endereços; sem chave
  lookup: :nominatim,
  # Exigência do Nominatim: identificar o app com um User-Agent válido
  http_headers: {
    "User-Agent" => ENV.fetch("GEOCODER_USER_AGENT") {
      "weather_app/1.0 (contact: you@example.com)"
    }
  },
  # Boas práticas
  use_https: true,
  timeout: 5,
  units: :km
)
