CREATE TYPE GeoCoord AS (Longitude DECIMAL, Latitude DECIMAL);

CREATE TABLE country
(Code VARCHAR(4) CONSTRAINT CountryKey PRIMARY KEY,
 Name VARCHAR(35) NOT NULL,
 Capital VARCHAR(35),
 Province VARCHAR(35),
 Area NUMERIC CONSTRAINT CountryArea
   CHECK (Area >= 0),
 Population NUMERIC CONSTRAINT CountryPop
   CHECK (Population >= 0));

CREATE TABLE city
(Name VARCHAR(35),
 Country VARCHAR(4),
 Province VARCHAR(35),
 Population NUMERIC CONSTRAINT CityPop
   CHECK (Population >= 0),
 Coordinates GeoCoord CONSTRAINT cityCoordinates
     CHECK (((Coordinates).Longitude >= -180) AND
            ((Coordinates).Longitude <= 180) AND
            ((Coordinates).Latitude >= -90) AND
            ((Coordinates).Latitude <= 90)),
 CONSTRAINT CityKey PRIMARY KEY (Name, Country, Province));

CREATE TABLE province
(Name VARCHAR(35) CONSTRAINT PrName NOT NULL ,
 Country  VARCHAR(4) CONSTRAINT PrCountry NOT NULL ,
 Population NUMERIC CONSTRAINT PrPop
   CHECK (Population >= 0),
 Area NUMERIC CONSTRAINT PrAr
   CHECK (Area >= 0),
 Capital VARCHAR(35),
 CapProv VARCHAR(35),
 CONSTRAINT PrKey PRIMARY KEY (Name, Country));

CREATE TABLE economy
(Country VARCHAR(4) CONSTRAINT EconomyKey PRIMARY KEY,
 GDP NUMERIC CONSTRAINT EconomyGDP
   CHECK (GDP >= 0),
 Agriculture NUMERIC,
 Service NUMERIC,
 Industry NUMERIC,
 Inflation NUMERIC);

CREATE TABLE population
(Country VARCHAR(4) CONSTRAINT PopKey PRIMARY KEY,
 PopulationGrowth NUMERIC,
 InfantMortality NUMERIC);

CREATE TABLE politics
(Country VARCHAR(4) CONSTRAINT PoliticsKey PRIMARY KEY,
 Independence DATE,
 Dependent  VARCHAR(4),
 Government VARCHAR(120));

CREATE TABLE language
(Country VARCHAR(4),
 Name VARCHAR(50),
 Percentage NUMERIC CONSTRAINT LanguagePercent
   CHECK ((Percentage > 0) AND (Percentage <= 100)),
 CONSTRAINT LanguageKey PRIMARY KEY (Name, Country));

CREATE TABLE religion
(Country VARCHAR(4),
 Name VARCHAR(50),
 Percentage NUMERIC CONSTRAINT ReligionPercent
   CHECK ((Percentage > 0) AND (Percentage <= 100)),
 CONSTRAINT ReligionKey PRIMARY KEY (Name, Country));

CREATE TABLE ethnicGroup
(Country VARCHAR(4),
 Name VARCHAR(50),
 Percentage NUMERIC CONSTRAINT EthnicPercent
   CHECK ((Percentage > 0) AND (Percentage <= 100)),
 CONSTRAINT EthnicKey PRIMARY KEY (Name, Country));

CREATE TABLE continent
(Name VARCHAR(20) CONSTRAINT ContinentKey PRIMARY KEY,
 Area NUMERIC(10));

CREATE TABLE borders
(Country1 VARCHAR(4),
 Country2 VARCHAR(4),
 Length NUMERIC
   CHECK (Length > 0),
 CONSTRAINT BorderKey PRIMARY KEY (Country1,Country2) );

CREATE TABLE encompasses
(Country VARCHAR(4) NOT NULL,
 Continent VARCHAR(20) NOT NULL,
 Percentage NUMERIC,
   CHECK ((Percentage > 0) AND (Percentage <= 100)),
 CONSTRAINT EncompassesKey PRIMARY KEY (Country,Continent));

CREATE TABLE organization
(Abbreviation VARCHAR(12) PRIMARY KEY,
 Name VARCHAR(80) NOT NULL,
 City VARCHAR(35) ,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 Established DATE);

CREATE TABLE isMember
(Country VARCHAR(4),
 Organization VARCHAR(12),
 Type VARCHAR(35) DEFAULT 'member',
 CONSTRAINT MemberKey PRIMARY KEY (Country,Organization) );

CREATE TABLE mountain
(Name VARCHAR(35) CONSTRAINT MountainKey PRIMARY KEY,
 Mountains VARCHAR(35),
 Height NUMERIC,
 Type VARCHAR(10),
 Coordinates GeoCoord CONSTRAINT MountainCoord
     CHECK (((Coordinates).Longitude >= -180) AND
            ((Coordinates).Longitude <= 180) AND
            ((Coordinates).Latitude >= -90) AND
            ((Coordinates).Latitude <= 90)));

CREATE TABLE desert
(Name VARCHAR(35) CONSTRAINT DesertKey PRIMARY KEY,
 Area NUMERIC,
 Coordinates GeoCoord CONSTRAINT DesCoord
     CHECK (((Coordinates).Longitude >= -180) AND
            ((Coordinates).Longitude <= 180) AND
            ((Coordinates).Latitude >= -90) AND
            ((Coordinates).Latitude <= 90)));

CREATE TABLE island
(Name VARCHAR(35) CONSTRAINT IslandKey PRIMARY KEY,
 Islands VARCHAR(35),
 Area NUMERIC CONSTRAINT IslandAr check (Area >= 0),
 Height NUMERIC,
 Type VARCHAR(10),
 Coordinates GeoCoord CONSTRAINT IslandCoord
     CHECK (((Coordinates).Longitude >= -180) AND
            ((Coordinates).Longitude <= 180) AND
            ((Coordinates).Latitude >= -90) AND
            ((Coordinates).Latitude <= 90)));

CREATE TABLE lake
(Name VARCHAR(35) CONSTRAINT LakeKey PRIMARY KEY,
 Area NUMERIC CONSTRAINT LakeAr CHECK (Area >= 0),
 Depth NUMERIC CONSTRAINT LakeDpth CHECK (Depth >= 0),
 Altitude NUMERIC,
 Type VARCHAR(10),
 River VARCHAR(35),
 Coordinates GeoCoord CONSTRAINT LakeCoord
     CHECK (((Coordinates).Longitude >= -180) AND
            ((Coordinates).Longitude <= 180) AND
            ((Coordinates).Latitude >= -90) AND
            ((Coordinates).Latitude <= 90)));

CREATE TABLE sea
(Name VARCHAR(35) CONSTRAINT SeaKey PRIMARY KEY,
 Depth NUMERIC CONSTRAINT SeaDepth CHECK (Depth >= 0));

CREATE TABLE river
(Name VARCHAR(35) CONSTRAINT RiverKey PRIMARY KEY,
 River VARCHAR(35),
 Lake VARCHAR(35),
 Sea VARCHAR(35),
 Length NUMERIC CONSTRAINT RiverLength
   CHECK (Length >= 0),
 Source GeoCoord CONSTRAINT SourceCoord
     CHECK (((Source).Longitude >= -180) AND
            ((Source).Longitude <= 180) AND
            ((Source).Latitude >= -90) AND
            ((Source).Latitude <= 90)),
 Mountains VARCHAR(35),
 SourceAltitude NUMERIC,
 Estuary GeoCoord CONSTRAINT EstCoord
     CHECK (((Estuary).Longitude >= -180) AND
            ((Estuary).Longitude <= 180) AND
            ((Estuary).Latitude >= -90) AND
            ((Estuary).Latitude <= 90)));

CREATE TABLE geoMountain
(Mountain VARCHAR(35) ,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GMountainKey PRIMARY KEY (Province,Country,Mountain) );

CREATE TABLE geoDesert
(Desert VARCHAR(35) ,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GDesertKey PRIMARY KEY (Province, Country, Desert) );

CREATE TABLE geoIsland
(Island VARCHAR(35) ,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GIslandKey PRIMARY KEY (Province, Country, Island) );

CREATE TABLE geoRiver
(River VARCHAR(35) ,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GRiverKey PRIMARY KEY (Province ,Country, River) );

CREATE TABLE geoSea
(Sea VARCHAR(35) ,
 Country VARCHAR(4)  ,
 Province VARCHAR(35) ,
 CONSTRAINT GSeaKey PRIMARY KEY (Province, Country, Sea) );

CREATE TABLE geoLake
(Lake VARCHAR(35) ,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GLakeKey PRIMARY KEY (Province, Country, Lake) );

CREATE TABLE geoSource
(River VARCHAR(35) ,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GSourceKey PRIMARY KEY (Province, Country, River) );

CREATE TABLE geoEstuary
(River VARCHAR(35) ,
 Country VARCHAR(4) ,
 Province VARCHAR(35) ,
 CONSTRAINT GEstuaryKey PRIMARY KEY (Province, Country, River) );

CREATE TABLE mergesWith
(Sea1 VARCHAR(35) ,
 Sea2 VARCHAR(35) ,
 CONSTRAINT MergesWithKey PRIMARY KEY (Sea1, Sea2) );

CREATE TABLE located
(City VARCHAR(35) ,
 Province VARCHAR(35) ,
 Country VARCHAR(4) ,
 River VARCHAR(35),
 Lake VARCHAR(35),
 Sea VARCHAR(35) );

CREATE TABLE locatedOn
(City VARCHAR(35) ,
 Province VARCHAR(35) ,
 Country VARCHAR(4) ,
 Island VARCHAR(35) ,
 CONSTRAINT locatedOnKey PRIMARY KEY (City, Province, Country, Island) );

CREATE TABLE islandIn
(Island VARCHAR(35) ,
 Sea VARCHAR(35) ,
 Lake VARCHAR(35) ,
 River VARCHAR(35) );

CREATE TABLE mountainOnIsland
(Mountain VARCHAR(35),
 Island  VARCHAR(35),
 CONSTRAINT MntIslKey PRIMARY KEY (Mountain, Island) );

CREATE TABLE geoname
(
    geonameid      int PRIMARY KEY,
    name           varchar(200),
    asciiname      varchar(200),
    alternatenames varchar(10000),
    latitude       decimal(10, 7),
    longitude      decimal(10, 7),
    fclass         char(1),
    fcode          varchar(10),
    country        varchar(2),
    cc2            varchar(200),
    admin1         varchar(20),
    admin2         varchar(80),
    admin3         varchar(20),
    admin4         varchar(20),
    population     int,
    elevation      int,
    gtopo30        int,
    timezone       varchar(40),
    moddate        date
);
