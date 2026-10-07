//Loading Nodes

//Crash

LOAD CSV WITH HEADERS FROM 'file:///crash.csv' AS row
MERGE (c:Crash{crash_id : row.crash_id})
SET c.crash_type = row.crash_type,
c.number_fatalities = toInteger(row.number_fatalities);


//road user

LOAD CSV WITH HEADERS FROM 'file:///road_user.csv' AS row
MERGE (ru:RoadUser {ru_uid: row.ru_uid})
SET ru.road_user = row.road_user,
    ru.gender = row.gender,
    ru.age = toInteger(row.age),
    ru.age_group = row.age_group;



//vehicle

LOAD CSV WITH HEADERS FROM 'file:///vehicles.csv' AS row
MERGE(v:Vehicle {
bus_involvement: row.bus_involvement,
heavy_rigid_truck_involvement: row.heavy_rigid_truck_involvement,
articulated_truck_involvement: row.articulated_truck_involvement
});


//road details

LOAD CSV WITH HEADERS FROM 'file:///road_details.csv' AS row
MERGE (rd:RoadDetails{
speed_limit:toInteger(row.speed_limit),
national_road_type: row.national_road_type
});


//time

LOAD CSV WITH HEADERS FROM 'file:///time.csv' AS row
MERGE (t:Time{
time: row.time,
time_of_day: row.time_of_day
});


//date

LOAD CSV WITH HEADERS FROM 'file:///date.csv' AS row
MERGE (d:Date{
year:toInteger(row.year),
month:toInteger(row.month),
dayweek: row.dayweek,
day_of_week: row.day_of_week,
christmas_period: row.christmas_period,
easter_period: row.easter_period
});


//locations


//LGA

LOAD CSV WITH HEADERS FROM 'file:///lga.csv' AS row
MERGE (l:LGA{
lga: row.lga
});


//SA4

LOAD CSV WITH HEADERS FROM 'file:///sa4.csv' AS row
MERGE (sa:SA4{
sa4: row.sa4
});

//Remoteness

LOAD CSV WITH HEADERS FROM 'file:///remoteness.csv' AS row
MERGE (r:Remoteness{
remoteness: row.remoteness
});

//State

LOAD CSV WITH HEADERS FROM 'file:///state.csv' AS row
MERGE (s:State{
state: row.state
});





//Loading Relationships

// Crash -> RoadUser
LOAD CSV WITH HEADERS FROM 'file:///crash_user.csv' AS row
MATCH (c:Crash{crash_id:row.crash_id})
MATCH (ru:RoadUser {ru_uid: row.ru_uid})
MERGE (c)-[:INVOLVES]->(ru);

// Crash -> RoadDetails
LOAD CSV WITH HEADERS FROM 'file:///crash_road.csv' AS row
MATCH (c:Crash{crash_id:row.crash_id})
MATCH (rd:RoadDetails{
speed_limit:toInteger(row.speed_limit),
national_road_type: row.national_road_type
})
MERGE (c)-[:IN_ROAD]->(rd);

// Crash -> Vehicle
LOAD CSV WITH HEADERS FROM 'file:///crash_vehicle.csv' AS row
MATCH (c:Crash{crash_id:row.crash_id})
MATCH (v:Vehicle {
bus_involvement: row.bus_involvement,
heavy_rigid_truck_involvement: row.heavy_rigid_truck_involvement,
articulated_truck_involvement: row.articulated_truck_involvement
})
MERGE (c)-[:INVOLVED_VEHICLE]->(v);


// Crash -> Date
LOAD CSV WITH HEADERS FROM 'file:///crash_date.csv' AS row
MATCH (c:Crash{crash_id:row.crash_id})
MATCH (d:Date{
year:toInteger(row.year),
month:toInteger(row.month),
dayweek: row.dayweek,
day_of_week: row.day_of_week,
christmas_period: row.christmas_period,
easter_period: row.easter_period
})
MERGE (c)-[:ON_DATE]->(d);

// Crash -> Remoteness
LOAD CSV WITH HEADERS FROM 'file:///crash_remoteness.csv' AS row
MATCH (c:Crash{crash_id:row.crash_id})
MATCH (r:Remoteness{
remoteness: row.remoteness
})
MERGE (c)-[:IN_REMOTENESS]->(r);

// Crash -> Time
LOAD CSV WITH HEADERS FROM 'file:///crash_time.csv' AS row
MATCH (c:Crash{crash_id:row.crash_id})
MATCH (t:Time{
time: row.time,
time_of_day: row.time_of_day
})
MERGE (c)-[:AT_TIME]->(t);

// Crash -> LGA
LOAD CSV WITH HEADERS FROM 'file:///crash_lga.csv' AS row
MATCH (c:Crash{crash_id:row.crash_id})
MATCH (l:LGA{
lga: row.lga
})
MERGE (c)-[:OCCURED_AT]->(l);

// Crash -> SA4
LOAD CSV WITH HEADERS FROM 'file:///crash_sa4.csv' AS row
MATCH (c:Crash{crash_id:row.crash_id})
MATCH (sa:SA4{
sa4: row.sa4
})
MERGE (c)-[:IN_SA4]->(sa);

// Crash -> State
LOAD CSV WITH HEADERS FROM 'file:///crash_state.csv' AS row
MATCH (c:Crash{crash_id:row.crash_id})
MATCH (s:State{
state: row.state
})
MERGE (c)-[:IN_STATE]->(s);

// SA4 -> State
LOAD CSV WITH HEADERS FROM 'file:///sa4_state.csv' AS row
MATCH (sa:SA4{
sa4: row.sa4
})
MATCH (s:State{
state: row.state
})
MERGE (sa)-[:BELONGS_TO]->(s);