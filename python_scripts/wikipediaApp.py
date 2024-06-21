from flask import Flask, request, jsonify
import requests
import json
from groq import Groq
import wikipedia
import re
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

app = Flask(__name__)


def removeMarkdown(responseText):
    cleaned_string = responseText.replace('json', '')
    cleaned_string = cleaned_string.replace('```', '')
    return cleaned_string


def wikiData(city_name):
    try:
        wikipedia_page = wikipedia.page(city_name, auto_suggest=False)
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
    prompt = "Take the given headings: "+headings_string + \
        ". Can you categorize these headings into three categories: 'cultural', 'historical', and 'geographical' in a JSON object structure? The JSON object should have the following format: {'cultural':['heading1','heading2',...etc],'historical':['heading1','heading2',...etc],'geographical':['heading1','heading2',...etc]}. Please provide the categorization, without any markdown and only using the given headings. Also the max no of headings for any category should be 5. So choose atmost 5 most relevant headings for each category."

    chat_completion = client.chat.completions.create(
        messages=[
            {
                "role": "user",
                "content": prompt,
            }
        ],
        model="gemma-7b-it",
    )
    groq_response = removeMarkdown(chat_completion.choices[0].message.content)
    print(groq_response)
    categories_dict = json.loads(groq_response)

    cultural = categories_dict.get('cultural', [])
    historical = categories_dict.get('historical', [])
    geographical = categories_dict.get('geographical', [])
    print(cultural)
    print(historical)
    print(geographical)
    return cultural, historical, geographical


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
    return culturalData, historicalData, geographicalData


def generateHistorical(information):
    prompt = "You’re an experienced data analyst responsible for compiling 4-5 very detailed historical facts about various cities worldwide. Your task here is to create a JSON object that includes detailed historical facts about the city using the information provided below. . Details: " + \
        information + \
        " Task: Create a JSON object that includes detailed historical facts about the city using the information provided below. The JSON object should be structured as follows: {'historical_facts': [{'fact':'detailed information about fact'}, {'fact':'detailed information about fact'}, ...]}. The response should strictly adhere to the specified JSON format, with no additional symbols, newline characters, or extraneous information.  Do not add sensitive data."
    print(prompt)
    payload = {
        "model": "gemma:2b",
        "prompt": prompt,
        "stream": False,
    }

    try:
        response = requests.post(
            "http://localhost:11434/api/generate", json=payload)

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


@app.route('/get', methods=['POST'])
def get():
    city_name = request.json.get('text')
    wikipedia_content = wikiData(city_name)
    if wikipedia_content != "no_content":
        headings = getHeadings(wikipedia_content)
        cultural, historical, geographical = categorize(headings)
        culturalData, historicalData, geographicalData = extract_sections(wikipedia_content,
                                                                          cultural, historical, geographical)
        return generateHistorical(historicalData)
        # return jsonify({"status": "success", "culturalData": culturalData,
        # "historicalData": historicalData, "geographicalData": geographicalData})
    else:
        return jsonify({"status": "error", "message": "Failed to fetch content"})


if __name__ == '__main__':

    client = Groq(
        api_key="",
    )
    app.run(debug=True)
