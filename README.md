# Weather Forecast

Ruby on Rails application to check weather forecasts using US ZIP codes or addresses, powered by [OpenWeather API](https://openweathermap.org/api).

## Technologies Used

- Ruby on Rails
- HTTParty (HTTP requests)
- Rails Cache (memory caching)
- OpenWeather API

## How to Run Locally

1. **Clone the repository**

   ```
   git clone https://github.com/ThierrryScotto/weather_forecast.git
   cd weather_forecast
   ```

2. **Install dependencies**

   ```
   bundle install
   ```

3. **Set up environment variables**

   - Copy `.env.example` to `.env` and fill in the required variables, especially your OpenWeather API key.

   ```
   cp .env.example .env
   ```

4. **Start the Rails server**

   ```
   rails server
   ```

5. **Access the application**

   Open your browser and go to:

   ```
   http://localhost:3000
   ```

## API Results (Screenshots)

Below are some screenshots showing the API results in the application:

## Home page
<img width="680" height="293" alt="index_page" src="https://github.com/user-attachments/assets/ddc31dd9-7afb-4b74-a6be-31ceffa155c8" />

### Success case with zip code 10001
<img width="670" height="553" alt="success_screen" src="https://github.com/user-attachments/assets/3792a6fe-8dc4-4820-bb04-60daf054d77f" />

<h6>backend log</h6>

<img width="635" height="34" alt="success_screen_logs" src="https://github.com/user-attachments/assets/f22aabaf-e695-4f4c-8775-f9a657abaf3d" />

### Success case with zip code 10001 using cache
<img width="665" height="587" alt="cache success screen" src="https://github.com/user-attachments/assets/b3f71a98-4db4-431d-b1aa-eebe7ac4d01a" />

### Error case with an invalid ZIP code 100012
<img width="673" height="349" alt="error_screen" src="https://github.com/user-attachments/assets/a1320d77-c197-43ad-a125-9415862531fc" />

<h6>backend log</h6>
<img width="600" height="48" alt="error_screen_logs" src="https://github.com/user-attachments/assets/680803b1-2749-49cb-b62e-e1823d95935e" />

### Error case with a connection error to the OpenWeather API
<img width="666" height="344" alt="error_screen_api_key_missing" src="https://github.com/user-attachments/assets/99c02e4a-ff38-4f09-a3e1-81e0c13e82d4" />

<h6>backend log</h6>
<img width="1082" height="63" alt="error_screen_logs_api_key_missing" src="https://github.com/user-attachments/assets/cac19cc7-fc57-408d-acd0-b66416395bb2" />

## Notes

- Caching is used to avoid repeated requests for 30 minutes.
- If the address/ZIP code is not found, an empty result is returned.

## Example Response

```json
{
  "name": "New York",
  "main": {
    "temp": 18.0,
    "temp_min": 18.0,
    "temp_max": 18.0,
    "humidity": 77
  },
  "weather": [
    {
      "description": "clear sky",
      "icon": "01d"
    }
  ]
}
```

## Ruby & Rails Versions

- **Ruby:** 3.2.2
- **Ruby on Rails:** 7.1.2
