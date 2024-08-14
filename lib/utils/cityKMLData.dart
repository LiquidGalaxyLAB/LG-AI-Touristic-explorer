import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lg_ai_touristic_explorer/models/city.dart';
import 'package:lg_ai_touristic_explorer/models/culture_fact.dart';
import 'package:lg_ai_touristic_explorer/models/geographic_fact.dart';
import 'package:lg_ai_touristic_explorer/models/history_fact.dart';

import '../constants/images.dart';
import '../models/place.dart';

String cityOutline = 'city_outline';
String historicalMap = 'historical_map';

const Map<String, String> placeImage = {
  'atlanta':
      "https://upload.wikimedia.org/wikipedia/commons/7/70/Atlanta_cityscape.jpg",
  'amsterdam':
      "https://upload.wikimedia.org/wikipedia/commons/5/57/Imagen_de_los_canales_conc%C3%A9ntricos_en_%C3%81msterdam.png",
  'anchorage':
      "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/10/2d/b6/anchorage.jpg?w=1400&h=1400&s=1",
  'austin':
      "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/View_of_Downtown_Austin_from_Pfluger_Pedestrian_Bridge_October_2022.jpg/640px-View_of_Downtown_Austin_from_Pfluger_Pedestrian_Bridge_October_2022.jpg",
  'bangalore':
      "https://lp-cms-production.imgix.net/2019-06/9483508eeee2b78a7356a15ed9c337a1-bengaluru-bangalore.jpg",
  'barcelona':
      "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Aerial_view_of_Barcelona%2C_Spain_%2851227309370%29_%28cropped%29.jpg/800px-Aerial_view_of_Barcelona%2C_Spain_%2851227309370%29_%28cropped%29.jpg",
  'berlin':
      "https://i.natgeofe.com/n/9e138c12-712d-41d4-9be9-5822a3251b5a/brandenburggate-berlin-germany.jpg",
  'boston':
      "https://www.travelandleisure.com/thmb/_aMbik8KZYsUKc_6_XNeAOzPi84=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/boston-massachusetts-BOSTONTG0221-719aef2eeb1c4929b6c839715e34a69e.jpg",
  'dallas':
      "https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/View_of_Dallas_from_Reunion_Tower_August_2015_13.jpg/288px-View_of_Dallas_from_Reunion_Tower_August_2015_13.jpg",
  'dubai':
      "https://i.natgeofe.com/n/f3d0b742-5bef-4665-87e8-61ef82a0101c/dubai-travel.jpg?w=2520&h=1680",
  'dublin':
      "https://a.travel-assets.com/findyours-php/viewfinder/images/res70/526000/526792-dublin.jpg",
  'geneva':
      "https://imageio.forbes.com/specials-images/imageserve/64ac34ee42201c1ee4edfb01/0x0.jpg?format=jpg&height=600&width=1200&fit=bounds",
  'honolulu':
      "https://i.natgeofe.com/n/75f2a750-9044-41c2-8f61-ccf1ec8710aa/waikki-beach-honolulu-hawaii_16x9.jpg",
  'london':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Palace_of_Westminster_from_the_dome_on_Methodist_Central_Hall_%28cropped%29.jpg/900px-Palace_of_Westminster_from_the_dome_on_Methodist_Central_Hall_%28cropped%29.jpg',
  'losangeles':
      "https://media.tacdn.com/media/attractions-content--1x-1/10/47/5a/bf.jpg",
  'madrid':
      "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Gran_V%C3%ADa_%28Madrid%29_1.jpg/1200px-Gran_V%C3%ADa_%28Madrid%29_1.jpg",
  'manila':
      "https://upload.wikimedia.org/wikipedia/commons/b/b4/Makati_City_Lights2_%28Jopet_Sy%29_-_Flickr.jpg",
  'melbourne':
      "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Melburnian_Skyline_b.jpg/1200px-Melburnian_Skyline_b.jpg",
  'miami':
      "https://i.natgeofe.com/n/5de6e34a-d550-4358-b7ef-4d79a09c680e/aerial-beach-miami-florida_16x9.jpg",
  'milan':
      "https://cdn.britannica.com/32/20032-050-B0CF9E76/Shoppers-Galleria-Vittorio-Emanuele-II-Italy-Milan.jpg",
  'moscow':
      "https://content.r9cdn.net/rimg/dimg/b0/1c/7746c81c-city-14713-163f5192361.jpg?width=1366&height=768&xhint=1535&yhint=594&crop=true",
  'newyork':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/View_of_Empire_State_Building_from_Rockefeller_Center_New_York_City_dllu_%28cropped%29.jpg/800px-View_of_Empire_State_Building_from_Rockefeller_Center_New_York_City_dllu_%28cropped%29.jpg',
  'nice':
      "https://ik.imgkit.net/3vlqs5axxjf/external/http://images.ntmllc.com/v4/destination/France/Nice/220608_SCN_Nice_iStock486761941_Z98854.jpg?tr=w-1200%2Cfo-auto",
  'paris':
      'https://images.adsttc.com/media/images/5d44/14fa/284d/d1fd/3a00/003d/large_jpg/eiffel-tower-in-paris-151-medium.jpg?1564742900',
  'sanfrancisco':
      "https://content.r9cdn.net/rimg/dimg/69/1b/cca1e76b-city-13852-1633ad11236.jpg?width=1366&height=768&xhint=1966&yhint=1018&crop=true",
  'seattle':
      "https://uploads.visitseattle.org/2023/01/11122537/Banner_rachael-jones-media_aerial-destination-photos-24_3.jpg",
  'sydney':
      "https://media.tatler.com/photos/6141d37b9ce9874a3e40107d/16:9/w_2560%2Cc_limit/social_crop_sydney_opera_house_gettyimages-869714270.jpg",
  'toronto':
      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/CC_2022-06-18_193-Pano_%28cropped%29_01.jpg/640px-CC_2022-06-18_193-Pano_%28cropped%29_01.jpg",
  'vienna':
      "https://www.travelandleisure.com/thmb/zFpjulihpXjpUV7gKNHzydvJANA=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/vienna-austria-VIENNATG0621-ecb0ee926c2d49c4bce610db594f7405.jpg",
  'zurich':
      "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/33/f9/30/zurich.jpg?w=1400&h=1400&s=1",
  'baltimore':
      "https://upload.wikimedia.org/wikipedia/commons/2/26/Fell%27s_Point_Aerial_2022.jpg",
  'chicago':
      "https://www.redfin.com/blog/wp-content/uploads/2023/05/Chicago-river.jpg",
  'detroit':
      "https://lp-cms-production.imgix.net/2023-04/detroit-GettyImages-1407950728-rfc.jpeg?sharp=10&vib=20&w=1200&w=600&h=400",
  'mumbai':
      "https://static01.nyt.com/images/2024/04/06/travel/28hours-mumbai-01-qkwb/28hours-mumbai-01-qkwb-videoSixteenByNine3000.jpg",
  'washingtondc':
      "https://cdn.britannica.com/42/93842-050-295D32A0/US-Capitol-place-meeting-Congress-Washington-DC.jpg",
};

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
      "link":
          "https://drive.google.com/uc?export=download&id=11vpUbEtsrXbB06-T-sVCrq7T_-NuHtmR",
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
      "link":
          "https://drive.google.com/uc?export=download&id=13cYEQH_rJ4SvRh8sXkSBfwrdEGAQ3Gqv",
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
      "link":
          "https://drive.google.com/uc?export=download&id=1PuqvLZCK8W4525o1uh5vTEBozdFh0Yx1",
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
      "link":
          "https://drive.google.com/uc?export=download&id=1tcaIfzH0eDuw7sRGq1I2h2df6h5S5IQ-",
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
      "link":
          "https://drive.google.com/uc?export=download&id=1oWqqFZS8hJfZ8OOcdhI-vIyj5m5DHx2g",
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
      "link":
          "https://drive.google.com/uc?export=download&id=13evsw59yxaTDUO0b3Gxyed7nni_mxAgl",
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
      "link":
          "https://drive.google.com/uc?export=download&id=1SqqllW1AGMm9w8D0-HZqLe9dfF01CsWk",
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
      "link":
          "https://drive.google.com/uc?export=download&id=1UHDL7j_dUdiazajLAd8fdNLqfkC7L7IK",
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
      "link":
          "https://drive.google.com/uc?export=download&id=1noJnKdQP7vU-nZt5u2RwrY4-an27kOlr",
      "type": "historicalMap",
      "description":
          "Baltimore. Founded in 1729, Baltimore played a key role in American history as a major seaport and industrial center. It was a key player in the War of 1812 and later became a hub of immigration and manufacturing. Baltimore’s diverse neighborhoods and rich cultural heritage have shaped its identity as a dynamic urban center."
    }
  ],
  "chicago": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1xUqvuyrCUT1i-fRN29izDavFAnNo_pkj",
      "type": "historicalMap",
      "description":
          "Chicago. Founded in the 1830s, Chicago grew rapidly due to its strategic location for trade and transportation. It became a major center for industry, finance, and culture, known for its architecture, jazz music, and deep-dish pizza. Chicago’s history includes the Great Fire of 1871 and its rebirth as a modern metropolis."
    }
  ],
  "detroit": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1pCQ3Kjkl7jZ3t0-_XZavy8vNA80N0KEl",
      "type": "historicalMap",
      "description":
          "Detroit. Founded in 1701, Detroit became a major industrial center known for its automotive industry and Motown sound. The city played a crucial role in World War II production and later faced economic challenges and urban decay. Detroit’s cultural diversity and resilience have shaped its ongoing revitalization efforts."
    }
  ],
  "mumbai": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1_N1XzyCPjOTRGhEo0I0I8uw4SoEwr3mK",
      "type": "historicalMap",
      "description":
          "Mumbai, formerly known as Bombay, is the financial and entertainment capital of India. It has a rich history as a trading port and cultural melting pot, influenced by its colonial past and diverse population. Mumbai is known for Bollywood films, historic landmarks like the Gateway of India, and vibrant street life."
    }
  ],
  "washingtondc": [
    {
      "link":
          "https://drive.google.com/uc?export=download&id=1-VSisUw36VbtXu5QBtPhFKAdrD8FtFad",
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
City losAngeles = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Los Angeles is home to Hollywood, the epicenter of the entertainment industry, producing the majority of films, television shows, and music worldwide."),
    CulturalFact(
        fact:
            "The Getty Center, opened in 1997, is a major cultural landmark, housing an extensive collection of European paintings, drawings, sculpture, illuminated manuscripts, and decorative arts."),
    CulturalFact(
        fact:
            "Los Angeles hosts the annual Grammy Awards, the premier music award ceremony in the world, attracting top musicians and celebrities."),
    CulturalFact(
        fact:
            "The city is known for its diverse culinary scene, with a wide range of international cuisines available, reflecting its multicultural population."),
    CulturalFact(
        fact:
            "LA's Venice Beach is famous for its bohemian spirit, street performers, and Muscle Beach outdoor gym."),
    CulturalFact(
        fact:
            "The Los Angeles County Museum of Art (LACMA) is the largest art museum in the western United States, boasting a diverse collection that spans from ancient times to the present."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Los Angeles is located in a large coastal basin, surrounded by mountains on three sides, making it a unique geographic and climatic zone."),
    GeographicalFact(
        fact:
            "The city has a Mediterranean climate with mild, wet winters and hot, dry summers, contributing to its popularity as a year-round destination."),
    GeographicalFact(
        fact:
            "Griffith Park, one of the largest urban parks in North America, offers hiking trails, the Griffith Observatory, and panoramic views of the city."),
    GeographicalFact(
        fact:
            "The LA River, running through the city, has been undergoing revitalization efforts to transform it into a recreational and natural habitat area."),
    GeographicalFact(
        fact:
            "Los Angeles' coastline stretches for 75 miles, featuring famous beaches like Malibu, Santa Monica, and Venice."),
    GeographicalFact(
        fact:
            "The San Gabriel and Santa Monica mountain ranges provide a scenic backdrop and opportunities for outdoor activities."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Los Angeles was founded on September 4, 1781, by Spanish governor Felipe de Neve and was originally named El Pueblo de Nuestra Señora la Reina de los Ángeles de Porciúncula."),
    HistoricalFact(
        fact:
            "The city experienced a massive population boom in the early 20th century, driven by the discovery of oil and the growth of the entertainment industry."),
    HistoricalFact(
        fact:
            "The Hollywood Sign, originally reading 'Hollywoodland,' was erected in 1923 to promote a real estate development. It was later shortened to 'Hollywood' and became an iconic symbol."),
    HistoricalFact(
        fact:
            "The Watts Riots in 1965 were a significant event in LA's history, highlighting racial tensions and leading to major civil rights reforms."),
    HistoricalFact(
        fact:
            "The Los Angeles Aqueduct, completed in 1913, brought water from the Owens Valley to the city, enabling its growth and development."),
    HistoricalFact(
        fact:
            "The 1984 Summer Olympics, held in Los Angeles, were highly successful and are remembered for their financial and operational efficiency."),
  ],
  coordinates: const LatLng(34.0522, -118.2437),
);
City miami = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Miami is known for its vibrant art scene, highlighted by the annual Art Basel Miami Beach, one of the most prestigious art shows in the Americas."),
    CulturalFact(
        fact:
            "The city is a melting pot of cultures, heavily influenced by its large Cuban-American community, and is often called the 'Capital of Latin America.'"),
    CulturalFact(
        fact:
            "Miami's South Beach is renowned for its Art Deco Historic District, featuring pastel-colored buildings and a lively nightlife."),
    CulturalFact(
        fact:
            "The Pérez Art Museum Miami (PAMM) showcases contemporary art from around the world, focusing on the cultures of the Atlantic Rim."),
    CulturalFact(
        fact:
            "The Miami International Film Festival, held annually, draws filmmakers and audiences from around the globe, celebrating cinema in various languages."),
    CulturalFact(
        fact:
            "Little Havana, a neighborhood in Miami, is famous for its Cuban culture, including its vibrant street life, music, and cuisine."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Miami is located on the southeastern coast of Florida, bordered by the Atlantic Ocean to the east and the Everglades to the west."),
    GeographicalFact(
        fact:
            "The city has a tropical monsoon climate, characterized by hot, humid summers and warm, dry winters, making it a popular destination for tourists."),
    GeographicalFact(
        fact:
            "Miami Beach, a separate municipality, is connected to Miami by a series of bridges and is famous for its sandy beaches and glamorous lifestyle."),
    GeographicalFact(
        fact:
            "Biscayne Bay, separating Miami from Miami Beach, is a key feature of the city's geography, providing opportunities for boating, fishing, and water sports."),
    GeographicalFact(
        fact:
            "The Miami River flows through the city and into Biscayne Bay, playing a vital role in the city's history and development as a port."),
    GeographicalFact(
        fact:
            "The city is susceptible to hurricanes due to its coastal location, with hurricane season running from June to November."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Miami was officially incorporated as a city on July 28, 1896, with a population of just over 300. It has since grown to become a major metropolis."),
    HistoricalFact(
        fact:
            "The city experienced a major real estate boom in the 1920s, leading to rapid development and the construction of many historic buildings."),
    HistoricalFact(
        fact:
            "During the 1980s, Miami became a center of drug trafficking and related crime, leading to significant social and economic challenges."),
    HistoricalFact(
        fact:
            "The Mariel boatlift in 1980 saw an influx of Cuban immigrants to Miami, significantly impacting the city's demographics and culture."),
    HistoricalFact(
        fact:
            "In the early 20th century, Miami was a popular destination for wealthy Northerners seeking to escape cold winters, contributing to its development as a tourist hub."),
    HistoricalFact(
        fact:
            "The opening of the Miami International Airport in 1928 helped establish the city as a major gateway to Latin America and the Caribbean."),
  ],
  coordinates: const LatLng(25.7617, -80.1918),
);
City sanFrancisco = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "San Francisco is renowned for its vibrant arts and cultural scene, including iconic institutions like the San Francisco Museum of Modern Art (SFMOMA)."),
    CulturalFact(
        fact:
            "The city is famous for its diverse neighborhoods, such as Chinatown, the oldest and one of the largest in North America, and the Mission District, known for its Latino culture and murals."),
    CulturalFact(
        fact:
            "San Francisco hosts the annual San Francisco International Film Festival, the longest-running film festival in the Americas."),
    CulturalFact(
        fact:
            "The Fillmore District is known as the 'Harlem of the West' due to its historic jazz clubs and African American cultural contributions."),
    CulturalFact(
        fact:
            "The city is a major center for the tech industry, with nearby Silicon Valley home to many of the world's largest tech companies."),
    CulturalFact(
        fact:
            "San Francisco's culinary scene is renowned for its innovation and diversity, with a strong emphasis on farm-to-table dining."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "San Francisco is located on the northern tip of the San Francisco Peninsula, surrounded by the Pacific Ocean and San Francisco Bay."),
    GeographicalFact(
        fact:
            "The city is famous for its steep hills, with over 50 hills within its limits, including well-known ones like Nob Hill, Russian Hill, and Telegraph Hill."),
    GeographicalFact(
        fact:
            "San Francisco's climate is characterized by cool summers and mild winters, influenced by the cold California Current and frequent coastal fog."),
    GeographicalFact(
        fact:
            "The Golden Gate Bridge, one of the most recognizable landmarks in the world, connects San Francisco to Marin County."),
    GeographicalFact(
        fact:
            "Alcatraz Island, located in San Francisco Bay, is famous for its historic federal prison and is now a popular tourist attraction."),
    GeographicalFact(
        fact:
            "The San Andreas Fault, a major tectonic boundary, runs just to the west of San Francisco, making the city prone to earthquakes."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "San Francisco was founded on June 29, 1776, by Spanish colonists who established the Presidio of San Francisco and the Mission San Francisco de Asís."),
    HistoricalFact(
        fact:
            "The California Gold Rush of 1849 brought rapid growth and wealth to San Francisco, transforming it into a bustling city almost overnight."),
    HistoricalFact(
        fact:
            "The 1906 San Francisco earthquake and subsequent fires destroyed much of the city, leading to extensive rebuilding efforts."),
    HistoricalFact(
        fact:
            "The city played a significant role during World War II as a major embarkation point for service members shipping out to the Pacific Theater."),
    HistoricalFact(
        fact:
            "The Summer of Love in 1967, centered in San Francisco's Haight-Ashbury neighborhood, was a defining moment in the counterculture movement."),
    HistoricalFact(
        fact:
            "San Francisco was a pioneer in the LGBT rights movement, with the Castro District becoming a prominent center for LGBT culture and activism."),
  ],
  coordinates: const LatLng(37.7749, -122.4194),
);

City seattle = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Seattle is known for its vibrant music scene, particularly as the birthplace of grunge music in the early 1990s, with bands like Nirvana and Pearl Jam."),
    CulturalFact(
        fact:
            "The city hosts the Seattle International Film Festival (SIFF), one of the longest-running and most highly attended film festivals in the United States."),
    CulturalFact(
        fact:
            "Pike Place Market, established in 1907, is one of the oldest continuously operated public farmers' markets in the United States."),
    CulturalFact(
        fact:
            "Seattle is home to the Space Needle, an iconic observation tower built for the 1962 World's Fair, symbolizing the city's futuristic spirit."),
    CulturalFact(
        fact:
            "The Seattle Art Museum (SAM) houses an impressive collection of art from around the world, including modern and contemporary pieces."),
    CulturalFact(
        fact:
            "Seattle's diverse culinary scene is famous for its seafood, particularly salmon, which is celebrated at the annual Ballard SeafoodFest."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Seattle is located in the Pacific Northwest region of the United States, between Puget Sound and Lake Washington."),
    GeographicalFact(
        fact:
            "The city is surrounded by water, mountains, and evergreen forests, giving it the nickname 'The Emerald City.'"),
    GeographicalFact(
        fact:
            "Mount Rainier, an active stratovolcano, is located about 60 miles southeast of Seattle and is a prominent feature of the skyline."),
    GeographicalFact(
        fact:
            "Seattle is built on seven hills, which include Capitol Hill, First Hill, and Queen Anne Hill."),
    GeographicalFact(
        fact:
            "The city has an extensive network of parks, with Discovery Park being the largest, spanning 534 acres."),
    GeographicalFact(
        fact:
            "Seattle's Port is one of the busiest in the United States, serving as a major gateway for trade with Asia."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Seattle was founded on November 13, 1851, by Arthur A. Denny and his group of travelers known as the Denny Party."),
    HistoricalFact(
        fact:
            "The Great Seattle Fire of 1889 destroyed much of the city's central business district, leading to a massive reconstruction effort."),
    HistoricalFact(
        fact:
            "The Klondike Gold Rush of 1897 brought an influx of people and wealth to Seattle, significantly boosting its economy."),
    HistoricalFact(
        fact:
            "Boeing, founded in Seattle in 1916, played a crucial role in the city's development as a center for aerospace and technology."),
    HistoricalFact(
        fact:
            "In 1999, Seattle hosted the World Trade Organization (WTO) Ministerial Conference, which was marked by significant protests."),
    HistoricalFact(
        fact:
            "Seattle was one of the first major U.S. cities to elect a woman as mayor, with Bertha Knight Landes serving from 1926 to 1928."),
  ],
  coordinates: const LatLng(47.6062, -122.3321),
);

City chicago = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Chicago is renowned for its deep-dish pizza, a culinary creation that has become one of the city's most famous foods."),
    CulturalFact(
        fact:
            "The city is home to the Chicago Symphony Orchestra, one of the leading orchestras in the world."),
    CulturalFact(
        fact:
            "Chicago is known for its impressive skyline, which includes iconic buildings like the Willis Tower (formerly Sears Tower) and the John Hancock Center."),
    CulturalFact(
        fact:
            "The Art Institute of Chicago houses a vast collection of artworks, including famous pieces like Grant Wood's 'American Gothic' and Georges Seurat's 'A Sunday on La Grande Jatte.'"),
    CulturalFact(
        fact:
            "Chicago hosts the annual Taste of Chicago, the world's largest food festival, attracting millions of visitors each year."),
    CulturalFact(
        fact:
            "The city is a major hub for jazz and blues music, with a rich history of legendary musicians and venues."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Chicago is located in northeastern Illinois on the southwestern shores of Lake Michigan, one of the five Great Lakes."),
    GeographicalFact(
        fact:
            "The Chicago River, which flows through the city, is known for its unique reversal in 1900 to improve sanitation and water quality."),
    GeographicalFact(
        fact:
            "Lake Michigan provides Chicago with 26 miles of public beaches, making it a popular destination for water sports and recreation."),
    GeographicalFact(
        fact:
            "The city covers an area of 234 square miles, making it the third-largest city in the United States by area."),
    GeographicalFact(
        fact:
            "Chicago's extensive park system includes over 600 parks, with Lincoln Park being the largest, spanning 1,200 acres."),
    GeographicalFact(
        fact:
            "The city's climate is classified as humid continental, with hot summers and cold, snowy winters."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Chicago was incorporated as a city on March 4, 1837, and grew rapidly in the 19th century due to its strategic location and transportation networks."),
    HistoricalFact(
        fact:
            "The Great Chicago Fire of 1871 destroyed much of the city, leading to a significant rebuilding effort and the development of modern skyscrapers."),
    HistoricalFact(
        fact:
            "The World's Columbian Exposition, held in Chicago in 1893, celebrated the 400th anniversary of Christopher Columbus's arrival in the New World."),
    HistoricalFact(
        fact:
            "Chicago played a major role in the Prohibition era, with infamous gangsters like Al Capone dominating the city's criminal underworld."),
    HistoricalFact(
        fact:
            "In 1968, Chicago was the site of significant protests and clashes during the Democratic National Convention, highlighting the social and political turmoil of the era."),
    HistoricalFact(
        fact:
            "The Chicago Bulls, led by Michael Jordan, won six NBA championships in the 1990s, solidifying the city's reputation in the sports world."),
  ],
  coordinates: const LatLng(41.8781, -87.6298),
);

City washingtonDC = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Washington DC is home to numerous national museums and monuments, including the Smithsonian Institution, which comprises 19 museums and galleries."),
    CulturalFact(
        fact:
            "The city hosts the annual National Cherry Blossom Festival, celebrating the gift of cherry trees from Japan in 1912."),
    CulturalFact(
        fact:
            "The Kennedy Center Honors is an annual event recognizing outstanding contributions to American culture in the performing arts."),
    CulturalFact(
        fact:
            "Washington DC's theater scene includes the renowned Ford's Theatre, where President Abraham Lincoln was assassinated in 1865."),
    CulturalFact(
        fact:
            "The National Mall, a large park in downtown DC, is a central location for numerous cultural and political events."),
    CulturalFact(
        fact:
            "The city is known for its vibrant and diverse food scene, with a significant influence from international cuisines."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Washington DC is located on the east bank of the Potomac River, bordered by Maryland to the north and Virginia to the south."),
    GeographicalFact(
        fact:
            "The city covers an area of 68 square miles, making it one of the smallest by area in the United States."),
    GeographicalFact(
        fact:
            "Washington DC's climate is classified as humid subtropical, with hot summers and mild winters."),
    GeographicalFact(
        fact:
            "The city is divided into four quadrants: Northwest, Northeast, Southwest, and Southeast, with the US Capitol serving as the central point."),
    GeographicalFact(
        fact:
            "Rock Creek Park, spanning over 1,700 acres, is one of the largest urban parks in the country and offers numerous recreational opportunities."),
    GeographicalFact(
        fact:
            "The Anacostia River flows through the city and is a key feature of its geography and history."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Washington DC was established as the capital of the United States in 1790 and officially became the federal district in 1801."),
    HistoricalFact(
        fact:
            "The White House, the official residence of the President of the United States, has been the home of every US president since John Adams in 1800."),
    HistoricalFact(
        fact:
            "The US Capitol building, completed in 1800, is the seat of the United States Congress and a symbol of American democracy."),
    HistoricalFact(
        fact:
            "The Lincoln Memorial, dedicated in 1922, honors President Abraham Lincoln and is a significant site for civil rights events."),
    HistoricalFact(
        fact:
            "The March on Washington for Jobs and Freedom, where Martin Luther King Jr. delivered his 'I Have a Dream' speech, took place in 1963 on the National Mall."),
    HistoricalFact(
        fact:
            "The Watergate scandal, leading to President Richard Nixon's resignation in 1974, centered around events at the Watergate complex in Washington DC."),
  ],
  coordinates: const LatLng(38.9072, -77.0369),
);

City austin = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Austin is known as the 'Live Music Capital of the World,' hosting more live music venues per capita than any other US city."),
    CulturalFact(
        fact:
            "The city hosts the annual South by Southwest (SXSW) festival, which celebrates music, film, and interactive media."),
    CulturalFact(
        fact:
            "Austin's Sixth Street is famous for its vibrant nightlife, live music venues, and eclectic bars and restaurants."),
    CulturalFact(
        fact:
            "The city is home to the University of Texas at Austin, one of the largest and most prestigious public universities in the United States."),
    CulturalFact(
        fact:
            "Austin is known for its diverse culinary scene, particularly its barbecue and Tex-Mex cuisine."),
    CulturalFact(
        fact:
            "The Austin City Limits Music Festival, held annually in Zilker Park, attracts top musical acts from around the world."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Austin is located in central Texas, along the Colorado River, and is part of the Texas Hill Country."),
    GeographicalFact(
        fact:
            "The city covers an area of 305 square miles, making it the fourth-largest city in Texas by area."),
    GeographicalFact(
        fact:
            "Austin's climate is classified as humid subtropical, with hot summers and mild winters."),
    GeographicalFact(
        fact:
            "The Colorado River flows through the city, creating several lakes, including Lady Bird Lake and Lake Austin."),
    GeographicalFact(
        fact:
            "The city's extensive park system includes Zilker Park, a 350-acre park offering a variety of recreational activities."),
    GeographicalFact(
        fact:
            "Austin is situated on the Balcones Fault, which separates the Texas Hill Country from the prairies to the east."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Austin was founded in 1839 and named after Stephen F. Austin, known as the 'Father of Texas.'"),
    HistoricalFact(
        fact:
            "The Texas State Capitol, completed in 1888, is taller than the US Capitol in Washington, DC, and is a major landmark in the city."),
    HistoricalFact(
        fact:
            "In 1966, the University of Texas tower shooting was one of the first mass school shootings in US history, leading to significant changes in public safety and emergency response."),
    HistoricalFact(
        fact:
            "Austin's economy has historically been based on government and education, but it has expanded significantly into technology and innovation in recent decades."),
    HistoricalFact(
        fact:
            "The city played a key role in the development of the music industry, particularly with the establishment of the Austin City Limits television show in 1974."),
    HistoricalFact(
        fact:
            "In 1991, Austin adopted the slogan 'Keep Austin Weird,' reflecting the city's eclectic and progressive culture."),
  ],
  coordinates: const LatLng(30.2672, -97.7431),
);

City mumbai = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Mumbai is the entertainment capital of India, home to Bollywood, the largest film industry in the world by number of films produced."),
    CulturalFact(
        fact:
            "The city hosts the annual Kala Ghoda Arts Festival, celebrating the rich cultural heritage of Mumbai through arts, music, dance, and theater."),
    CulturalFact(
        fact:
            "Mumbai is famous for its street food, with dishes like vada pav, pav bhaji, and bhel puri being iconic to the city's culinary scene."),
    CulturalFact(
        fact:
            "The Chhatrapati Shivaji Maharaj Vastu Sangrahalaya (formerly the Prince of Wales Museum) is one of the premier art and history museums in India."),
    CulturalFact(
        fact:
            "Mumbai's architecture is a blend of Gothic, Victorian, Art Deco, and contemporary styles, with notable buildings like the Gateway of India and Chhatrapati Shivaji Maharaj Terminus."),
    CulturalFact(
        fact:
            "Ganesh Chaturthi, a major Hindu festival, is celebrated with great fervor in Mumbai, with elaborate processions and idol immersions."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Mumbai is located on the west coast of India, along the Arabian Sea, and is composed of seven islands."),
    GeographicalFact(
        fact:
            "The city covers an area of 233 square miles, making it one of the most densely populated cities in the world."),
    GeographicalFact(
        fact:
            "Mumbai's climate is classified as tropical, with a monsoon season from June to September."),
    GeographicalFact(
        fact:
            "The city is home to Sanjay Gandhi National Park, one of the largest urban parks in the world, covering an area of 40 square miles."),
    GeographicalFact(
        fact:
            "Mumbai's coastline is characterized by numerous beaches, with Juhu Beach and Marine Drive being among the most popular."),
    GeographicalFact(
        fact:
            "The city is built on a series of reclaimed land areas, with significant portions below sea level, making it susceptible to flooding."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Mumbai, formerly known as Bombay, was originally a collection of seven islands that were joined together through land reclamation projects starting in the 18th century."),
    HistoricalFact(
        fact:
            "The Gateway of India, built in 1924, commemorates the visit of King George V and Queen Mary to Mumbai in 1911."),
    HistoricalFact(
        fact:
            "Chhatrapati Shivaji Maharaj Terminus, a UNESCO World Heritage Site, was completed in 1887 and is an architectural marvel of Victorian Gothic Revival and traditional Indian styles."),
    HistoricalFact(
        fact:
            "Mumbai played a crucial role in India's struggle for independence, with significant events such as the Quit India Movement launched by Mahatma Gandhi in 1942."),
    HistoricalFact(
        fact:
            "In 1995, the city's name was officially changed from Bombay to Mumbai to reflect its Marathi heritage and cultural identity."),
    HistoricalFact(
        fact:
            "Mumbai was the site of the devastating terrorist attacks in November 2008, which targeted multiple locations and resulted in significant loss of life and property."),
  ],
  coordinates: const LatLng(19.0760, 72.8777),
);

City amsterdam = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Amsterdam is known for its artistic heritage, with the Van Gogh Museum housing the largest collection of Van Gogh's paintings and drawings in the world."),
    CulturalFact(
        fact:
            "The city is famous for its extensive canal system, earning it the nickname 'Venice of the North'. The canals are a UNESCO World Heritage Site."),
    CulturalFact(
        fact:
            "Amsterdam hosts the annual Amsterdam Dance Event (ADE), the world's leading electronic music conference and festival."),
    CulturalFact(
        fact:
            "The Rijksmuseum in Amsterdam is the national museum of the Netherlands, showcasing masterpieces by Rembrandt, Vermeer, and other Dutch Golden Age artists."),
    CulturalFact(
        fact:
            "King's Day (Koningsdag), celebrated on April 27th, is the biggest national holiday in the Netherlands, featuring street markets, parties, and concerts throughout Amsterdam."),
    CulturalFact(
        fact:
            "Amsterdam is renowned for its liberal attitudes towards cannabis and its famous red-light district, which are major draws for tourists."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Amsterdam is located in the province of North Holland in the western part of the Netherlands, lying below sea level and featuring an intricate network of canals and dikes."),
    GeographicalFact(
        fact:
            "The city is built on approximately 90 islands connected by more than 1,200 bridges, making it one of the most interconnected cities by waterways in the world."),
    GeographicalFact(
        fact:
            "Amsterdam has a maritime climate influenced by its proximity to the North Sea, characterized by mild winters and cool summers."),
    GeographicalFact(
        fact:
            "Vondelpark, the largest city park in Amsterdam, spans 47 hectares and is a popular spot for both locals and tourists to relax and enjoy outdoor activities."),
    GeographicalFact(
        fact:
            "The city is a major hub for cycling, with an extensive network of bike paths and more bicycles than residents."),
    GeographicalFact(
        fact:
            "Amsterdam's Schiphol Airport, located about 15 kilometers southwest of the city center, is one of the busiest airports in Europe."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Amsterdam was founded as a small fishing village in the late 12th century and grew rapidly during the Dutch Golden Age in the 17th century as a major trade and financial center."),
    HistoricalFact(
        fact:
            "The city played a central role in the Dutch East India Company, the world's first multinational corporation, established in 1602."),
    HistoricalFact(
        fact:
            "Anne Frank, the Jewish diarist who wrote 'The Diary of a Young Girl,' hid from the Nazis in a secret annex in Amsterdam during World War II."),
    HistoricalFact(
        fact:
            "In 1636, the University of Amsterdam was established, becoming one of the most prominent research universities in Europe."),
    HistoricalFact(
        fact:
            "The construction of the Amsterdam Canal Belt (Grachtengordel) began in the early 17th century, shaping the city's distinctive layout."),
    HistoricalFact(
        fact:
            "Amsterdam was occupied by Nazi Germany during World War II from May 1940 until May 1945, suffering significant hardships and resistance."),
  ],
  coordinates: const LatLng(52.3676, 4.9041),
);

City barcelona = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Barcelona is renowned for its unique architecture, particularly the works of Antoni Gaudí, including the Sagrada Família, Park Güell, and Casa Batlló."),
    CulturalFact(
        fact:
            "The city is a major center for Catalan culture, with Catalan being one of the official languages alongside Spanish."),
    CulturalFact(
        fact:
            "Barcelona hosts the annual Festa Major de Gràcia, a week-long festival in August featuring decorated streets, music, and cultural activities."),
    CulturalFact(
        fact:
            "The city is home to FC Barcelona, one of the world's most famous football clubs, with Camp Nou being the largest stadium in Europe."),
    CulturalFact(
        fact:
            "Barcelona has a rich tradition of art and literature, with museums dedicated to Picasso and Joan Miró, among other renowned artists."),
    CulturalFact(
        fact:
            "The city's La Rambla street is a vibrant and bustling promenade, known for its shops, restaurants, and street performers."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Barcelona is located on the northeastern coast of the Iberian Peninsula, facing the Mediterranean Sea."),
    GeographicalFact(
        fact:
            "The city is surrounded by mountains, including the Serra de Collserola, which offers scenic views and outdoor activities."),
    GeographicalFact(
        fact:
            "Barcelona enjoys a Mediterranean climate, characterized by hot summers and mild winters, making it a popular destination year-round."),
    GeographicalFact(
        fact:
            "The city boasts several urban beaches, including Barceloneta Beach, which is popular for swimming, sunbathing, and water sports."),
    GeographicalFact(
        fact:
            "Montjuïc Hill is a prominent feature in Barcelona, offering cultural attractions such as the Magic Fountain, Montjuïc Castle, and several museums."),
    GeographicalFact(
        fact:
            "Barcelona's Port Vell is a historic harbor that has been transformed into a modern marina with shops, restaurants, and the Aquarium Barcelona."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Barcelona was founded as a Roman city called Barcino in the late 1st century BC."),
    HistoricalFact(
        fact:
            "The city played a key role during the Spanish Civil War (1936-1939) and was heavily bombed by Franco's forces."),
    HistoricalFact(
        fact:
            "In 1992, Barcelona hosted the Summer Olympics, which led to significant urban development and revitalization of the city's waterfront."),
    HistoricalFact(
        fact:
            "The Gothic Quarter (Barri Gòtic) is the historic center of Barcelona, featuring narrow medieval streets and ancient Roman ruins."),
    HistoricalFact(
        fact:
            "Barcelona was the capital of the Crown of Aragon, a powerful maritime kingdom in the medieval period."),
    HistoricalFact(
        fact:
            "La Mercè, Barcelona's annual festival, dates back to 1902 and honors the city's patron saint, Our Lady of Mercy."),
  ],
  coordinates: const LatLng(41.3851, 2.1734),
);

City berlin = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Berlin is known for its vibrant arts scene, with numerous galleries, theaters, and music venues, including the famous Berlin Philharmonic."),
    CulturalFact(
        fact:
            "The city hosts the annual Berlin International Film Festival (Berlinale), one of the most prestigious film festivals in the world."),
    CulturalFact(
        fact:
            "Berlin is famous for its nightlife, particularly its techno clubs such as Berghain, which attract party-goers from around the globe."),
    CulturalFact(
        fact:
            "Museum Island, located in the Spree River, is a UNESCO World Heritage Site and home to five world-renowned museums."),
    CulturalFact(
        fact:
            "The Berlin Wall, which once divided the city, is now a major cultural landmark, with sections preserved as the East Side Gallery featuring murals by artists from around the world."),
    CulturalFact(
        fact:
            "Berlin has a diverse culinary scene, with a strong tradition of street food such as currywurst and doner kebabs."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Berlin is located in northeastern Germany, on the banks of the rivers Spree and Havel."),
    GeographicalFact(
        fact:
            "The city covers an area of 891.8 square kilometers, making it nine times larger than Paris."),
    GeographicalFact(
        fact:
            "Berlin has a temperate seasonal climate, with cold winters and warm summers."),
    GeographicalFact(
        fact:
            "Tiergarten, Berlin's largest park, spans 210 hectares and offers a green oasis in the heart of the city."),
    GeographicalFact(
        fact:
            "Berlin is known for its extensive waterways, including over 180 kilometers of navigable rivers, canals, and lakes."),
    GeographicalFact(
        fact:
            "The city's public transportation system is one of the most efficient in Europe, featuring an extensive network of buses, trams, U-Bahn, and S-Bahn trains."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Berlin became the capital of the Kingdom of Prussia in 1701 and later the capital of the German Empire in 1871."),
    HistoricalFact(
        fact:
            "The city was heavily bombed during World War II, leading to extensive destruction and subsequent rebuilding."),
    HistoricalFact(
        fact:
            "Berlin was divided into East and West Berlin during the Cold War, with the Berlin Wall separating the two halves from 1961 until its fall in 1989."),
    HistoricalFact(
        fact:
            "The Brandenburg Gate, an iconic symbol of Berlin, was completed in 1791 and has witnessed many of the city's key historical events."),
    HistoricalFact(
        fact:
            "The Reichstag building, home to the German parliament, was severely damaged during World War II and later restored, with a modern glass dome added in 1999."),
    HistoricalFact(
        fact:
            "In 1990, Berlin was reunified and became the capital of a reunified Germany, marking the end of the Cold War era."),
  ],
  coordinates: const LatLng(52.5200, 13.4050),
);

City sydney = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Sydney is home to the iconic Sydney Opera House, a UNESCO World Heritage Site and one of the most distinctive buildings in the world."),
    CulturalFact(
        fact:
            "The city hosts the annual Sydney Festival, a major cultural event featuring music, dance, theater, and visual arts."),
    CulturalFact(
        fact:
            "Sydney is known for its vibrant multicultural scene, with over a third of its residents born overseas."),
    CulturalFact(
        fact:
            "The Sydney Harbour Bridge, affectionately known as 'The Coathanger,' is a famous landmark and offers a popular bridge climb experience."),
    CulturalFact(
        fact:
            "Bondi Beach, one of the most famous beaches in the world, is located in Sydney and is known for its surf culture."),
    CulturalFact(
        fact:
            "Sydney has a thriving food scene, with a strong emphasis on fresh seafood and multicultural cuisine."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Sydney is located on the southeastern coast of Australia, in the state of New South Wales."),
    GeographicalFact(
        fact:
            "The city is built around Sydney Harbour, which is known for its stunning natural beauty and is often considered one of the world's most beautiful harbors."),
    GeographicalFact(
        fact:
            "Sydney has a temperate climate, with warm summers and mild winters, making it a popular destination year-round."),
    GeographicalFact(
        fact:
            "The Blue Mountains, located to the west of Sydney, are a popular destination for hiking and outdoor activities, offering dramatic scenery and native wildlife."),
    GeographicalFact(
        fact:
            "Sydney is surrounded by national parks, providing ample opportunities for outdoor recreation and nature exploration."),
    GeographicalFact(
        fact:
            "The city is served by Sydney Kingsford Smith Airport, one of the oldest continuously operating airports in the world."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Sydney was established in 1788 as the first British colony in Australia, named after the British Home Secretary, Lord Sydney."),
    HistoricalFact(
        fact:
            "The city grew rapidly during the 19th century, driven by the discovery of gold and subsequent economic boom."),
    HistoricalFact(
        fact:
            "Sydney hosted the 2000 Summer Olympics, which brought international attention and significant development to the city."),
    HistoricalFact(
        fact:
            "The Rocks, a historic area in Sydney, features cobblestone streets and buildings from the early colonial period."),
    HistoricalFact(
        fact:
            "In 1851, the University of Sydney was founded, making it the oldest university in Australia."),
    HistoricalFact(
        fact:
            "The Sydney Harbour Bridge, completed in 1932, was an engineering marvel of its time and remains a key symbol of the city."),
  ],
  coordinates: const LatLng(-33.8688, 151.2093),
);

City toronto = City(
  culturalFacts: [
    CulturalFact(
        fact:
            "Toronto is known for its diverse cultural landscape, with over 200 ethnic groups and more than 140 languages spoken."),
    CulturalFact(
        fact:
            "The Toronto International Film Festival (TIFF) is one of the largest and most prestigious film festivals in the world, attracting celebrities and filmmakers from around the globe."),
    CulturalFact(
        fact:
            "The city is home to the CN Tower, which was the world's tallest free-standing structure when completed in 1976 and remains a major tourist attraction."),
    CulturalFact(
        fact:
            "Toronto's Distillery District is a popular cultural destination, featuring well-preserved Victorian industrial architecture and a variety of arts, culture, and dining experiences."),
    CulturalFact(
        fact:
            "Toronto has a vibrant music scene, with a rich history of jazz, hip-hop, and indie music, and is the birthplace of artists like Drake and The Weeknd."),
    CulturalFact(
        fact:
            "The Royal Ontario Museum, located in Toronto, is one of the largest museums in North America, showcasing a vast collection of art, world culture, and natural history."),
  ],
  geographicalFacts: [
    GeographicalFact(
        fact:
            "Toronto is located in the province of Ontario, on the northwestern shore of Lake Ontario."),
    GeographicalFact(
        fact:
            "The city experiences a humid continental climate, with cold winters and warm, humid summers."),
    GeographicalFact(
        fact:
            "Toronto Islands, a chain of small islands in Lake Ontario, provide recreational spaces and stunning views of the city skyline."),
    GeographicalFact(
        fact:
            "The Don Valley and Humber Valley form significant green corridors through the city, offering extensive parks and trails."),
    GeographicalFact(
        fact:
            "Toronto is characterized by its skyline of modern skyscrapers, including the CN Tower and numerous high-rise buildings."),
    GeographicalFact(
        fact:
            "The city is a major hub for air travel, served by Toronto Pearson International Airport, the busiest airport in Canada."),
  ],
  historicalFacts: [
    HistoricalFact(
        fact:
            "Toronto was originally known as York when it was established as a British colonial settlement in 1793."),
    HistoricalFact(
        fact:
            "The city was renamed Toronto in 1834, derived from a Mohawk word meaning 'where there are trees standing in the water'."),
    HistoricalFact(
        fact:
            "Toronto grew rapidly during the 19th and 20th centuries, becoming a major center for industry, commerce, and culture in Canada."),
    HistoricalFact(
        fact:
            "The Great Fire of 1904 destroyed much of downtown Toronto, leading to significant rebuilding and modernization."),
    HistoricalFact(
        fact:
            "In 1976, the CN Tower was completed, symbolizing Toronto's growth and modernity."),
    HistoricalFact(
        fact:
            "Toronto amalgamated with surrounding municipalities in 1998, creating the modern City of Toronto with its current boundaries."),
  ],
  coordinates: const LatLng(43.651070, -79.347015),
);

List<Place> losAngelesPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Hollywood Sign",
    details:
        "An iconic landmark and American cultural icon located in Los Angeles. It is situated on Mount Lee in the Hollywood Hills area of the Santa Monica Mountains.",
    latitude: 34.1341,
    longitude: -118.3215,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Griffith Observatory",
    details:
        "An observatory, museum, and planetarium situated on the southern slope of Mount Hollywood in Griffith Park. It offers stunning views of the Los Angeles Basin, including Downtown LA.",
    latitude: 34.1184,
    longitude: -118.3004,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Santa Monica Pier",
    details:
        "A large double-jointed pier at the foot of Colorado Avenue in Santa Monica. It is a popular destination that features an amusement park, aquarium, and restaurants.",
    latitude: 34.0094,
    longitude: -118.4973,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "The Getty Center",
    details:
        "A campus of the Getty Museum and other programs of the Getty Trust. It is located in the Brentwood neighborhood and is known for its architecture, gardens, and views.",
    latitude: 34.0780,
    longitude: -118.4741,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Rodeo Drive",
    details:
        "A famous, high-end shopping street in Beverly Hills. It is known for its luxury goods stores and fashion boutiques.",
    latitude: 34.0671,
    longitude: -118.4011,
  ),
];

List<Place> miamiPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "South Beach",
    details:
        "A neighborhood in the city of Miami Beach known for its beaches, nightlife, and art deco architecture. It is a major entertainment destination.",
    latitude: 25.7826,
    longitude: -80.1341,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Vizcaya Museum and Gardens",
    details:
        "A historic estate that was the former villa and estate of businessman James Deering. It features extensive Italian Renaissance gardens, native woodland landscape, and a historic village outbuildings compound.",
    latitude: 25.7449,
    longitude: -80.2102,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Wynwood Walls",
    details:
        "An outdoor museum featuring large-scale works by some of the world’s best-known street artists. It has become a haven for aspiring painters, graffiti artists, and muralists.",
    latitude: 25.8003,
    longitude: -80.1994,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Miami Seaquarium",
    details:
        "A 38-acre oceanarium located on Virginia Key in Biscayne Bay. It features marine mammal shows, exhibits, and a large variety of ocean creatures.",
    latitude: 25.7310,
    longitude: -80.1628,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Little Havana",
    details:
        "A neighborhood in Miami known for its Cuban influence and culture. It features Latin American art galleries, cafes, and restaurants, and is home to many Cuban exiles.",
    latitude: 25.7653,
    longitude: -80.2198,
  ),
];

List<Place> sanFranciscoPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Golden Gate Bridge",
    details:
        "A suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean. It is an internationally recognized symbol of San Francisco.",
    latitude: 37.8199,
    longitude: -122.4783,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Alcatraz Island",
    details:
        "A small island located in San Francisco Bay. It was developed as a military fortification, a military prison, and a federal prison. Now, it is a popular tourist destination.",
    latitude: 37.8270,
    longitude: -122.4230,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Fisherman's Wharf",
    details:
        "A neighborhood and popular tourist attraction in San Francisco. It is known for its historic waterfront, seafood restaurants, and the famous Pier 39.",
    latitude: 37.8080,
    longitude: -122.4177,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Chinatown",
    details:
        "The oldest Chinatown in North America and the largest Chinese enclave outside Asia. It is a major tourist attraction and is known for its temples, teahouses, and traditional markets.",
    latitude: 37.7941,
    longitude: -122.4078,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Lombard Street",
    details:
        "A street famous for a steep, one-block section with eight hairpin turns. It is known as the 'crookedest street in the world' and is a popular tourist destination.",
    latitude: 37.8021,
    longitude: -122.4187,
  ),
];

List<Place> seattlePOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Space Needle",
    details:
        "An iconic observation tower in Seattle, Washington, offering panoramic views of the city and surrounding area. Built for the 1962 World's Fair.",
    latitude: 47.6205,
    longitude: -122.3493,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Pike Place Market",
    details:
        "One of the oldest continuously operated public farmers' markets in the United States, located in Seattle. Known for its fresh produce, specialty foods, and unique shops.",
    latitude: 47.6097,
    longitude: -122.3425,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Chihuly Garden and Glass",
    details:
        "An exhibit showcasing the studio glass of Dale Chihuly. Located at the Seattle Center, it includes a garden, a glasshouse, and interior exhibits.",
    latitude: 47.6206,
    longitude: -122.3505,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Museum of Pop Culture",
    details:
        "A nonprofit museum dedicated to contemporary popular culture, founded by Microsoft co-founder Paul Allen. It features exhibits on music, science fiction, and pop culture.",
    latitude: 47.6215,
    longitude: -122.3480,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Seattle Aquarium",
    details:
        "Located on Pier 59 on the Elliott Bay waterfront in Seattle. The aquarium features marine life native to the Pacific Northwest.",
    latitude: 47.6076,
    longitude: -122.3431,
  ),
];

List<Place> chicagoPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Millennium Park",
    details:
        "A public park located in the Loop community area of Chicago. Known for its iconic Cloud Gate sculpture, also known as 'The Bean'.",
    latitude: 41.8827,
    longitude: -87.6233,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Willis Tower",
    details:
        "Also known as the Sears Tower, it is a 110-story skyscraper in Chicago. It was the tallest building in the world for 25 years and remains one of the tallest in the United States.",
    latitude: 41.8789,
    longitude: -87.6359,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "The Art Institute of Chicago",
    details:
        "One of the oldest and largest art museums in the United States. It houses a vast collection of artworks from around the world.",
    latitude: 41.8796,
    longitude: -87.6237,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Navy Pier",
    details:
        "A 3,300-foot-long pier on the Chicago shoreline of Lake Michigan. It features attractions like restaurants, shops, and entertainment venues.",
    latitude: 41.8917,
    longitude: -87.6097,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Shedd Aquarium",
    details:
        "An indoor public aquarium in Chicago. It was the largest indoor aquarium in the world when it opened and remains one of the largest in the United States.",
    latitude: 41.8676,
    longitude: -87.6140,
  ),
];

List<Place> washingtonDCPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Lincoln Memorial",
    details:
        "A national monument honoring Abraham Lincoln, the 16th President of the United States. Located on the western end of the National Mall.",
    latitude: 38.8893,
    longitude: -77.0502,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "United States Capitol",
    details:
        "The home of the United States Congress and the seat of the legislative branch of the U.S. federal government.",
    latitude: 38.8899,
    longitude: -77.0091,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Smithsonian National Air and Space Museum",
    details:
        "A museum in Washington, D.C. dedicated to the history of aviation and space exploration. It houses the largest collection of historic aircraft and spacecraft in the world.",
    latitude: 38.8881,
    longitude: -77.0199,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Washington Monument",
    details:
        "An obelisk on the National Mall in Washington, D.C. built to commemorate George Washington, the first President of the United States.",
    latitude: 38.8895,
    longitude: -77.0353,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "White House",
    details:
        "The official residence and workplace of the President of the United States. Located at 1600 Pennsylvania Avenue NW in Washington, D.C.",
    latitude: 38.8977,
    longitude: -77.0365,
  ),
];

List<Place> austinPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Texas State Capitol",
    details:
        "The capitol building and seat of government of the American state of Texas. Located in downtown Austin, it houses the offices and chambers of the Texas Legislature.",
    latitude: 30.2747,
    longitude: -97.7403,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Zilker Metropolitan Park",
    details:
        "A recreational area in the heart of Austin, Texas. The park includes numerous attractions such as Barton Springs Pool and the Zilker Botanical Garden.",
    latitude: 30.2664,
    longitude: -97.7729,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "The University of Texas at Austin",
    details:
        "A public research university and the flagship institution of the University of Texas System. Known for its vibrant campus life and academic excellence.",
    latitude: 30.2849,
    longitude: -97.7341,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Lady Bird Lake",
    details:
        "A reservoir on the Colorado River in downtown Austin. It is a popular destination for outdoor activities such as kayaking, paddleboarding, and hiking.",
    latitude: 30.2500,
    longitude: -97.7393,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Barton Springs Pool",
    details:
        "A recreational outdoor swimming pool filled with water from nearby natural springs. Located in Zilker Park, it is a popular spot for locals and visitors alike.",
    latitude: 30.2641,
    longitude: -97.7713,
  ),
];

List<Place> mumbaiPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Gateway of India",
    details:
        "An arch-monument built in the early twentieth century in the city of Mumbai. It is located on the waterfront in the Apollo Bunder area.",
    latitude: 18.9220,
    longitude: 72.8347,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Chhatrapati Shivaji Maharaj Terminus",
    details:
        "A historic railway station and a UNESCO World Heritage Site in Mumbai. It serves as the headquarters of the Central Railways.",
    latitude: 18.9402,
    longitude: 72.8356,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Marine Drive",
    details:
        "A 3.6-kilometer-long boulevard in South Mumbai. It is known for its picturesque sunset views and Art Deco buildings.",
    latitude: 18.9440,
    longitude: 72.8231,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Siddhivinayak Temple",
    details:
        "A Hindu temple dedicated to Lord Shri Ganesh. It is one of the richest temples in Mumbai and a significant pilgrimage site.",
    latitude: 19.0176,
    longitude: 72.8305,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Elephanta Caves",
    details:
        "A network of sculpted caves located on Elephanta Island in Mumbai Harbour. The caves contain rock-cut stone sculptures depicting Hindu deities.",
    latitude: 18.9633,
    longitude: 72.9313,
  ),
];

List<Place> amsterdamPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Rijksmuseum",
    details:
        "A Dutch national museum dedicated to arts and history in Amsterdam. The museum is located at the Museum Square in the borough Amsterdam South.",
    latitude: 52.359998,
    longitude: 4.885219,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Anne Frank House",
    details:
        "A museum dedicated to Jewish wartime diarist Anne Frank. The building is located on a canal called the Prinsengracht, close to the Westerkerk, in central Amsterdam.",
    latitude: 52.375218,
    longitude: 4.883977,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Van Gogh Museum",
    details:
        "An art museum dedicated to the works of Vincent van Gogh and his contemporaries. It is located at the Museum Square in Amsterdam.",
    latitude: 52.358418,
    longitude: 4.881062,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Vondelpark",
    details:
        "A public urban park of 47 hectares (120 acres) in Amsterdam, Netherlands. It is located west from the Leidseplein and the Museumplein.",
    latitude: 52.358416,
    longitude: 4.868547,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Dam Square",
    details:
        "A town square in Amsterdam, the capital of the Netherlands. Its notable buildings and frequent events make it one of the most well-known and important locations in the city and the country.",
    latitude: 52.373169,
    longitude: 4.892452,
  ),
];

List<Place> barcelonaPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Sagrada Família",
    details:
        "A large unfinished Roman Catholic minor basilica in Barcelona, designed by Catalan architect Antoni Gaudí. It is a UNESCO World Heritage Site.",
    latitude: 41.403629,
    longitude: 2.174356,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Park Güell",
    details:
        "A public park system composed of gardens and architectonic elements located on Carmel Hill, designed by Antoni Gaudí.",
    latitude: 41.414495,
    longitude: 2.152694,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "La Rambla",
    details:
        "A street in central Barcelona, popular with tourists and locals alike. It is renowned for its street markets, shops, and vibrant atmosphere.",
    latitude: 41.380898,
    longitude: 2.173784,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Casa Batlló",
    details:
        "A renowned building located in the center of Barcelona and is one of Antoni Gaudí’s masterpieces. It is considered one of his most creative and innovative works.",
    latitude: 41.391640,
    longitude: 2.164853,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Gothic Quarter",
    details:
        "A part of the old city of Barcelona. It stretches from La Rambla to Via Laietana, and from the Mediterranean seafront to Ronda de Sant Pere.",
    latitude: 41.382559,
    longitude: 2.177135,
  ),
];

List<Place> berlinPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Brandenburg Gate",
    details:
        "An 18th-century neoclassical monument in Berlin, built on the orders of Prussian king Frederick William II. It is one of the most well-known landmarks of Germany.",
    latitude: 52.516275,
    longitude: 13.377704,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Berlin Wall Memorial",
    details:
        "The central memorial site of German division, located in the middle of the capital. It extends along 1.4 kilometers of the former border strip.",
    latitude: 52.535069,
    longitude: 13.390428,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Museum Island",
    details:
        "A complex of five internationally significant museums, all part of the Berlin State Museums, located on the northern part of an island in the Spree River.",
    latitude: 52.516934,
    longitude: 13.401837,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Reichstag Building",
    details:
        "A historic edifice in Berlin, constructed to house the Imperial Diet of the German Empire. It is now the seat of the German parliament, the Bundestag.",
    latitude: 52.518620,
    longitude: 13.376198,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Checkpoint Charlie",
    details:
        "The best-known Berlin Wall crossing point between East Berlin and West Berlin during the Cold War, located in Friedrichstraße.",
    latitude: 52.507456,
    longitude: 13.390391,
  ),
];

List<Place> sydneyPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "Sydney Opera House",
    details:
        "A multi-venue performing arts centre in Sydney. It is one of the 20th century's most famous and distinctive buildings.",
    latitude: -33.856784,
    longitude: 151.215297,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Sydney Harbour Bridge",
    details:
        "A heritage-listed steel through arch bridge across Sydney Harbour that carries rail, vehicular, bicycle, and pedestrian traffic.",
    latitude: -33.852306,
    longitude: 151.210787,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Bondi Beach",
    details:
        "A popular beach and the name of the surrounding suburb in Sydney. Bondi Beach is one of the most visited tourist sites in Australia.",
    latitude: -33.890843,
    longitude: 151.274292,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Royal Botanic Garden",
    details:
        "A major botanical garden located in the heart of Sydney. The garden is the oldest scientific institution in Australia and one of the most important historic botanical institutions in the world.",
    latitude: -33.864167,
    longitude: 151.216389,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Taronga Zoo",
    details:
        "A zoo located on the shores of Sydney Harbour in the suburb of Mosman. The zoo is a leading wildlife park with stunning views of the city.",
    latitude: -33.843001,
    longitude: 151.241433,
  ),
];

List<Place> torontoPOI = [
  Place(
    imageUrl: mainLogoAWS,
    name: "CN Tower",
    details:
        "A 553.3 m-high concrete communications and observation tower located in Downtown Toronto. It was completed in 1976, becoming the world's tallest free-standing structure and world's tallest tower at the time.",
    latitude: 43.642566,
    longitude: -79.387057,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Royal Ontario Museum",
    details:
        "A museum of art, world culture, and natural history in Toronto. It is one of the largest museums in North America and the largest in Canada.",
    latitude: 43.667710,
    longitude: -79.394777,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Toronto Islands",
    details:
        "A group of 15 small islands in Lake Ontario, south of mainland Toronto. They are the only group of islands in the western part of Lake Ontario, and provide shelter for Toronto Harbour.",
    latitude: 43.620500,
    longitude: -79.378300,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "St. Lawrence Market",
    details:
        "A major public market in Toronto. It is one of two locations of the St. Lawrence Market Complex and has served as Toronto's social center since 1803.",
    latitude: 43.648700,
    longitude: -79.371500,
  ),
  Place(
    imageUrl: mainLogoAWS,
    name: "Distillery District",
    details:
        "A commercial and residential district in Toronto. It contains numerous cafes, restaurants, and shops housed within heritage buildings of the former Gooderham and Worts Distillery.",
    latitude: 43.650800,
    longitude: -79.359600,
  ),
];

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
