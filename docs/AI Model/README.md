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