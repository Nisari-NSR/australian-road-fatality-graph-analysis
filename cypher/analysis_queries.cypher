//Querya
MATCH (c:Crash)-[:INVOLVED_VEHICLE]-> (v:Vehicle),
(c)-[:IN_STATE]-> (s:State),
(c)-[:INVOLVES]-> (ru:RoadUser),
(c)-[:OCCURED_AT]-> (l:LGA),
(c)-[:ON_DATE]-> (d:Date)
WHERE s.state = "WA"
AND v.articulated_truck_involvement = "Yes"
AND c.number_fatalities > 1
AND d.year >= 2020 AND d.year <= 2024
RETURN ru.road_user as Road_User, ru.age as Age, ru.gender as Gender, l.lga AS LGA_Name, d.month as Month, d.year as Year, c.number_fatalities as Number_Of_Fatalities

//Queryb
MATCH (c:Crash)-[:INVOLVES]->(ru:RoadUser),
(c)-[:IN_REMOTENESS]->(r:Remoteness),
(c)-[:ON_DATE]->(d:Date)
WHERE toLower(ru.road_user) = "motorcycle rider"
AND r.remoteness = "Inner Regional Australia"
AND (d.christmas_period ="Yes" OR d.easter_period ="Yes")
AND c.number_fatalities> 0
RETURN ru.gender as Gender,min(ru.age) AS Minimum_age,max(ru.age) AS Maximum_age

//Query c
MATCH (c:Crash)-[:INVOLVES]->(ru:RoadUser),
(c)-[:ON_DATE]->(d:Date),
(c)-[:IN_STATE]->(s:State)
WHERE ru.age_group = '17_to_25'
AND d.year = 2024
WITH s.state AS state,
d.day_of_week AS day,
ru.age AS age
RETURN state as State,
count(CASE WHEN day = 'Weekend' THEN 1 END) AS Weekends,
count(CASE WHEN day = 'Weekday' THEN 1 END) AS Weekdays,
round(avg(age), 3) AS Average_Age

//Query d 
MATCH (c:Crash)-[:ON_DATE]->(d:Date),
(c)-[:IN_STATE]->(s:State),
(c)-[:INVOLVES]->(ru:RoadUser),
(c)-[:IN_SA4]->(sa4:SA4),
(c)-[:IN_REMOTENESS]->(r:Remoteness),
(c)-[:IN_ROAD]->(rd:RoadDetails)
WHERE s.state = 'WA' AND d.dayweek = 'Friday' AND d.day_of_week = 'Weekend' 
AND c.number_fatalities > 1
WITH c.crash_id AS Crash_ID, sa4.sa4 AS SA4, r.remoteness AS Remoteness_Area, rd.national_road_type AS Road_Type,
collect(DISTINCT ru.gender) AS genders
WHERE 'Male' IN genders AND 'Female' IN genders
RETURN Crash_ID, SA4, Remoteness_Area, Road_Type


//Query e
MATCH (c:Crash)-[:AT_TIME]->(t:Time),
(c)-[:IN_SA4]->(s:SA4)
WITH s.sa4 AS region,
toInteger(split(t.time, ":")[0]) AS hour
WITH region,
count(CASE WHEN hour >= 7 AND hour <= 9 THEN 1 END) AS Morning_Peak,
count(CASE WHEN hour >= 16 AND hour <= 18 THEN 1 END) AS Afternoon_Peak
RETURN region, Morning_Peak, Afternoon_Peak
ORDER BY (Morning_Peak + Afternoon_Peak) DESC
LIMIT 5


// Query f
MATCH path = (start:LGA)-[*3]-(end:LGA)
WHERE start <> end
WITH start, end, path
ORDER BY start.lga ASC, end.lga ASC
RETURN start.lga AS Start_LGA, end.lga AS End_LGA, path
LIMIT 3


//Query g
MATCH (c:Crash)-[:INVOLVES]->(ru:RoadUser),(c)-[:ON_DATE]->(d:Date),
(c)-[:AT_TIME]->(t:Time),(c)-[:IN_ROAD]->(rd:RoadDetails),
(c)-[:INVOLVED_VEHICLE]->(v:Vehicle)
WHERE ru.road_user = "Pedestrian" AND d.day_of_week = "Weekday" AND c.number_fatalities > 0
AND (v.bus_involvement ="Yes" OR v.heavy_rigid_truck_involvement ="Yes") AND (rd.speed_limit < 40 OR rd.speed_limit >= 100)
WITH t.time_of_day AS time_of_day,ru.age_group AS age_group,
  CASE 
    WHEN v.bus_involvement = "Yes" THEN "Bus"
    ELSE 'Heavy Rigid Truck'
  END AS vehicle_type,rd.speed_limit AS speed_limit,count(DISTINCT c.crash_id) AS Crash_Count
RETURN time_of_day AS Time_Of_Day, age_group AS Age_Group, vehicle_type AS Vehicle_Type, speed_limit AS Speed_Limit, Crash_Count
ORDER BY Time_Of_Day ASC, Age_Group ASC

// Self Queries

//Query 1
MATCH (c:Crash)-[:INVOLVES]->(ru:RoadUser),
      (c)-[:ON_DATE]->(d:Date)
WHERE ru.age_group = '17_to_25'
RETURN d.month AS Month, count(*) AS Crash_Count
ORDER BY Crash_Count DESC

//Query 2 
MATCH (c:Crash)-[:IN_ROAD]->(rd:RoadDetails),
      (c)-[:AT_TIME]->(t:Time)
RETURN rd.national_road_type AS Road_Type,
       t.time_of_day AS Time_Of_Day,
       count(*) AS Crash_Count
ORDER BY Crash_Count DESC


//Query 3 
MATCH (l:LGA)<-[:OCCURED_AT]-(c:Crash)
WITH l.lga AS LGA, count(*) AS Crash_Count
WHERE Crash_Count > 5
RETURN LGA, Crash_Count
ORDER BY Crash_Count DESC
LIMIT 10

//Query 4 

MATCH (c:Crash)-[:INVOLVES]->(ru:RoadUser),
      (c)-[:AT_TIME]->(t:Time)
WHERE c.number_fatalities > 0
RETURN ru.age_group AS Age_Group, t.time_of_day AS Time_Of_Day, count(*) AS Crash_Count
ORDER BY Crash_Count DESC