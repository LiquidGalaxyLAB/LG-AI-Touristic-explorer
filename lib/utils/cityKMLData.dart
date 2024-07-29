import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/models/city.dart';
import 'package:lg_ai_touristic_explorer/models/culture_fact.dart';
import 'package:lg_ai_touristic_explorer/models/geographic_fact.dart';
import 'package:lg_ai_touristic_explorer/models/history_fact.dart';

import '../constants/images.dart';
import '../models/place.dart';

String cityOutline = 'city_outline';
String historicalMap = 'historical_map';
Map<String, List<String>> cityFiles = {
  'amsterdam': [cityOutline],
  'anchorage': [cityOutline, historicalMap],
  'atlanta': [cityOutline],
  'austin': [cityOutline, historicalMap],
  'bangalore': [cityOutline, historicalMap],
  'barcelona': [cityOutline],
  'berlin': [cityOutline],
  'boston': [cityOutline],
  'dallas': [cityOutline],
  'dubai': [cityOutline],
  'dublin': [cityOutline],
  'geneva': [cityOutline],
  'honolulu': [cityOutline],
  'london': [cityOutline],
  'losangeles': [cityOutline, historicalMap],
  'madrid': [cityOutline],
  'manila': [cityOutline],
  'melbourne': [cityOutline],
  'miami': [cityOutline, historicalMap],
  'milan': [cityOutline],
  'moscow': [cityOutline],
  'newyork': [cityOutline, historicalMap],
  'nice': [cityOutline],
  'paris': [cityOutline, historicalMap],
  'sanfrancisco': [cityOutline, historicalMap],
  'seattle': [cityOutline, historicalMap],
  'sydney': [cityOutline],
  'toronto': [cityOutline],
  'vienna': [cityOutline],
  'zurich': [cityOutline],
  'baltimore': [historicalMap],
  'chicago': [historicalMap],
  'detroit': [historicalMap],
  'mumbai': [historicalMap],
  'washingtondc': [historicalMap],
};
var data = {
  "amsterdam": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1PloiQN9rAg710XaFnqvDEK300IFxee_p",
      "type": "cityOutline",
      "description":
          "Amsterdam, the capital of the Netherlands, is known for its artistic heritage, elaborate canal system, and narrow houses with gabled facades, legacies of the city’s 17th-century Golden Age. Its Museum District houses the Van Gogh Museum, works by Rembrandt and Vermeer at the Rijksmuseum, and modern art at the Stedelijk. Cycling is key to the city’s character, and there are numerous bike paths."
    }
  ],
  "anchorage": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=18QQePt_ltVvwWKHQDYQcr2ERYCrtQ1xn",
      "type": "cityOutline",
      "description":
          "Anchorage is Alaska’s largest city and a gateway to the wilderness beyond. The city blends the best of nature and urban life, offering easy access to hiking trails, wildlife viewing, and cultural attractions. It’s surrounded by mountains and water, with stunning views of glaciers and wildlife like bears and moose."
    },
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Anchorage. Founded in 1914 as a railroad construction port for the Alaska Railroad, Anchorage has grown into a thriving urban center. It played a significant role during World War II as a strategic air transport hub. The city has evolved from a small tent city to a bustling metropolis while maintaining its strong ties to its native Alaskan roots."
    }
  ],
  "atlanta": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1YIcNuZ1KIRGG6jVvoJId5pGpC2-EnQll",
      "type": "cityOutline",
      "description":
          "Atlanta, the capital of Georgia, is known for its role in the Civil Rights Movement. The cityscape includes modern skyscrapers, historic buildings, and green spaces like Piedmont Park. Atlanta is also home to prestigious institutions such as the Georgia Aquarium, the High Museum of Art, and the Martin Luther King Jr. National Historical Park."
    }
  ],
  "austin": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1FkfHR2v5-GP8-GntOkN-83Rsv07F8qlm",
      "type": "cityOutline",
      "description":
          "Austin is the capital city of Texas, known for its live music scene centered around country, blues, and rock. Its many parks and lakes are popular for hiking, biking, swimming, and boating. South of the city, Formula One's Circuit of the Americas raceway has hosted the United States Grand Prix."
    },
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Austin. Founded in 1839, Austin has a rich history tied to its origins as a frontier town. It became the capital of the Republic of Texas in 1846 and later the state capital of Texas. Over the years, Austin has grown into a vibrant cultural and economic hub, known for its tech industry, festivals like SXSW, and eclectic food scene."
    }
  ],
  "bangalore": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1dzR4e9Kx1xhqXwARrRWsi8ff8Ml30rKE",
      "type": "cityOutline",
      "description":
          "Bangalore, officially known as Bengaluru, is the capital of the Indian state of Karnataka. It is known as the Silicon Valley of India due to its role as a leading IT exporter. The city is famous for its pleasant climate, parks, and nightlife. Landmarks include Lalbagh Botanical Garden, Cubbon Park, and the Bangalore Palace."
    },
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Bangalore. Founded in the 16th century, Bangalore has a rich historical background as a key administrative and military center of various empires. It became an important commercial and military center under British rule. Today, Bangalore is a cosmopolitan city known for its IT industry and vibrant cultural scene."
    }
  ],
  "barcelona": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1mnP9YzOIo3PEeu6eAB_6Y6Mlu6v8yfrT",
      "type": "cityOutline",
      "description":
          "Barcelona is the capital city of Catalonia, known for its unique architecture, including the Sagrada Familia basilica and Park Güell. The city has a rich cultural heritage, with museums, galleries, and historic neighborhoods like the Gothic Quarter. Barcelona is also famous for its Mediterranean cuisine and vibrant nightlife."
    }
  ],
  "berlin": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1-YGNZzaxiZKThDtNsR092YU4Qgd4bMAG",
      "type": "cityOutline",
      "description":
          "Berlin, the capital of Germany, is known for its diverse architecture, historical significance, and cultural attractions. Landmarks include the Brandenburg Gate, Berlin Wall Memorial, and Museum Island. The city is renowned for its arts scene, nightlife, and modern urban development."
    }
  ],
  "boston": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=16N7pMspBSdd5GBzvlA0lavKmaAunUI0e",
      "type": "cityOutline",
      "description":
          "Boston is the capital city of Massachusetts and one of the oldest cities in the United States. It is known for its historic landmarks like the Freedom Trail, Boston Common, and Harvard University. Boston is a center of education, culture, and innovation, with a vibrant waterfront and rich maritime history."
    }
  ],
  "dallas": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1whlsNF9tagL1bL5Tw7asA1B1tfcQaF92",
      "type": "cityOutline",
      "description":
          "Dallas is a major city in Texas known for its modern architecture, cultural attractions, and bustling business district. The city offers a mix of arts, entertainment, and outdoor activities, with attractions like the Dallas Arts District, Dallas Zoo, and Klyde Warren Park."
    }
  ],
  "dubai": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1irDtCi7AcyFbxmUtz5dHONNgDKoZ9HVY",
      "type": "cityOutline",
      "description":
          "Dubai is a city and emirate in the United Arab Emirates known for its ultramodern architecture, luxury shopping, and lively nightlife scene. The city is home to iconic landmarks like the Burj Khalifa, the world’s tallest building, and the Palm Jumeirah, a man-made island. Dubai is a global business hub and a popular tourist destination."
    }
  ],
  "dublin": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1qKqbuKOcZ51-10VbYqlfToBlDRfgIUsm",
      "type": "cityOutline",
      "description":
          "Dublin is the capital and largest city of Ireland, known for its literary heritage, lively pub culture, and historic landmarks. The city’s attractions include Trinity College, Dublin Castle, and the Guinness Storehouse. Dublin is a vibrant city with a mix of old-world charm and modern amenities."
    }
  ],
  "geneva": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1BSypqBUPJeVkXlPoDuNaUvlWcT8sOY02",
      "type": "cityOutline",
      "description":
          "Geneva is a city in Switzerland known for its humanitarian tradition, international diplomacy, and picturesque setting along Lake Geneva. The city is home to numerous international organizations, museums, and cultural events. Geneva is also a gateway to the Swiss Alps and offers stunning views of Mont Blanc."
    }
  ],
  "honolulu": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1h2Gf_ioudv8a9jBGRqt3eb6VdBf9SO2U",
      "type": "cityOutline",
      "description":
          "Honolulu is the capital city of Hawaii, located on the island of Oahu. It is known for its beautiful beaches, surfing, and cultural attractions like Pearl Harbor and the Bishop Museum. Honolulu blends the traditions of Hawaiian culture with the amenities of a modern city."
    }
  ],
  "london": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1mlqcQ6L53oE5ozBHBV7I1WDJkm771OfP",
      "type": "cityOutline",
      "description":
          "London, the capital of England and the United Kingdom, is a global city known for its historical landmarks, cultural institutions, and diverse population. Attractions include the British Museum, Buckingham Palace, and the Tower of London. London is a leading financial center and a hub for arts, fashion, and entertainment."
    }
  ],
  "losangeles": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1Uf4HkmKmu-IVd8SUqka_fR93hgmUb0nd",
      "type": "cityOutline",
      "description":
          "Los Angeles is a sprawling Southern California city known for its entertainment industry, ethnic diversity, and Mediterranean climate. The city is famous for its film studios, Hollywood Walk of Fame, and cultural attractions like the Getty Center. Los Angeles offers a blend of beaches, mountains, and vibrant urban life."
    },
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Los Angeles. Founded in 1781, Los Angeles has grown from a small Spanish pueblo into a major global city. It played a crucial role in the development of the film industry and became a center of cultural and artistic innovation. The city has a rich multicultural heritage and continues to evolve as a dynamic metropolis."
    }
  ],
  "madrid": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1fDbRUj2qvBcBd9jphGQkbBlsSxHv2lSH",
      "type": "cityOutline",
      "description":
          "Madrid is the capital and largest city of Spain, known for its rich cultural heritage, art museums like the Prado and Reina Sofía, and lively nightlife. The city’s landmarks include the Royal Palace of Madrid and Plaza Mayor. Madrid is famous for its culinary scene and vibrant festivals."
    }
  ],
  "manila": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1vb3ceYRK_ZxK8_-QeAs2DkUn39JsMZWf",
      "type": "cityOutline",
      "description":
          "Manila is the capital city of the Philippines, known for its historic landmarks, shopping centers, and vibrant street life. The city blends Spanish colonial architecture with modern skyscrapers and is home to cultural attractions like Rizal Park and the National Museum of the Philippines."
    }
  ],
  "melbourne": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1k3-hlP5mvSFZNILu_qMBbYUnandSp1B3",
      "type": "cityOutline",
      "description":
          "Melbourne is the capital city of the Australian state of Victoria, known for its cultural diversity, sports events, and arts scene. The city’s attractions include Federation Square, Melbourne Cricket Ground, and the Royal Botanic Gardens. Melbourne is also renowned for its coffee culture and vibrant street art."
    }
  ],
  "miami": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1DBr1tkhVoT-BXiwmwLLvoPuW2SWRy0r1",
      "type": "cityOutline",
      "description":
          "Miami is a vibrant city in southeastern Florida known for its beaches, art deco architecture, and Latin American cultural influences. The city’s attractions include South Beach, the Art Deco Historic District, and the Wynwood Walls. Miami is a hub for finance, commerce, culture, and international trade."
    },
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Founded in 1896, Miami has a history shaped by immigration, development, and cultural diversity. It grew rapidly during the Florida land boom of the 1920s and became a major center for tourism and international trade. Miami’s unique blend of cultures has influenced its architecture, cuisine, and vibrant social scene."
    }
  ],
  "milan": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=11gdo8tEQ40czqCA8ZS3x6wrtPmHnsXRi",
      "type": "cityOutline",
      "description":
          "Milan is a global capital of fashion and design, known for its historical landmarks, high-end shopping, and artistic heritage. The city’s attractions include the Gothic Duomo di Milano cathedral, Leonardo da Vinci's mural \"The Last Supper,\" and the Teatro alla Scala opera house. Milan is also a hub for finance, commerce, and culture."
    }
  ],
  "moscow": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1ES_KL8R8ksRnkBt_Dfh9NNkev2xbV04h",
      "type": "cityOutline",
      "description":
          "Moscow is the capital city of Russia, known for its iconic architecture, historic landmarks, and cultural institutions. The city’s attractions include Red Square, the Kremlin, and the Bolshoi Theatre. Moscow is a center of political, economic, and cultural life in Russia, with a rich history that spans centuries."
    }
  ],
  "newyork": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1ILaUBKw2DrsA0YsiO0iF1T2OrjF92wlZ",
      "type": "cityOutline",
      "description":
          "New York City is a global metropolis known for its iconic landmarks, arts scene, and diverse neighborhoods. Attractions include Times Square, Central Park, and the Statue of Liberty. New York City is a hub for finance, media, fashion, and culture, with a vibrant energy that attracts millions of visitors each year."
    },
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Harlem, a neighborhood in Upper Manhattan, New York City, has played a central role in African American culture and history. It became a cultural and artistic hub during the Harlem Renaissance of the 1920s, fostering creativity in literature, music, and the arts. Harlem continues to be a symbol of African American heritage and urban life."
    }
  ],
  "nice": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1u6ly_nxhZom4XKoH8M3kFFrpG2ftIHDi",
      "type": "cityOutline",
      "description":
          "Nice is a city on the French Riviera known for its stunning waterfront, pebble beaches, and vibrant markets. The city’s attractions include the Promenade des Anglais, Castle Hill, and the Matisse Museum. Nice has a Mediterranean climate and is a popular destination for tourists seeking sun, sea, and culture."
    }
  ],
  "paris": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1soj8_ZzsSeslEuXPgFo3btZTNVApkIb-",
      "type": "cityOutline",
      "description":
          "Paris, the capital city of France, is renowned for its art, fashion, gastronomy, and culture. The city’s landmarks include the Eiffel Tower, Louvre Museum, and Notre-Dame Cathedral. Paris is a global center for art, fashion, and commerce, with a rich history that dates back to ancient times."
    },
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Paris. Founded in the 3rd century BC, Paris has evolved from a Roman city to a medieval trading hub and a center of European culture and politics. The city played a pivotal role in the French Revolution and has been a beacon of artistic and intellectual achievement. Paris remains a symbol of elegance, romance, and innovation."
    }
  ],
  "sanfrancisco": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1mTtaHrzXVSWDi-M70MPn9_8r56CPxJxo",
      "type": "cityOutline",
      "description":
          "San Francisco is a city in northern California known for its iconic landmarks, diverse neighborhoods, and scenic beauty. Attractions include the Golden Gate Bridge, Alcatraz Island, and Fisherman's Wharf. San Francisco is a cultural and financial center with a thriving arts scene, tech industry, and culinary diversity."
    },
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "San Francisco. Founded in 1776, San Francisco has a rich history shaped by the Gold Rush, earthquakes, and waves of immigration. The city has been a hub of innovation and counterculture, with a legacy that includes the Summer of Love, Silicon Valley, and the LGBTQ+ rights movement. San Francisco continues to evolve as a dynamic global city."
    }
  ],
  "seattle": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1TWmIUm2EvQRmQMmeimQHnJeCQf1j2YOx",
      "type": "cityOutline",
      "description":
          "Seattle is a city in the Pacific Northwest known for its tech industry, vibrant arts scene, and outdoor recreation opportunities. Attractions include the Space Needle, Pike Place Market, and the Seattle Art Museum. Seattle is surrounded by water, mountains, and forests, offering stunning views and outdoor activities."
    },
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Seattle. Founded in 1851, Seattle grew rapidly due to its strategic location for trade and shipping. It became a center for timber, fishing, and later technology, with companies like Microsoft and Amazon headquartered in the region. Seattle’s cultural diversity and natural beauty have shaped its identity as a dynamic urban center."
    }
  ],
  "sydney": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1_3fgnFnBozHXXiaIMAsXd5uTNuuFO0is",
      "type": "cityOutline",
      "description":
          "Sydney is the capital city of New South Wales and one of Australia’s largest cities. It is known for its iconic landmarks like the Sydney Opera House and Sydney Harbour Bridge. Sydney offers a mix of urban sophistication, natural beauty, and outdoor activities, with beaches, parks, and cultural institutions."
    }
  ],
  "toronto": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1GLo9-AVrNpgpKCxTtMJMbR6ei4w7gs4C",
      "type": "cityOutline",
      "description":
          "Toronto is the capital city of the Canadian province of Ontario, known for its diverse population, cultural attractions, and vibrant arts scene. The city’s landmarks include the CN Tower, Royal Ontario Museum, and St. Lawrence Market. Toronto is a global city with a strong economy and a reputation for innovation and inclusivity."
    }
  ],
  "vienna": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1IuhCLehHEdGQjjpKfC_rnJwWzCyGUQaU",
      "type": "cityOutline",
      "description":
          "Vienna is the capital city of Austria, known for its imperial palaces, cultural events, and classical music heritage. The city’s landmarks include Schönbrunn Palace, St. Stephen's Cathedral, and the Vienna State Opera. Vienna is a UNESCO World Heritage site and a center of European history, art, and cuisine."
    }
  ],
  "zurich": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1vHz8brMan-qsHnh4i4NarZ4bDWRqDF0d",
      "type": "cityOutline",
      "description":
          "Zurich is the largest city in Switzerland and a global financial center known for its banking sector and high standard of living. The city is situated on Lake Zurich and offers a mix of historic architecture, modern amenities, and cultural attractions. Zurich is also known for its vibrant arts scene and outdoor activities."
    }
  ],
  "baltimore": [
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Baltimore. Founded in 1729, Baltimore played a key role in American history as a major seaport and industrial center. It was a key player in the War of 1812 and later became a hub of immigration and manufacturing. Baltimore’s diverse neighborhoods and rich cultural heritage have shaped its identity as a dynamic urban center."
    }
  ],
  "chicago": [
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Chicago. Founded in the 1830s, Chicago grew rapidly due to its strategic location for trade and transportation. It became a major center for industry, finance, and culture, known for its architecture, jazz music, and deep-dish pizza. Chicago’s history includes the Great Fire of 1871 and its rebirth as a modern metropolis."
    }
  ],
  "detroit": [
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Detroit. Founded in 1701, Detroit became a major industrial center known for its automotive industry and Motown sound. The city played a crucial role in World War II production and later faced economic challenges and urban decay. Detroit’s cultural diversity and resilience have shaped its ongoing revitalization efforts."
    }
  ],
  "mumbai": [
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Mumbai, formerly known as Bombay, is the financial and entertainment capital of India. It has a rich history as a trading port and cultural melting pot, influenced by its colonial past and diverse population. Mumbai is known for Bollywood films, historic landmarks like the Gateway of India, and vibrant street life."
    }
  ],
  "washingtondc": [
    {
      "link": "",
      "type": "historicalMap",
      "description":
          "Washington, D.C., the capital of the United States, has a rich history as a center of politics, government, and culture. The city’s landmarks include the White House, Capitol Hill, and National Mall. Washington, D.C. played a pivotal role in the American Revolution, Civil War, and civil rights movement."
    }
  ]
};

checkIsExtra(String cityName) {
  cityName = cityName.replaceAll(" ", "").toLowerCase();
  print("this is $cityName");
  if (!data.containsKey(cityName)) {
    return false;
  } else {
    return true;
  }
}

List<String> getVisualisationOptions(String cityName) {
  cityName = cityName.replaceAll(" ", "").toLowerCase();
  if (cityFiles.containsKey(cityName)) {
    return cityFiles[cityName]!.map((file) {
      if (file == cityOutline) {
        return "Outline";
      } else if (file == historicalMap) {
        return "Historical Fact";
      }
      return "";
    }).toList();
  }
  return [];
}

City newYork = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "New York City is known for its diverse cultural landscape, with over 800 languages spoken, making it one of the most linguistically diverse cities in the world."),
    CulturalFact(
        fact:
            "Broadway, located in Manhattan, is considered the pinnacle of American theater, attracting millions of visitors each year to its shows and performances."),
    CulturalFact(
        fact:
            "The annual New York City Marathon, established in 1970, is the largest marathon in the world, attracting over 50,000 runners from around the globe."),
    CulturalFact(
        fact:
            "New York City is home to the Metropolitan Museum of Art, the largest art museum in the United States, with a collection spanning over 5,000 years of art."),
    CulturalFact(
        fact:
            "The city hosts the Tribeca Film Festival, founded in 2002 by Robert De Niro and Jane Rosenthal, which has become a major platform for independent films."),
    CulturalFact(
        fact:
            "The New York Philharmonic, founded in 1842, is one of the oldest symphony orchestras in the world and has been a cornerstone of the city's cultural scene."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "New York City is located on the eastern coast of the United States, at the mouth of the Hudson River, which flows into New York Harbor."),
    GeographicalFact(
        fact:
            "Central Park, an 843-acre park in the heart of Manhattan, was designed by Frederick Law Olmsted and Calvert Vaux, and opened in 1858. It is one of the most visited urban parks in the United States."),
    GeographicalFact(
        fact:
            "New York City's five boroughs—Manhattan, Brooklyn, Queens, The Bronx, and Staten Island—each have their own unique character and neighborhoods, contributing to the city's rich and varied geography."),
    GeographicalFact(
        fact:
            "The city's extensive subway system, which began operation in 1904, is one of the largest and oldest public transit systems in the world, with 472 stations."),
    GeographicalFact(
        fact:
            "New York Harbor is one of the largest natural harbors in the world and has played a critical role in the city's development as a major port and trade center."),
    GeographicalFact(
        fact:
            "The Bronx is home to the New York Botanical Garden, which spans 250 acres and includes a diverse collection of plants from around the world."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "New York City was originally called New Amsterdam when it was founded by the Dutch in 1624. It was renamed New York in 1664 after the English took control of the colony and named it after the Duke of York."),
    HistoricalFact(
        fact:
            "The Statue of Liberty, a gift from France, was dedicated on October 28, 1886. It has since become a symbol of freedom and democracy."),
    HistoricalFact(
        fact:
            "In 1898, New York City consolidated with Brooklyn, Queens, the Bronx, and Staten Island to form the five boroughs that make up the city today."),
    HistoricalFact(
        fact:
            "Ellis Island, opened in 1892, served as the primary immigration station for the United States until 1954, processing over 12 million immigrants."),
    HistoricalFact(
        fact:
            "The Empire State Building, completed in 1931, was the tallest building in the world until 1970. It remains one of the most iconic skyscrapers in the city."),
    HistoricalFact(
        fact:
            "The Great Fire of 1835 in New York City destroyed much of Lower Manhattan, leading to significant rebuilding and modernization of the city's infrastructure."),
  ],
  coordinates: const LatLng(40.7128, -74.0060),
);
City paris = City(culturalFacts: [
  CulturalFact(
      fact:
          "Paris is home to the Louvre, the world's largest and most visited art museum. It houses approximately 38,000 objects from prehistory to the 21st century, including masterpieces like the Mona Lisa, the Venus de Milo, and the Winged Victory of Samothrace. The museum is housed in the historic Louvre Palace, originally built as a fortress in the late 12th century."),
  CulturalFact(
      fact:
          "The city is known for its café culture, with iconic cafes like Café de Flore and Les Deux Magots. These cafes have been frequented by famous intellectuals, writers, and artists such as Jean-Paul Sartre, Simone de Beauvoir, Ernest Hemingway, and Pablo Picasso. They have become symbols of Parisian social and cultural life."),
  CulturalFact(
      fact:
          "Paris Fashion Week, held biannually in spring and fall, is one of the most important events in the fashion industry. It showcases the latest collections from top designers and fashion houses such as Chanel, Louis Vuitton, and Dior. The event attracts designers, models, celebrities, and fashion enthusiasts from around the world."),
  CulturalFact(
      fact:
          "The Paris Opera, founded in 1669 by King Louis XIV, is one of the oldest and most prestigious opera companies in the world. It operates two historic venues: the Palais Garnier, a 19th-century architectural masterpiece, and the modern Opéra Bastille, which opened in 1989. The Paris Opera is renowned for its world-class productions of opera and ballet."),
  CulturalFact(
      fact:
          "The annual Fête de la Musique, held on June 21st, is a city-wide celebration of music. Founded in Paris in 1982 by the French Ministry of Culture, the festival encourages musicians of all levels and genres to perform in public spaces. The event has since spread to cities around the world, promoting the joy of music and cultural exchange.")
], geographicalFacts: [
  GeographicalFact(
      fact:
          "Paris is situated on the River Seine, which flows for 777 kilometers (483 miles) from eastern France through the city and into the English Channel. The river divides Paris into the Left Bank (Rive Gauche) and the Right Bank (Rive Droite), each with its own distinct character and cultural landmarks."),
  GeographicalFact(
      fact:
          "The city covers an area of 105 square kilometers (41 square miles) and is relatively flat, with its highest point being Montmartre at 130 meters (427 feet) above sea level. Montmartre is famous for its bohemian atmosphere, historic windmills, and the iconic Sacré-Cœur Basilica, which offers panoramic views of the city."),
  GeographicalFact(
      fact:
          "Paris is divided into 20 administrative districts called 'arrondissements', each with its own unique character and attractions. The arrondissements are numbered in a spiral pattern starting from the center of the city, with the 1st arrondissement containing the Louvre and the 18th arrondissement housing Montmartre."),
  GeographicalFact(
      fact:
          "The Bois de Boulogne and Bois de Vincennes are two large parks located on the western and eastern edges of Paris, respectively. The Bois de Boulogne covers 845 hectares (2,090 acres) and features lakes, gardens, and sporting facilities, while the Bois de Vincennes, covering 995 hectares (2,459 acres), includes a zoo, a botanical garden, and a medieval fortress."),
  GeographicalFact(
      fact:
          "The Île de la Cité and Île Saint-Louis are two natural islands in the Seine River at the heart of Paris. Île de la Cité is home to historic landmarks such as Notre-Dame Cathedral and the Sainte-Chapelle, while Île Saint-Louis is known for its elegant 17th-century townhouses and charming, narrow streets.")
], historicalFacts: [
  HistoricalFact(
      fact:
          "Paris was originally a Roman city called 'Lutetia'. It was established on the Île de la Cité around the 1st century BC and gradually expanded over the centuries. The name 'Lutetia' was changed to 'Paris' in the 4th century, derived from the Parisii, a Celtic tribe that inhabited the region."),
  HistoricalFact(
      fact:
          "The storming of the Bastille on July 14, 1789, marked the beginning of the French Revolution. The Bastille was a medieval fortress and prison in Paris, symbolizing the tyranny of the Bourbon monarchy. Its fall is commemorated annually as Bastille Day, a national holiday in France, celebrated with parades, fireworks, and parties."),
  HistoricalFact(
      fact:
          "The Eiffel Tower, built by engineer Gustave Eiffel for the 1889 Exposition Universelle (World's Fair), was initially intended to be dismantled after 20 years. Standing at 324 meters (1,063 feet) tall, it was the tallest man-made structure in the world until the completion of the Chrysler Building in New York in 1930."),
  HistoricalFact(
      fact:
          "Notre-Dame Cathedral, a masterpiece of French Gothic architecture, began construction in 1163 and was completed in 1345. The cathedral is famous for its stunning facade, intricate sculptures, and beautiful stained glass windows. In 2019, a devastating fire caused significant damage to the structure, sparking a global effort to restore it."),
  HistoricalFact(
      fact:
          "The Treaty of Versailles, signed on June 28, 1919, in the Hall of Mirrors at the Palace of Versailles, officially ended World War I. The treaty imposed heavy reparations and territorial losses on Germany, which contributed to the economic and political instability that led to World War II.")
], coordinates: LatLng(48.8566, 2.3522));
City london = City(culturalFacts: [
  CulturalFact(
      fact:
          "London is renowned for its theater scene, centered around the West End, where famous theaters like the Royal Opera House and the Globe Theatre are located. The West End is often compared to Broadway in New York City."),
  CulturalFact(
      fact:
          "The Notting Hill Carnival, held annually in August, is Europe's largest street festival. It celebrates Caribbean culture with vibrant parades, music, dancing, and food."),
  CulturalFact(
      fact:
          "London has a diverse culinary scene, featuring cuisine from all over the world. Borough Market, one of the city's oldest food markets, is a popular destination for gourmet food lovers."),
  CulturalFact(
      fact:
          "The city is home to numerous world-class museums and galleries, including the Tate Modern, the National Gallery, and the Victoria and Albert Museum, all of which offer free admission to their permanent collections."),
  CulturalFact(
      fact:
          "London hosts a variety of prestigious cultural events, such as the Proms, an annual eight-week summer season of daily orchestral classical music concerts held at the Royal Albert Hall.")
], geographicalFacts: [
  GeographicalFact(
      fact:
          "London is situated on the River Thames in southeastern England. The river has historically been a major trade route and the reason for the city's initial settlement and growth."),
  GeographicalFact(
      fact:
          "The Greater London area is divided into 32 boroughs, each with its own local government. Notable boroughs include Westminster, Camden, and Kensington and Chelsea."),
  GeographicalFact(
      fact:
          "Hyde Park, one of London's largest parks, covers 350 acres and is home to the Serpentine Lake, Speakers' Corner, and numerous memorials and statues."),
  GeographicalFact(
      fact:
          "London's climate is classified as temperate maritime, with mild temperatures and moderate rainfall throughout the year. The city experiences occasional heatwaves in the summer and rare snowfall in the winter."),
  GeographicalFact(
      fact:
          "London's skyline features a mix of historic and modern architecture. Iconic landmarks include the Houses of Parliament, the Shard, the Gherkin, and St. Paul's Cathedral.")
], historicalFacts: [
  HistoricalFact(
      fact:
          "London was founded by the Romans, who called it Londinium, around AD 50. It became an important commercial center and eventually grew to be the capital of Roman Britain."),
  HistoricalFact(
      fact:
          "The Great Fire of London in 1666 destroyed a large part of the city. It started in a bakery on Pudding Lane and lasted for four days, leading to the reconstruction of many buildings and the creation of modern fire-fighting techniques."),
  HistoricalFact(
      fact:
          "During the Blitz in World War II, London was heavily bombed by the German Luftwaffe. The city endured 57 consecutive nights of bombing from September 1940 to May 1941, resulting in significant destruction and loss of life."),
  HistoricalFact(
      fact:
          "The Tower of London, established by William the Conqueror in 1066, has served variously as a royal palace, prison, and treasury. It is also home to the Crown Jewels."),
  HistoricalFact(
      fact:
          "The British Museum, founded in 1753, houses a vast collection of world art and artifacts, including the Rosetta Stone and the Elgin Marbles. It was the first public national museum in the world.")
], coordinates: LatLng(51.5074, -0.1278));

List<Place> newYorkPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Statue of Liberty",
    details:
        "A colossal neoclassical sculpture on Liberty Island in New York Harbor, it is a symbol of freedom and democracy.",
    latitude: 40.6892,
    longitude: -74.0445,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Central Park",
    details:
        "A large public park in New York City, featuring various attractions such as the Central Park Zoo, boating, and numerous walking trails.",
    latitude: 40.7851,
    longitude: -73.9683,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Times Square",
    details:
        "A major commercial intersection and neighborhood in Midtown Manhattan, known for its bright lights, Broadway theaters, and electronic billboards.",
    latitude: 40.7580,
    longitude: -73.9855,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Empire State Building",
    details:
        "A 102-story Art Deco skyscraper in Midtown Manhattan, it offers stunning views of the city from its observation decks.",
    latitude: 40.7488,
    longitude: -73.9857,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Brooklyn Bridge",
    details:
        "A hybrid cable-stayed/suspension bridge connecting the boroughs of Manhattan and Brooklyn, it is an iconic part of the New York City skyline.",
    latitude: 40.7061,
    longitude: -73.9969,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Metropolitan Museum of Art",
    details:
        "The largest art museum in the United States, it has an extensive collection of art from around the world, spanning 5,000 years.",
    latitude: 40.7794,
    longitude: -73.9632,
  ),
];
List<Place> parisPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Eiffel Tower",
    details:
        "The Eiffel Tower is a wrought iron lattice tower on the Champ de Mars in Paris, France. It is named after the engineer Gustave Eiffel, whose company designed and built the tower.",
    latitude: 48.8584,
    longitude: 2.2945,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Notre-Dame Cathedral",
    details:
        "Notre-Dame de Paris, often referred to simply as Notre-Dame, is a medieval Catholic cathedral on the Île de la Cité in the 4th arrondissement of Paris. The cathedral is considered to be one of the finest examples of French Gothic architecture.",
    latitude: 48.8530,
    longitude: 2.3499,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Louvre Museum",
    details:
        "The Louvre is the world's largest art museum and a historic monument in Paris, France. A central landmark of the city, it is located on the Right Bank of the Seine in the 1st arrondissement.",
    latitude: 48.8606,
    longitude: 2.3376,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Montmartre",
    details:
        "Montmartre is a large hill in Paris's 18th arrondissement. It is known for its artistic history, the white-domed Basilica of the Sacré-Cœur on its summit, and as a nightclub district.",
    latitude: 48.8867,
    longitude: 2.3431,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Champs-Élysées",
    details:
        "The Avenue des Champs-Élysées is an avenue in the 8th arrondissement of Paris, France, running between the Place de la Concorde and the Place Charles de Gaulle, where the Arc de Triomphe is located.",
    latitude: 48.8698,
    longitude: 2.3075,
  ),
];
List<Place> londonPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Tower of London",
    details:
        "A historic castle located on the north bank of the River Thames. It has served variously as a royal palace, prison, and treasury. The Tower is home to the Crown Jewels of England.",
    latitude: 51.5081,
    longitude: -0.0759,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Buckingham Palace",
    details:
        "The London residence and administrative headquarters of the monarch of the United Kingdom. It has been a focal point for the British people at times of national rejoicing and mourning.",
    latitude: 51.5014,
    longitude: -0.1419,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "The British Museum",
    details:
        "One of the largest and most comprehensive museums in the world, dedicated to human history, art, and culture. It houses a vast collection of works spanning over two million years of history.",
    latitude: 51.5194,
    longitude: -0.1270,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Big Ben and the Houses of Parliament",
    details:
        "The iconic clock tower of the Palace of Westminster, known as Big Ben, is a symbol of London. The Houses of Parliament are where the UK's government meets.",
    latitude: 51.5007,
    longitude: -0.1246,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "The London Eye",
    details:
        "A giant Ferris wheel situated on the South Bank of the River Thames. It offers stunning views of the London skyline and is one of the most popular tourist attractions in the city.",
    latitude: 51.5033,
    longitude: -0.1195,
  ),
];
