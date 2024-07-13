
# AI Touristic Explorer Server Flask API Documentation

## Description:


This repository contains a Flask API for obtaining city information. The API uses Gemma Large Language Model, run locally using Ollama, to generate detailed cultural, historical, and geographical facts and points of interest about cities by sending POST requests with city names as input.

## Usage
To use this API to get city information, follow these steps:

### Start the docker container:
```

```

### Endpoints:
1. **Check Server Status:**
   - **Endpoint:** `/hello`
   - **Method:** GET
   - **Description:** Checks if the server is running.
   - **Response:** `{ "status": "ok" }`

2. **Check Local Model Response:**
   - **Endpoint:** `/checkLocal`
   - **Method:** GET
   - **Description:** Checks if the local model is responding.
   - **Response:** `{ "response": "Hello, Gemma!!" }` (or similar based on the model's response)

3. **Generate Points of Interest:**
   - **Endpoint:** `/generatePOI`
   - **Method:** POST
   - **Content-Type:** application/json
   - **Payload:**
     ```json
     {
         "text": "New York"
     }
     ```
   - **Description:** Generates detailed information about the 4-5 most famous points of interest in the specified city.
   - **Response:** JSON object with points of interest details.

4. **Get City Information:**
   - **Endpoint:** `/getCityInformation`
   - **Method:** POST
   - **Content-Type:** application/json
   - **Payload:**
     ```json
     {
         "text": "Paris"
     }
     ```
   - **Description:** Get's data from Wikipedia of the city, categorizes it into cultural, historical, and geographical sections, and generates detailed facts.
   - **Response:** JSON object with categorized facts.

### Example Request for `/getCityInformation`:
```json
POST /getCityInformation
Content-Type: application/json

{
    "text": "Paris"
}
```

This will generate detailed facts about the cultural, historical, and geographical aspects of the specified city.

## Additional Notes
- The API utilizes the Wikipedia content for retrieving city content and the Gemma model, run locally using Ollama, for generating detailed facts.
- Feel free to modify and adapt this API as needed for your specific use case.

