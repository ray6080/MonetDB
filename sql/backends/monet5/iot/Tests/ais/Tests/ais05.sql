SET SCHEMA ais;
SET optimizer = 'iot_pipe';

-- Calculate distance in kms between two coordinates: http://www.movable-type.co.uk/scripts/latlong.html
-- Therefore we don't need to create a geometry element when working only with stream data (the iot web server doesn't support geom types yet)
CREATE FUNCTION km_distance(lat1 FLOAT, lon1 FLOAT, lat2 FLOAT, lon2 FLOAT) RETURNS FLOAT
BEGIN
	DECLARE deg_to_rad FLOAT, deg_to_rad_div FLOAT, aux FLOAT;
	SET deg_to_rad = pi() / 180;
	SET deg_to_rad_div = deg_to_rad / 2;
	SET aux = sys.power(sys.sin((lat2 - lat1) * deg_to_rad_div), 2) + sys.cos(lat1 * deg_to_rad) * sys.cos(lat2 * deg_to_rad) * sys.power(sys.sin((lon2 - lon1) * deg_to_rad_div), 2);
	RETURN 12742 * sys.atan(sys.sqrt(aux), sys.sqrt(1 - aux));
END;

-- Vessels positions reports table based on AIS messages types 1, 2 and 3
CREATE STREAM TABLE vessels5 (implicit_timestamp timestamp, mmsi int, lat real, lon real, nav_status smallint, sog real, rotais smallint);

-- Position reports are sent every 3-5 seconds so is resonable to consume the tuples arrived on the last 8 seconds
-- Inserts for iot web server (providing time based flush of 8 seconds)
INSERT INTO iot.webserverstreams SELECT tabl.id, 2 , 8, 's' FROM sys.tables tabl INNER JOIN sys.schemas sch ON tabl.schema_id = sch.id WHERE tabl.name = 'vessels5' AND sch.name = 'ais';

--Q5 Closest ship to each other -- Stream only

CREATE TABLE ais05r (calc_time timestamp, mmsi1 int, mmsi2 int, distance float);

CREATE PROCEDURE ais05q()
BEGIN
	INSERT INTO ais05r 
		WITH data AS (SELECT mmsi, lat, lon FROM vessels5 WHERE (implicit_timestamp, mmsi) IN (SELECT max(implicit_timestamp), mmsi FROM vessels5 GROUP BY mmsi)),
		distances AS (SELECT d1.mmsi AS mmsi1, d2.mmsi AS mmsi2, km_distance(d1.lat, d1.lon, d2.lat, d2.lon) AS distance FROM data d1 INNER JOIN data d2 ON d1.mmsi <> d2.mmsi),
		data_time AS (SELECT current_timestamp AS cur_time)
		SELECT cur_time, mmsi1, mmsi2, distance FROM distances CROSS JOIN data_time WHERE (mmsi1, distance) IN (SELECT mmsi1, min(distance) FROM distances GROUP BY mmsi1);
END;

CALL iot.query('ais', 'ais05q');
CALL iot.pause();
-- We don't set the tumbling, so no tuple will be reused in the following window
CALL iot.heartbeat('ais', 'vessels5', 8000);
CALL iot.resume();

CALL iot.pause();
DELETE FROM iot.webserverstreams;
DROP PROCEDURE ais05q;
DROP FUNCTION km_distance;
DROP TABLE vessels5;
DROP TABLE ais05r;

