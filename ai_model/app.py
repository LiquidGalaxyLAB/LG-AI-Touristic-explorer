from flask import Flask, request, jsonify
import requests
import json
import wikipedia
import re
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry
import os

app = Flask(__name__)


def removeMarkdown(responseText):
    cleaned_string = responseText.replace('json', '')
    cleaned_string = cleaned_string.replace('```', '')
    return cleaned_string


def wikiData(city_name):
    try:
        wikipedia_page = wikipedia.page(city_name, auto_suggest=True)
        wikipedia_content = wikipedia_page.content
        print("Got content for city_name")
        return wikipedia_content
    except Exception as e:
        print(f"Error fetching Wikipedia content for city '{city_name}': {e}")
        return "no_content"


def getHeadings(wikipedia_content):
    pattern = r'==+ (.*?) ==+'
    headings = re.findall(pattern, wikipedia_content)
    return headings


def categorize(headings):
    headings_string = ", ".join(headings)
    prompt = (
        "Can you categorize the headings into three categories: 'cultural', 'historical', and 'geographical' in a JSON object structure? The JSON object should have the following format: {'cultural': ['heading1', 'heading2', ...], 'historical': ['heading1', 'heading2', ...], 'geographical': ['heading1', 'heading2', ...]}. Ensure that you only use the given headings and that each category contains a maximum of 3 headings. If there are more than 3 relevant headings for a category. Provide the categorization without any additional text or formatting. *PLEASE DO NOT ADD YOUR OWN HEADINGS*. Given the following headings: [ " + headings_string+" ]"
    )

    print(prompt)
    payload = {
        "model": "gemma:2b",
        "prompt": prompt,
        "stream": False,
    }
    try:
        response = requests.post(
            "http://127.0.0.1:11434/api/generate", json=payload)

        if response.status_code == 200:
            response_data = response.json()
            nested_json_str = response_data.get('response', '{}')
            cleaned_string = removeMarkdown(nested_json_str)
            categories_dict = json.loads(cleaned_string)

            cultural = categories_dict.get('cultural', [])
            historical = categories_dict.get('historical', [])
            geographical = categories_dict.get('geographical', [])

            print(cultural)
            print(historical)
            print(geographical)

            return cultural, historical, geographical
        else:
            return {'error': 'An error occurred with the external request'}, response.status_code

    except Exception as e:
        print(f"An error occurred: {e}")
        return {'error': 'An error occurred during generation'}, 500


def extract_sections(wikipedia_content, cultural, historical, geographical):
    culturalData = ""
    historicalData = ""
    geographicalData = ""
    for heading in cultural:
        pattern = re.compile(r"== "+heading+r" ==(.*?)==", re.DOTALL)
        match = pattern.search(wikipedia_content)
        if match:
            section_info = match.group(0)
            culturalData += section_info
        else:
            print(f"{heading} section not found.")
    for heading in historical:
        pattern = re.compile(r"== "+heading+r" ==(.*?)==", re.DOTALL)
        match = pattern.search(wikipedia_content)
        if match:
            section_info = match.group(0)
            historicalData += section_info
        else:
            print(f"{heading} section not found.")
    for heading in geographical:
        pattern = re.compile(r"== "+heading+r" ==(.*?)==", re.DOTALL)
        match = pattern.search(wikipedia_content)
        if match:
            section_info = match.group(0)
            geographicalData += section_info
        else:
            print(f"{heading} section not found.")
    return culturalData.replace('"', '').replace("'", ""), historicalData.replace('"', '').replace("'", ""), geographicalData.replace('"', '').replace("'", "")


def generateFacts(information, fact_type):
    prompt = f"You’re an experienced data analyst responsible for compiling 4-5 very detailed {fact_type} facts about various cities worldwide. Your task here is to create a JSON object that includes detailed {fact_type} facts about the city using the information provided below. Details: {information} Task: Create a JSON object that includes detailed {fact_type} facts about the city using the information provided below. The JSON object should be structured as follows: {{{fact_type}_facts': [{{'fact':'detailed information about fact'}}, {{'fact':'detailed information about fact'}}, ...]}}. The response should strictly adhere to the specified JSON format, with no additional symbols, newline characters, or extraneous information. Ensure that no sensitive data related to deaths, terrorism, or other similar subjects is included."
    print(prompt)
    payload = {
        "model": "gemma:2b",
        "prompt": prompt,
        "stream": False,
    }

    try:
        response = requests.post(
            "http://127.0.0.1:11434/api/generate", json=payload)

        if response.status_code == 200:
            response_data = response.text
            cleaned_string = removeMarkdown(response_data)
            parsed_data = json.loads(cleaned_string)
            return parsed_data
        else:
            return {'error': 'An error occurred with the external request'}, response.status_code

    except Exception as e:
        print(f"An error occurred: {e}")
        return {'error': 'An error occurred during generation'}, 500


@app.route('/generatePOI', methods=['POST'])
def generatePOI():
    city_name = request.json.get('text')
    payload = {
        "model": "gemma:2b",
        "prompt": "Create a JSON object that includes detailed information about the 4-5 most famous points of interest in the city " + city_name + ". The JSON object should be structured as follows: {'points_of_interest': [{'name': 'Name of the point of interest', 'details': 'Detailed information about the point of interest'}, {'name': 'Name of the point of interest', 'details': 'Detailed information about the point of interest'}, ...]}. The response should strictly adhere to the specified JSON format, with no additional symbols, newline characters, or extraneous information.",
        "stream": False,
    }
    try:
        response = requests.post(
            "http://127.0.0.1:11434/api/generate", json=payload)

        if response.status_code == 200:
            response_data = response.text
            cleaned_string = removeMarkdown(response_data)
            parsed_data = json.loads(cleaned_string)
            return (parsed_data)
        else:
            return jsonify({'error': 'An error occurred with the external request'}), response.status_code

    except Exception as e:
        print(f"An error occurred: {e}")
        return jsonify({'error': 'An error occurred during generation'}), 500


@app.route('/generateStory', methods=['GET'])
def generateStory():
    city_name = request.args.get('city')

    if not city_name:
        return jsonify({'error': 'City name is required'}), 400

    prompt = f"Write a captivating and vivid story about {city_name}. Describe the city's landmarks, history, and unique aspects in an engaging and imaginative way. Include interesting characters or events that make the city come to life. The story should transport the reader to {city_name} and give them a sense of its charm and atmosphere. 100 words"

    payload = {
        "model": "gemma:2b",
        "prompt": prompt,
        "stream": False,
    }

    try:
        response = requests.post(
            "http://127.0.0.1:11434/api/generate", json=payload)

        if response.status_code == 200:
            response_data = response.text
            cleaned_string = removeMarkdown(response_data)
            parsed_data = json.loads(cleaned_string)
            return jsonify({"response": parsed_data['response']})

        else:
            return jsonify({'error': 'An error occurred with the external request'}), response.status_code

    except Exception as e:
        print(f"An error occurred: {e}")
        return jsonify({'error': 'An error occurred during generation'}), 500


@app.route('/hello', methods=['GET'])
def check():
    return jsonify({"status": "ok"})


@app.route('/checkLocal', methods=['GET'])
def checkLocal():
    payload = {
        "model": "gemma:2b",
        "prompt": "hello, gemma!!",
        "stream": False,
    }
    try:
        response = requests.post(
            "http://127.0.0.1:11434/api/generate", json=payload)

        if response.status_code == 200:
            response_data = response.text
            cleaned_string = removeMarkdown(response_data)
            parsed_data = json.loads(cleaned_string)
            return jsonify({"response": parsed_data['response']})

        else:
            return jsonify({'error': 'An error occurred with the external request'}), response.status_code

    except Exception as e:
        print(f"An error occurred: {e}")
        return jsonify({'error': 'An error occurred during generation'}), 500


@app.route('/getCityInformation', methods=['POST'])
def getCityInformation():
    city_name = request.json.get('text')
    wikipedia_content = wikiData(city_name)
    if wikipedia_content != "no_content":
        headings = getHeadings(wikipedia_content)
        cultural, historical, geographical = categorize(headings)
        culturalData, historicalData, geographicalData = extract_sections(wikipedia_content,
                                                                          cultural, historical, geographical)

        historical_facts = generateFacts(historicalData, "historical")
        cultural_facts = generateFacts(culturalData, "cultural")
        geographical_facts = generateFacts(geographicalData, "geographical")

        return jsonify({
            "historical_facts": historical_facts["response"],
            "cultural_facts": cultural_facts["response"],
            "geographical_facts": geographical_facts["response"]
        })
    else:
        return jsonify({"status": "error", "message": "Failed to fetch content"})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8107)
