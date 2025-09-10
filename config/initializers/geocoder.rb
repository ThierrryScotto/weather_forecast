Geocoder.configure(
  lookup: :nominatim,                 # grátis (OSM) — respeite a política de uso do Nominatim
  timeout: 3,
  units: :km,
  http_headers: { "User-Agent" => "WeatherAppRails/1.0 (contato@exemplo.com)" }
)
