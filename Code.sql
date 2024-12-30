
Perpetua Sarina Senatus

 #All sensitive information, such as passwords, hosts, and IP addresses, has been replaced with '0' to ensure security and privacy in this project.



PART 1: Backend Database Configurations


/* Create the database system in GCP */
gcloud sql instances create final2024 \
--database-version MYSQL_8_0 \
--root-password '00000' \
--authorized-networks 000.00.000.0/00 \ 
--storage-type SSD \
--storage-size 10GB \
--tier=db-n1-standard-1 \
--region=us-east1

\connect --mysql --user root --host 00.000.00.000 --ssl-ca=server-ca.pem --ssl-cert=client-cert.pem --ssl-key=client-key.pem --password

/* Switch into SQL mode by using \sql and create the schema and tables */

CREATE DATABASE `Movies`;

USE `Movies`;

CREATE TABLE `Top_200_Movies_Dataset_2023` (
    `Rank` INT,
    `Title` VARCHAR(255),
    `Theaters` VARCHAR(255),
    `Total Gross` VARCHAR(255),
    `Release Date` DATE,
    `Distributor` VARCHAR(255)
);

SHOW TABLES;

DESCRIBE `Top_200_Movies_Dataset_2023` ;


/* Switch into java mode by using \js and import table */

util.importTable('./Top_200_Movies_Dataset_2023.csv', {
    schema: 'Movies', 
    table: 'Top_200_Movies_Dataset_2023', 
    dialect: 'csv-unix', 
    skipRows: 1, 
    linesTerminatedBy: '\n',
    fieldsTerminatedBy: ',',
    showProgress: true
});


/* Switch into SQL mode */

#Code for Total Number of Movies : 
SELECT COUNT(*) AS `Total_Number_of_Movies`
FROM `Movies`.`Top_200_Movies_Dataset_2023`;


#Code for Movies by Release Year : 
SELECT YEAR(`Release Date`) AS `Release_Year`,
COUNT(*) AS `Number_of_Movies`
FROM `Movies`.`Top_200_Movies_Dataset_2023`
GROUP BY `Release_Year`
ORDER BY `Release_Year`;


#Code for Highest Gross Revenue Movie :
SELECT 
    `Title`, 
    `Total Gross`
FROM 
    `Movies`.`Top_200_Movies_Dataset_2023`
ORDER BY 
    `Total Gross` DESC
LIMIT 1;


#Code for Lowest Gross Revenue Movie :
SELECT 
    `Title`, 
    `Total Gross`
FROM 
    `Movies`.`Top_200_Movies_Dataset_2023`
ORDER BY 
    `Total Gross` ASC
LIMIT 1;


#Code to Display infos using Concat: 
SELECT 
    CONCAT('Rank: ', `Rank`) AS `Rank`,
    CONCAT('Title: ', `Title`) AS `Title`,
    CONCAT('Theaters: ', `Theaters`) AS `Theaters`,
    CONCAT('Total Gross: ', `Total Gross`) AS `Total_Gross`,
    CONCAT('Release Date: ', `Release Date`) AS `Release_Date`,
    CONCAT('Distributor: ', `Distributor`) AS `Distributor`
FROM 
    `Movies`.`Top_200_Movies_Dataset_2023`;


#Code to count Movies by Distributor:
SELECT 
    `Distributor`, 
    COUNT(*) AS `Number_of_Movies`
FROM 
    `Movies`.`Top_200_Movies_Dataset_2023`
GROUP BY 
    `Distributor`;


#Code to display Titles with Their Release Dates:
SELECT 
    CONCAT('Title: ', `Title`, ', Release Date: ', `Release Date`) AS `Movie_Info`
FROM 
    `Movies`.`Top_200_Movies_Dataset_2023`;


#View of top grossing movies: 
CREATE VIEW `top_grossing_movies` AS
SELECT `Title`, `Total Gross`
FROM `Top_200_Movies_Dataset_2023`
ORDER BY `Total Gross` DESC;


#View of Distributors with More Than 5 Movies:
CREATE VIEW `distributor_more_than_5_movies` AS
SELECT `Distributor`, COUNT(*) AS `MoviesCount`
FROM `Top_200_Movies_Dataset_2023`
GROUP BY `Distributor`
HAVING COUNT(*) > 5;


#View of Theaters with More Than 10 Movies:
CREATE VIEW  AS `theaters_more_than_10_movies`
SELECT `Theaters`, COUNT(*) AS `MoviesCount`
FROM `Top_200_Movies_Dataset_2023`
GROUP BY `Theaters`
HAVING COUNT(*) > 10;



# SHOW Views 
SHOW CREATE VIEW `top_grossing_movies` ; 

SHOW CREATE VIEW `distributor_more_than_5_movies`;

SHOW CREATE VIEW `theaters_more_than_10_movies`;


# Create Stored Procedures 

#Stored Procedures to get movies count :
DELIMITER //
CREATE PROCEDURE movies_count()
BEGIN
    SELECT COUNT(*) FROM Top_200_Movies_Dataset_2023;
END //
DELIMITER ;



#Stored Procedures to get  movies by distributor :
DELIMITER //
CREATE PROCEDURE movies_by_distributor(IN distributor_name VARCHAR(255))
BEGIN
    SELECT * FROM Top_200_Movies_Dataset_2023 WHERE Distributor = distributor_name;
END//
DELIMITER ;



#Stored Procedures to get  total gross by distributor: 
DELIMITER //
CREATE PROCEDURE total_gross_by_distributor(IN distributor_name VARCHAR(255), OUT total_gross VARCHAR(255))
BEGIN
    SELECT SUM (`Total Gross`) INTO total_gross FROM Top_200_Movies_Dataset_2023 WHERE Distributor= distributor_name;
END//
DELIMITER ;


SHOW PROCEDURE STATUS;


#Check for a stored routine in the movies schema
SELECT 
    routine_name
FROM
    information_schema.routines
WHERE
    routine_type = 'PROCEDURE'
    AND routine_schema = 'Movies'
    AND routine_name = 'movies_by_distributor';


SELECT 
    routine_name
FROM
    information_schema.routines
WHERE
    routine_type = 'PROCEDURE'
    AND routine_schema = 'Movies'
    AND routine_name = 'movies_count';


SELECT 
    routine_name
FROM
    information_schema.routines
WHERE
    routine_type = 'PROCEDURE'
    AND routine_schema = 'Movies'
    AND routine_name = 'total_gross_by_distributor';



# SHOW  stored procedures: 

SHOW CREATE PROCEDURE movies_count;

SHOW CREATE PROCEDURE movies_by_distributor;


SHOW CREATE PROCEDURE total_gross_by_distributor;

---------------------------------------------------------

#Backup and export data

-- create a database backup dump file for the movies schema
util.dumpSchemas(["Movies"], "./group7.sql");

---------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------


Part 2 : Frontend Metabase Dashboard Configurations and Virtual Machine Setup

# Create a compute engine virtual machine
gcloud compute instances create metabase \
    --image-family ubuntu-2204-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --description metabase \
    --zone us-east1-d \
    --metadata=startup-script='#!/bin/bash
    curl -sSL https://storage.googleapis.com/jose-bucket-mac250/metabase.sh | bash'

# Create a static ip address for your metabase vm.
gcloud compute addresses create metabase \
    --project=mineral-voyage-421000 \
    --description="Reserved Static Metabase IP Address" \
    --network-tier=STANDARD \
    --region=us-east1

# Capture the ip address that you just made in a variable.
metabase_ip=$(gcloud compute addresses describe metabase \
    --project=mineral-voyage-421000 \
    --region=us-east1 \
    --format='value(address)')   

# You need to remove previous access config.
gcloud compute instances delete-access-config metabase \
    --project=mineral-voyage-421000 \
    --zone=us-east1-d \
    --access-config-name=external-nat \
    --quiet

# Then you can add new access config.
gcloud compute instances add-access-config metabase \
    --project=mineral-voyage-421000 \
    --zone=us-east1-d \
    --address=$metabase_ip \
    --network-tier=STANDARD

# Create a firewall rule and give access to allowed networks to access metabase.
gcloud compute \
    --project="mineral-voyage-421000" firewall-rules create default-allow-metabase \
    --direction=INGRESS \
    --priority=1000 \
    --network=default \
    --action=ALLOW \
    --rules=tcp:3000 \
    --source-ranges="0000.00.000.0/00,00.000.000.0/00"\
    --target-tags=allow-metabase

# Apply firewall rule to the compute engine.
gcloud compute instances add-tags metabase \
    --zone us-east1-d \
    --tags allow-metabase

# On cloudsql make a whitelist of all of the authorized networks.
echo Y | gcloud sql instances patch metabase \
    --authorized-networks "0000.00.000.0/00,.000.000.0/00,000.000.000.0/00,00.0000.00.000,00.000.000.000"

# Debugging: To see the static ip address echo $metabase_ip at port 3000
echo http://$metabase_ip:3000


# Optional: Verify encryption with packet capture on vm (WIP)
sudo tcpdump -i ens4 -n -s 0 -w capture.pcap port 3306

# Metabase connections strings which (partially) work.
disableSslHostnameVerification=True&useSSL=true&requireSSL=true&verifyServerCertificate=true&useUnicode=true&characterEncoding=UTF-8&passwordCharacterEncoding=UTF-8