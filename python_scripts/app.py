from flask import Flask, request, jsonify
import requests
import json

app = Flask(__name__)


@app.route('/generateCultural', methods=['POST'])
def generateCultural():
    text = request.json.get('text')
    payload = {
        "model": "gemma:2b",
        "prompt": "Create a JSON object that includes detailed cultural facts about the city " + text + ". The JSON object should be structured as follows: {'cultural_facts': [{'fact':'detailed information about fact'}, 'fact':'detailed information about fact'}, ...]}. The response should strictly adhere to the specified JSON format, with no additional symbols, newline characters, or extraneous information. Please answer in structured way to enhance readability.",
        "stream": False,
        
    }

    try:
        response = requests.post(
            "http://localhost:11434/api/generate", json=payload)

        if response.status_code == 200:
            response_data = response.text
            cleaned_string = response_data.replace('json', '')
            cleaned_string = cleaned_string.replace('```', '')
            parsed_data = json.loads(cleaned_string)
            return (parsed_data)
        else:
            return jsonify({'error': 'An error occurred with the external request'}), response.status_code

    except Exception as e:
        print(f"An error occurred: {e}")

@app.route('/generateHistorical', methods=['POST'])
def generateHistorical():
    text = request.json.get('text')
    payload = {
        "model": "gemma:2b",
        "prompt": "Create a JSON object that includes detailed historical facts about the city " + text + ". The JSON object should be structured as follows: {'historical_facts': [{'fact':'detailed information about fact'}, 'fact':'detailed information about fact'}, ...]}. The response should strictly adhere to the specified JSON format, with no additional symbols, newline characters, or extraneous information. Please answer in structured way to enhance readability.",
        "stream": False,
        "system":"You are a helpful, smart, kind and efficient AI assistant. You always fulfill user requests to the best of your ability."
    }

    try:
        response = requests.post(
            "http://localhost:11434/api/generate", json=payload)

        if response.status_code == 200:
            response_data = response.text
            cleaned_string = response_data.replace('json', '')
            cleaned_string = cleaned_string.replace('```', '')
            parsed_data = json.loads(cleaned_string)
            return (parsed_data)
        else:
            return jsonify({'error': 'An error occurred with the external request'}), response.status_code

    except Exception as e:
        print(f"An error occurred: {e}")


@app.route('/generateGeographical', methods=['POST'])
def generate_info():
    text = request.json.get('text')
    payload = {
        "model": "gemma:2b",
        "prompt": "Create a JSON object that includes detailed geographical facts about the city " + text + ". The JSON object should be structured as follows: {'geographical_facts': [{'fact':'detailed information about fact'}, 'fact':'detailed information about fact'}, ...]}. The response should strictly adhere to the specified JSON format, with no additional symbols, newline characters, or extraneous information. Please answer in structured way to enhance readability.",
        "stream": False,
        
    }

    try:
        response = requests.post(
            "http://localhost:11434/api/generate", json=payload)

        if response.status_code == 200:
            response_data = response.text
            cleaned_string = response_data.replace('json', '')
            cleaned_string = cleaned_string.replace('```', '')
            parsed_data = json.loads(cleaned_string)
            return (parsed_data)
        else:
            return jsonify({'error': 'An error occurred with the external request'}), response.status_code

    except Exception as e:
        print(f"An error occurred: {e}")
        return jsonify({'error': 'An error occurred during generation'}), 500


if __name__ == '__main__':
    app.run(debug=True)
