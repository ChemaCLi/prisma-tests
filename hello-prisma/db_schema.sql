CREATE TABLE "_ProfileToLocation" (
  profile_to_location_id uuid NOT NULL, 
  B                      uuid NOT NULL, 
  A                      uuid NOT NULL, 
  PRIMARY KEY (profile_to_location_id));

COMMENT ON COLUMN "_ProfileToLocation".B IS 'profile_id ';
COMMENT ON COLUMN "_ProfileToLocation".A IS 'location_id';

CREATE TABLE "Location" (
  location_id uuid NOT NULL, 
  address     varchar(255), 
  country     varchar(100), 
  i_country   varchar(100), 
  state       varchar(100), 
  i_state     varchar(100), 
  city        varchar(100), 
  i_city      varchar(100), 
  PRIMARY KEY (location_id));

CREATE TABLE "Profile" (
  profile_id                 uuid NOT NULL, 
  user_id                    uuid NOT NULL UNIQUE, 
  gender                     gender_enum, 
  birthday                   date, 
  full_name                  varchar(100), 
  i_full_name                varchar(100), 
  first_name                 varchar(50), 
  middle_name                varchar(50), 
  last_name                  varchar(50), 
  profile_pic_url            varchar(255), 
  phone                      varchar(20), 
  has_tec_relationship       bool, 
  occupation_speciality_area varchar(50), 
  occupation_companies       json, 
  occupation                 varchar(255), 
  PRIMARY KEY (profile_id));

COMMENT ON COLUMN "Profile".gender IS 'CREATE TYPE gender_enum AS ENUM(''FEMALE'' , ''MALE'' , ''OTHER'' , ''NOT_SAY'');';

CREATE UNIQUE INDEX _ProfileToLocation_profile_to_location_id 
  ON "_ProfileToLocation" (profile_to_location_id);
CREATE UNIQUE INDEX "_ProfileToLocation_AB_unique" ON "_ProfileToLocation"("A" uuid,"B" int4_ops);
CREATE INDEX "_ProfileToLocation_B_index" ON "_ProfileToLocation"("B" int4_ops);


CREATE UNIQUE INDEX Location_location_id 
  ON "Location" (location_id);

CREATE UNIQUE INDEX Profile_profile_id 
  ON "Profile" (profile_id);

ALTER TABLE "_ProfileToLocation" ADD CONSTRAINT "location can have one or more profiles" FOREIGN KEY (A) REFERENCES "Location" (location_id);
ALTER TABLE "_ProfileToLocation" ADD CONSTRAINT "profile can have one or more locations" FOREIGN KEY (B) REFERENCES "Profile" (profile_id);
