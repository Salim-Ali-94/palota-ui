import 'package:flutter_dotenv/flutter_dotenv.dart';


String spotifyBaseUrl = dotenv.get('SPOTIFY_BASE_URL', fallback: '');
String spotifyApiKey = dotenv.get('SPOTIFY_API_KEY', fallback: '');