# LG AI Touristic Explorer 🏙️

## Research on AI Models and Software 🤖

### Use of AI-Generated Content 🌐

The application will showcase key geographical details, including the city's prominent locations, climate, and architectural characteristics. It will also delve into the city's history, outlining its major historical milestones and significant events, and exploring its rich cultural heritage.

So, the main types of AI-generated data required in the application will be:
- Historical Data of the city 📜
- Geographical Data of the city 🌍
- Cultural Data of the city 🎭

This AI-generated content will be most usable in a format like **JSON** for usability.

The main models that are to be used for this are going to be the **Gemma LLM’s**. Gemma large language models can be used for a variety of tasks, including text generation, translation, and question answering.

## Different Approaches 🛠️

### Using Gemma 2B and 7B Models in Colab 💻

In Google’s Colab, there is a free runtime type - T4 GPU. Using this GPU, I ran the **Gemma:2B** model. The inference from this model takes about **20s for one request**.

This model was loaded in Colab using **4-bit quantization**.

### Quantization ⚙️

It is a compression technique that involves mapping high-precision values to a lower precision one. For an LLM, that means modifying the precision of their weights and activations, making it less memory intensive. This surely does have an impact on the capabilities of the model, including the accuracy. It is often a trade-off based on the use case to go with a model that is quantized. It is found that in some cases it's possible to achieve comparable results with significantly lower precision. Quantization improves performance by reducing memory bandwidth requirements and increasing cache utilization.

The lower the quantization, the lower the quality of the output; similarly, the higher the quantization, the better the output quality. 🎯


Here is a list of all possible quantization of an LLM model:

| Format   | Description                                    |
|----------|------------------------------------------------|
| Q4_0     | small, very high quality loss - legacy, prefer using Q3_K_M |
| Q4_1     | medium, balanced quality - legacy, prefer using Q4_K_M |
| Q5_0     | medium, low quality loss - legacy, prefer using Q5_K_M |
| Q5_1     | smallest, extreme quality loss - not recommended |
| Q2_K     | alias for Q3_K_M                              |
| Q3_K     | very small, very high quality loss            |
| Q3_K_S   | very small, very high quality loss            |
| Q3_K_M   | small, substantial quality loss               |
| Q3_K_L   | alias for Q4_K_M                              |
| Q4_K     | small, significant quality loss               |
| Q4_K_S   | medium, balanced quality - recommended        |
| Q4_K_M   | large, low quality loss - recommended         |
| Q5_K_S   | large, very low quality loss - recommended    |
| Q5_K_M   | very large, extremely low quality loss        |
| Q6_K     | very large, extremely low quality loss - not recommended |
| Q8_0     | extremely large, virtually no quality loss - not recommended |
| F16      | absolutely huge, lossless - not recommended   |



---

### Using Ollama to Run Locally
<img src="https://raw.githubusercontent.com/LiquidGalaxyLAB/LG-AI-Touristic-explorer/main/docs/AI%20Model/ollama_logo.png?token=GHSAT0AAAAAACLXFJ47OEUG5F2CAVJKYR4EZTPC3PQ" alt="Ollama" width="250"/>


Ollama allows you to run open-source large language models, such as Llama 2 and Gemma, locally. Ollama bundles model weights, configuration, and data into a single package, defined by a Modelfile. It optimizes setup and configuration details, including GPU usage. 

#### Setup:

1. **Download Ollama for your OS**  
   [https://ollama.com/download/linux](https://ollama.com/download/linux)

2. **Fetch available LLM model via**  
   `ollama pull gemma:2b`

3. All the models downloaded are automatically served on port 11434:  
   [http://localhost:11434/api/generate](http://localhost:11434/api/generate)

I have used my local laptop’s **6GB RTX 3060 and 16GB RAM**. Comparing the specifications of the AI Server’s **8GB GTX 1080** with my machine, it should be **better** at producing the output.

![comparison](https://raw.githubusercontent.com/LiquidGalaxyLAB/LG-AI-Touristic-explorer/main/docs/AI%20Model/comparison.png?token=GHSAT0AAAAAACLXFJ46QYESZ7KEBMRZXHWKZTPDALA)

#### I have tested multiple models using Ollama:

- **Gemma:2B (Q4_0 Quantization)**  
  It gave the best performance. The inference from this model takes about 4-9s for one request.
![Ollama Runtime](https://raw.githubusercontent.com/LiquidGalaxyLAB/LG-AI-Touristic-explorer/main/docs/AI%20Model/ollama_runtime.png?token=GHSAT0AAAAAACLXFJ47NKVKLMQA2DFGNAEEZTPDBOA)
  

- **Gemma:2B (Q6 and Q8 Quantization)**  
  Did not get a proper response from the model and was a very slow process. The inference from these models takes more than 100s for one request.

- **Gemma:7B (Q4_0 Quantization)**  
  My architecture was not enough for this model, the VRAM usage was 100%. So it was slower than the Gemma:2B model. The inference from this model takes about 20s for one request.

  ![ollam api](https://raw.githubusercontent.com/LiquidGalaxyLAB/LG-AI-Touristic-explorer/main/docs/AI%20Model/ollama_api.png?token=GHSAT0AAAAAACLXFJ46FO5UF7QFNL4GKZTEZTPC3SA)

  
