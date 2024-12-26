SELECT 
  COUNT(*) AS num_of_songs, artist 
FROM 
  tracks 
GROUP BY 
  artist 
ORDER BY 
  num_of_songs desc