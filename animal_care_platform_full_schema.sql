
CREATE DATABASE IF NOT EXISTS animal_care_platform CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE animal_care_platform;
SET NAMES utf8mb4;

-- [CORE] organizations
CREATE TABLE IF NOT EXISTS organizations (
  organizations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NOT NULL,
  legal_name VARCHAR(200),
  registration_number VARCHAR(80),
  contact_email VARCHAR(190),
  phone VARCHAR(40),
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (organizations_id)
) ENGINE=InnoDB;

-- [CORE] organization_types
CREATE TABLE IF NOT EXISTS organization_types (
  organization_types_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(40) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (organization_types_id)
) ENGINE=InnoDB;

-- [CORE] organization_type_assignments
CREATE TABLE IF NOT EXISTS organization_type_assignments (
  organization_type_assignments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  organization_type_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (organization_type_assignments_id),
  KEY ix_organization_type_assignments_organization_id (organization_id),
  CONSTRAINT fk_organization_type_assignments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_organization_type_assignments_organization_type_id (organization_type_id),
  CONSTRAINT fk_organization_type_assignments_organization_type_id FOREIGN KEY (organization_type_id) REFERENCES organization_types(organization_types_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CORE] organization_locations
CREATE TABLE IF NOT EXISTS organization_locations (
  organization_locations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL,
  address_line VARCHAR(250),
  city VARCHAR(100),
  country_code CHAR(2),
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (organization_locations_id),
  KEY ix_organization_locations_organization_id (organization_id),
  CONSTRAINT fk_organization_locations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CORE] departments
CREATE TABLE IF NOT EXISTS departments (
  departments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(40) NOT NULL,
  name VARCHAR(120) NOT NULL,
  description TEXT,
  organization_id BIGINT UNSIGNED NULL,
  location_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (departments_id),
  KEY ix_departments_organization_id (organization_id),
  CONSTRAINT fk_departments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_departments_location_id (location_id),
  CONSTRAINT fk_departments_location_id FOREIGN KEY (location_id) REFERENCES organization_locations(organization_locations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  UNIQUE KEY uq_department_org_code (organization_id, code)
) ENGINE=InnoDB;

-- [CORE] facilities
CREATE TABLE IF NOT EXISTS facilities (
  facilities_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL,
  address VARCHAR(250),
  organization_id BIGINT UNSIGNED NULL,
  location_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (facilities_id),
  KEY ix_facilities_organization_id (organization_id),
  CONSTRAINT fk_facilities_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_facilities_location_id (location_id),
  CONSTRAINT fk_facilities_location_id FOREIGN KEY (location_id) REFERENCES organization_locations(organization_locations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CORE] enclosure_types
CREATE TABLE IF NOT EXISTS enclosure_types (
  enclosure_types_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (enclosure_types_id)
) ENGINE=InnoDB;

-- [CORE] enclosures
CREATE TABLE IF NOT EXISTS enclosures (
  enclosures_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(60) NOT NULL,
  name VARCHAR(120),
  capacity INT UNSIGNED NOT NULL DEFAULT 1,
  facility_id BIGINT UNSIGNED NULL,
  enclosure_type_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (enclosures_id),
  KEY ix_enclosures_facility_id (facility_id),
  CONSTRAINT fk_enclosures_facility_id FOREIGN KEY (facility_id) REFERENCES facilities(facilities_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_enclosures_enclosure_type_id (enclosure_type_id),
  CONSTRAINT fk_enclosures_enclosure_type_id FOREIGN KEY (enclosure_type_id) REFERENCES enclosure_types(enclosure_types_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_enclosures_organization_id (organization_id),
  CONSTRAINT fk_enclosures_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_categories
CREATE TABLE IF NOT EXISTS animal_categories (
  animal_categories_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL UNIQUE,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_categories_id)
) ENGINE=InnoDB;

-- [ANIMALS] species
CREATE TABLE IF NOT EXISTS species (
  species_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  common_name VARCHAR(120) NOT NULL,
  scientific_name VARCHAR(180),
  animal_category_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (species_id),
  KEY ix_species_animal_category_id (animal_category_id),
  CONSTRAINT fk_species_animal_category_id FOREIGN KEY (animal_category_id) REFERENCES animal_categories(animal_categories_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CORE] facility_capacity
CREATE TABLE IF NOT EXISTS facility_capacity (
  facility_capacity_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  facility_id BIGINT UNSIGNED NULL,
  species_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (facility_capacity_id),
  KEY ix_facility_capacity_facility_id (facility_id),
  CONSTRAINT fk_facility_capacity_facility_id FOREIGN KEY (facility_id) REFERENCES facilities(facilities_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_facility_capacity_species_id (species_id),
  CONSTRAINT fk_facility_capacity_species_id FOREIGN KEY (species_id) REFERENCES species(species_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_facility_capacity_organization_id (organization_id),
  CONSTRAINT fk_facility_capacity_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] breeds
CREATE TABLE IF NOT EXISTS breeds (
  breeds_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  species_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (breeds_id),
  KEY ix_breeds_species_id (species_id),
  CONSTRAINT fk_breeds_species_id FOREIGN KEY (species_id) REFERENCES species(species_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  UNIQUE KEY uq_breed_species_name (species_id, name)
) ENGINE=InnoDB;

-- [ANIMALS] animals
CREATE TABLE IF NOT EXISTS animals (
  animals_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(120),
  sex ENUM('MALE','FEMALE','UNKNOWN','INTERSEX') NOT NULL DEFAULT 'UNKNOWN',
  date_of_birth DATE,
  birth_date_is_estimated BOOLEAN NOT NULL DEFAULT FALSE,
  intake_notes TEXT,
  organization_id BIGINT UNSIGNED NULL,
  species_id BIGINT UNSIGNED NULL,
  breed_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animals_id),
  KEY ix_animals_organization_id (organization_id),
  CONSTRAINT fk_animals_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animals_species_id (species_id),
  CONSTRAINT fk_animals_species_id FOREIGN KEY (species_id) REFERENCES species(species_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animals_breed_id (breed_id),
  CONSTRAINT fk_animals_breed_id FOREIGN KEY (breed_id) REFERENCES breeds(breeds_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CORE] enclosure_assignments
CREATE TABLE IF NOT EXISTS enclosure_assignments (
  enclosure_assignments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  enclosure_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (enclosure_assignments_id),
  KEY ix_enclosure_assignments_enclosure_id (enclosure_id),
  CONSTRAINT fk_enclosure_assignments_enclosure_id FOREIGN KEY (enclosure_id) REFERENCES enclosures(enclosures_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_enclosure_assignments_animal_id (animal_id),
  CONSTRAINT fk_enclosure_assignments_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_enclosure_assignments_organization_id (organization_id),
  CONSTRAINT fk_enclosure_assignments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CORE] organization_settings
CREATE TABLE IF NOT EXISTS organization_settings (
  organization_settings_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (organization_settings_id),
  KEY ix_organization_settings_organization_id (organization_id),
  CONSTRAINT fk_organization_settings_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CORE] organization_partnerships
CREATE TABLE IF NOT EXISTS organization_partnerships (
  organization_partnerships_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (organization_partnerships_id),
  KEY ix_organization_partnerships_organization_id (organization_id),
  CONSTRAINT fk_organization_partnerships_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] persons
CREATE TABLE IF NOT EXISTS persons (
  persons_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(190),
  phone VARCHAR(40),
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (persons_id),
  KEY ix_persons_organization_id (organization_id),
  CONSTRAINT fk_persons_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] person_addresses
CREATE TABLE IF NOT EXISTS person_addresses (
  person_addresses_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  person_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (person_addresses_id),
  KEY ix_person_addresses_person_id (person_id),
  CONSTRAINT fk_person_addresses_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_person_addresses_organization_id (organization_id),
  CONSTRAINT fk_person_addresses_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] person_contacts
CREATE TABLE IF NOT EXISTS person_contacts (
  person_contacts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  person_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (person_contacts_id),
  KEY ix_person_contacts_person_id (person_id),
  CONSTRAINT fk_person_contacts_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_person_contacts_organization_id (organization_id),
  CONSTRAINT fk_person_contacts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] users
CREATE TABLE IF NOT EXISTS users (
  users_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  email VARCHAR(190) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  organization_id BIGINT UNSIGNED NULL,
  person_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (users_id),
  KEY ix_users_organization_id (organization_id),
  CONSTRAINT fk_users_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_users_person_id (person_id),
  CONSTRAINT fk_users_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] roles
CREATE TABLE IF NOT EXISTS roles (
  roles_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(60) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (roles_id)
) ENGINE=InnoDB;

-- [IDENTITY] permissions
CREATE TABLE IF NOT EXISTS permissions (
  permissions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(100) NOT NULL UNIQUE,
  description VARCHAR(255),
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (permissions_id)
) ENGINE=InnoDB;

-- [IDENTITY] role_permissions
CREATE TABLE IF NOT EXISTS role_permissions (
  role_permissions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  role_id BIGINT UNSIGNED NULL,
  permission_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (role_permissions_id),
  KEY ix_role_permissions_role_id (role_id),
  CONSTRAINT fk_role_permissions_role_id FOREIGN KEY (role_id) REFERENCES roles(roles_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_role_permissions_permission_id (permission_id),
  CONSTRAINT fk_role_permissions_permission_id FOREIGN KEY (permission_id) REFERENCES permissions(permissions_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_role_permissions_organization_id (organization_id),
  CONSTRAINT fk_role_permissions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] user_roles
CREATE TABLE IF NOT EXISTS user_roles (
  user_roles_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  user_id BIGINT UNSIGNED NULL,
  role_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_roles_id),
  KEY ix_user_roles_organization_id (organization_id),
  CONSTRAINT fk_user_roles_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_user_roles_user_id (user_id),
  CONSTRAINT fk_user_roles_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_user_roles_role_id (role_id),
  CONSTRAINT fk_user_roles_role_id FOREIGN KEY (role_id) REFERENCES roles(roles_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] user_organization_memberships
CREATE TABLE IF NOT EXISTS user_organization_memberships (
  user_organization_memberships_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  user_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_organization_memberships_id),
  KEY ix_user_organization_memberships_organization_id (organization_id),
  CONSTRAINT fk_user_organization_memberships_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_user_organization_memberships_user_id (user_id),
  CONSTRAINT fk_user_organization_memberships_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] user_sessions
CREATE TABLE IF NOT EXISTS user_sessions (
  user_sessions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  user_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_sessions_id),
  KEY ix_user_sessions_user_id (user_id),
  CONSTRAINT fk_user_sessions_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_user_sessions_organization_id (organization_id),
  CONSTRAINT fk_user_sessions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] authentication_events
CREATE TABLE IF NOT EXISTS authentication_events (
  authentication_events_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  user_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (authentication_events_id),
  KEY ix_authentication_events_user_id (user_id),
  CONSTRAINT fk_authentication_events_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_authentication_events_organization_id (organization_id),
  CONSTRAINT fk_authentication_events_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] mfa_credentials
CREATE TABLE IF NOT EXISTS mfa_credentials (
  mfa_credentials_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  user_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (mfa_credentials_id),
  KEY ix_mfa_credentials_user_id (user_id),
  CONSTRAINT fk_mfa_credentials_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_mfa_credentials_organization_id (organization_id),
  CONSTRAINT fk_mfa_credentials_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] access_requests
CREATE TABLE IF NOT EXISTS access_requests (
  access_requests_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  user_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (access_requests_id),
  KEY ix_access_requests_user_id (user_id),
  CONSTRAINT fk_access_requests_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_access_requests_organization_id (organization_id),
  CONSTRAINT fk_access_requests_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] audit_logs
CREATE TABLE IF NOT EXISTS audit_logs (
  audit_logs_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  action VARCHAR(100) NOT NULL,
  entity_type VARCHAR(100),
  entity_id BIGINT UNSIGNED,
  occurred_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  organization_id BIGINT UNSIGNED NULL,
  user_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (audit_logs_id),
  KEY ix_audit_logs_organization_id (organization_id),
  CONSTRAINT fk_audit_logs_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_audit_logs_user_id (user_id),
  CONSTRAINT fk_audit_logs_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] security_events
CREATE TABLE IF NOT EXISTS security_events (
  security_events_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  user_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (security_events_id),
  KEY ix_security_events_organization_id (organization_id),
  CONSTRAINT fk_security_events_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_security_events_user_id (user_id),
  CONSTRAINT fk_security_events_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] api_clients
CREATE TABLE IF NOT EXISTS api_clients (
  api_clients_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (api_clients_id),
  KEY ix_api_clients_organization_id (organization_id),
  CONSTRAINT fk_api_clients_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] webhook_subscriptions
CREATE TABLE IF NOT EXISTS webhook_subscriptions (
  webhook_subscriptions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (webhook_subscriptions_id),
  KEY ix_webhook_subscriptions_organization_id (organization_id),
  CONSTRAINT fk_webhook_subscriptions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] privacy_requests
CREATE TABLE IF NOT EXISTS privacy_requests (
  privacy_requests_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (privacy_requests_id),
  KEY ix_privacy_requests_organization_id (organization_id),
  CONSTRAINT fk_privacy_requests_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] consent_records
CREATE TABLE IF NOT EXISTS consent_records (
  consent_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (consent_records_id),
  KEY ix_consent_records_organization_id (organization_id),
  CONSTRAINT fk_consent_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] data_retention_policies
CREATE TABLE IF NOT EXISTS data_retention_policies (
  data_retention_policies_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (data_retention_policies_id),
  KEY ix_data_retention_policies_organization_id (organization_id),
  CONSTRAINT fk_data_retention_policies_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [IDENTITY] integration_credentials_metadata
CREATE TABLE IF NOT EXISTS integration_credentials_metadata (
  integration_credentials_metadata_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (integration_credentials_metadata_id),
  KEY ix_integration_credentials_metadata_organization_id (organization_id),
  CONSTRAINT fk_integration_credentials_metadat_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_identifiers
CREATE TABLE IF NOT EXISTS animal_identifiers (
  animal_identifiers_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  identifier_type VARCHAR(50) NOT NULL,
  identifier_value VARCHAR(120) NOT NULL,
  issuing_authority VARCHAR(120),
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_identifiers_id),
  KEY ix_animal_identifiers_animal_id (animal_id),
  CONSTRAINT fk_animal_identifiers_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_identifiers_organization_id (organization_id),
  CONSTRAINT fk_animal_identifiers_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  UNIQUE KEY uq_animal_identifier (identifier_type, identifier_value)
) ENGINE=InnoDB;

-- [ANIMALS] animal_statuses
CREATE TABLE IF NOT EXISTS animal_statuses (
  animal_statuses_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(50) NOT NULL UNIQUE,
  name VARCHAR(120) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_statuses_id)
) ENGINE=InnoDB;

-- [ANIMALS] animal_status_history
CREATE TABLE IF NOT EXISTS animal_status_history (
  animal_status_history_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  status_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_status_history_id),
  KEY ix_animal_status_history_organization_id (organization_id),
  CONSTRAINT fk_animal_status_history_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_status_history_animal_id (animal_id),
  CONSTRAINT fk_animal_status_history_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_status_history_status_id (status_id),
  CONSTRAINT fk_animal_status_history_status_id FOREIGN KEY (status_id) REFERENCES animal_statuses(animal_statuses_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_measurements
CREATE TABLE IF NOT EXISTS animal_measurements (
  animal_measurements_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  measured_at DATETIME NOT NULL,
  weight_kg DECIMAL(9,3),
  height_cm DECIMAL(9,2),
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_measurements_id),
  KEY ix_animal_measurements_animal_id (animal_id),
  CONSTRAINT fk_animal_measurements_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_measurements_organization_id (organization_id),
  CONSTRAINT fk_animal_measurements_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_characteristics
CREATE TABLE IF NOT EXISTS animal_characteristics (
  animal_characteristics_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_characteristics_id),
  KEY ix_animal_characteristics_animal_id (animal_id),
  CONSTRAINT fk_animal_characteristics_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_characteristics_organization_id (organization_id),
  CONSTRAINT fk_animal_characteristics_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_behaviour_profiles
CREATE TABLE IF NOT EXISTS animal_behaviour_profiles (
  animal_behaviour_profiles_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_behaviour_profiles_id),
  KEY ix_animal_behaviour_profiles_animal_id (animal_id),
  CONSTRAINT fk_animal_behaviour_profiles_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_behaviour_profiles_organization_id (organization_id),
  CONSTRAINT fk_animal_behaviour_profiles_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_relationships
CREATE TABLE IF NOT EXISTS animal_relationships (
  animal_relationships_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  related_animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_relationships_id),
  KEY ix_animal_relationships_animal_id (animal_id),
  CONSTRAINT fk_animal_relationships_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_relationships_related_animal_id (related_animal_id),
  CONSTRAINT fk_animal_relationships_related_animal_id FOREIGN KEY (related_animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_relationships_organization_id (organization_id),
  CONSTRAINT fk_animal_relationships_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_ownership_history
CREATE TABLE IF NOT EXISTS animal_ownership_history (
  animal_ownership_history_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  person_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_ownership_history_id),
  KEY ix_animal_ownership_history_organization_id (organization_id),
  CONSTRAINT fk_animal_ownership_history_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_ownership_history_animal_id (animal_id),
  CONSTRAINT fk_animal_ownership_history_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_ownership_history_person_id (person_id),
  CONSTRAINT fk_animal_ownership_history_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_custody_history
CREATE TABLE IF NOT EXISTS animal_custody_history (
  animal_custody_history_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  person_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_custody_history_id),
  KEY ix_animal_custody_history_organization_id (organization_id),
  CONSTRAINT fk_animal_custody_history_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_custody_history_animal_id (animal_id),
  CONSTRAINT fk_animal_custody_history_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_custody_history_person_id (person_id),
  CONSTRAINT fk_animal_custody_history_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_photos
CREATE TABLE IF NOT EXISTS animal_photos (
  animal_photos_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_photos_id),
  KEY ix_animal_photos_animal_id (animal_id),
  CONSTRAINT fk_animal_photos_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_photos_organization_id (organization_id),
  CONSTRAINT fk_animal_photos_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_documents
CREATE TABLE IF NOT EXISTS animal_documents (
  animal_documents_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_documents_id),
  KEY ix_animal_documents_animal_id (animal_id),
  CONSTRAINT fk_animal_documents_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_documents_organization_id (organization_id),
  CONSTRAINT fk_animal_documents_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_tags
CREATE TABLE IF NOT EXISTS animal_tags (
  animal_tags_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_tags_id),
  KEY ix_animal_tags_organization_id (organization_id),
  CONSTRAINT fk_animal_tags_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANIMALS] animal_tag_assignments
CREATE TABLE IF NOT EXISTS animal_tag_assignments (
  animal_tag_assignments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  tag_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_tag_assignments_id),
  KEY ix_animal_tag_assignments_animal_id (animal_id),
  CONSTRAINT fk_animal_tag_assignments_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_tag_assignments_tag_id (tag_id),
  CONSTRAINT fk_animal_tag_assignments_tag_id FOREIGN KEY (tag_id) REFERENCES animal_tags(animal_tags_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_tag_assignments_organization_id (organization_id),
  CONSTRAINT fk_animal_tag_assignments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] rescue_cases
CREATE TABLE IF NOT EXISTS rescue_cases (
  rescue_cases_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (rescue_cases_id),
  KEY ix_rescue_cases_organization_id (organization_id),
  CONSTRAINT fk_rescue_cases_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] rescue_reports
CREATE TABLE IF NOT EXISTS rescue_reports (
  rescue_reports_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  rescue_case_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (rescue_reports_id),
  KEY ix_rescue_reports_rescue_case_id (rescue_case_id),
  CONSTRAINT fk_rescue_reports_rescue_case_id FOREIGN KEY (rescue_case_id) REFERENCES rescue_cases(rescue_cases_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_rescue_reports_organization_id (organization_id),
  CONSTRAINT fk_rescue_reports_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] rescue_teams
CREATE TABLE IF NOT EXISTS rescue_teams (
  rescue_teams_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (rescue_teams_id),
  KEY ix_rescue_teams_organization_id (organization_id),
  CONSTRAINT fk_rescue_teams_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] rescue_team_members
CREATE TABLE IF NOT EXISTS rescue_team_members (
  rescue_team_members_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  rescue_team_id BIGINT UNSIGNED NULL,
  person_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (rescue_team_members_id),
  KEY ix_rescue_team_members_rescue_team_id (rescue_team_id),
  CONSTRAINT fk_rescue_team_members_rescue_team_id FOREIGN KEY (rescue_team_id) REFERENCES rescue_teams(rescue_teams_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_rescue_team_members_person_id (person_id),
  CONSTRAINT fk_rescue_team_members_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_rescue_team_members_organization_id (organization_id),
  CONSTRAINT fk_rescue_team_members_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] rescue_assignments
CREATE TABLE IF NOT EXISTS rescue_assignments (
  rescue_assignments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  rescue_case_id BIGINT UNSIGNED NULL,
  rescue_team_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (rescue_assignments_id),
  KEY ix_rescue_assignments_rescue_case_id (rescue_case_id),
  CONSTRAINT fk_rescue_assignments_rescue_case_id FOREIGN KEY (rescue_case_id) REFERENCES rescue_cases(rescue_cases_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_rescue_assignments_rescue_team_id (rescue_team_id),
  CONSTRAINT fk_rescue_assignments_rescue_team_id FOREIGN KEY (rescue_team_id) REFERENCES rescue_teams(rescue_teams_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_rescue_assignments_organization_id (organization_id),
  CONSTRAINT fk_rescue_assignments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] intake_reasons
CREATE TABLE IF NOT EXISTS intake_reasons (
  intake_reasons_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (intake_reasons_id)
) ENGINE=InnoDB;

-- [RESCUE] animal_intakes
CREATE TABLE IF NOT EXISTS animal_intakes (
  animal_intakes_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  intake_reason_id BIGINT UNSIGNED NULL,
  rescue_case_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_intakes_id),
  KEY ix_animal_intakes_organization_id (organization_id),
  CONSTRAINT fk_animal_intakes_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_intakes_animal_id (animal_id),
  CONSTRAINT fk_animal_intakes_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_intakes_intake_reason_id (intake_reason_id),
  CONSTRAINT fk_animal_intakes_intake_reason_id FOREIGN KEY (intake_reason_id) REFERENCES intake_reasons(intake_reasons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_intakes_rescue_case_id (rescue_case_id),
  CONSTRAINT fk_animal_intakes_rescue_case_id FOREIGN KEY (rescue_case_id) REFERENCES rescue_cases(rescue_cases_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] animal_transfers
CREATE TABLE IF NOT EXISTS animal_transfers (
  animal_transfers_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_transfers_id),
  KEY ix_animal_transfers_organization_id (organization_id),
  CONSTRAINT fk_animal_transfers_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_transfers_animal_id (animal_id),
  CONSTRAINT fk_animal_transfers_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] transport_records
CREATE TABLE IF NOT EXISTS transport_records (
  transport_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_transfer_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (transport_records_id),
  KEY ix_transport_records_animal_transfer_id (animal_transfer_id),
  CONSTRAINT fk_transport_records_animal_transfer_id FOREIGN KEY (animal_transfer_id) REFERENCES animal_transfers(animal_transfers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_transport_records_organization_id (organization_id),
  CONSTRAINT fk_transport_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] transport_requirements
CREATE TABLE IF NOT EXISTS transport_requirements (
  transport_requirements_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  transport_record_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (transport_requirements_id),
  KEY ix_transport_requirements_transport_record_id (transport_record_id),
  CONSTRAINT fk_transport_requirements_transport_record_id FOREIGN KEY (transport_record_id) REFERENCES transport_records(transport_records_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_transport_requirements_organization_id (organization_id),
  CONSTRAINT fk_transport_requirements_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] lost_found_reports
CREATE TABLE IF NOT EXISTS lost_found_reports (
  lost_found_reports_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (lost_found_reports_id),
  KEY ix_lost_found_reports_organization_id (organization_id),
  CONSTRAINT fk_lost_found_reports_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] animal_outcomes
CREATE TABLE IF NOT EXISTS animal_outcomes (
  animal_outcomes_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_outcomes_id),
  KEY ix_animal_outcomes_organization_id (organization_id),
  CONSTRAINT fk_animal_outcomes_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_outcomes_animal_id (animal_id),
  CONSTRAINT fk_animal_outcomes_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [RESCUE] animal_death_records
CREATE TABLE IF NOT EXISTS animal_death_records (
  animal_death_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_death_records_id),
  KEY ix_animal_death_records_organization_id (organization_id),
  CONSTRAINT fk_animal_death_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_death_records_animal_id (animal_id),
  CONSTRAINT fk_animal_death_records_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] medical_records
CREATE TABLE IF NOT EXISTS medical_records (
  medical_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medical_records_id),
  KEY ix_medical_records_organization_id (organization_id),
  CONSTRAINT fk_medical_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medical_records_animal_id (animal_id),
  CONSTRAINT fk_medical_records_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] medical_visits
CREATE TABLE IF NOT EXISTS medical_visits (
  medical_visits_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  visited_at DATETIME NOT NULL,
  reason TEXT,
  clinical_notes TEXT,
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  medical_record_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medical_visits_id),
  KEY ix_medical_visits_organization_id (organization_id),
  CONSTRAINT fk_medical_visits_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medical_visits_animal_id (animal_id),
  CONSTRAINT fk_medical_visits_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medical_visits_medical_record_id (medical_record_id),
  CONSTRAINT fk_medical_visits_medical_record_id FOREIGN KEY (medical_record_id) REFERENCES medical_records(medical_records_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] clinical_examinations
CREATE TABLE IF NOT EXISTS clinical_examinations (
  clinical_examinations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  medical_visit_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (clinical_examinations_id),
  KEY ix_clinical_examinations_medical_visit_id (medical_visit_id),
  CONSTRAINT fk_clinical_examinations_medical_visit_id FOREIGN KEY (medical_visit_id) REFERENCES medical_visits(medical_visits_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_clinical_examinations_organization_id (organization_id),
  CONSTRAINT fk_clinical_examinations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] disease_catalog
CREATE TABLE IF NOT EXISTS disease_catalog (
  disease_catalog_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  code VARCHAR(80),
  name VARCHAR(180) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (disease_catalog_id)
) ENGINE=InnoDB;

-- [MEDICAL] diagnoses
CREATE TABLE IF NOT EXISTS diagnoses (
  diagnoses_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  diagnosed_at DATETIME,
  notes TEXT,
  medical_visit_id BIGINT UNSIGNED NULL,
  disease_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (diagnoses_id),
  KEY ix_diagnoses_medical_visit_id (medical_visit_id),
  CONSTRAINT fk_diagnoses_medical_visit_id FOREIGN KEY (medical_visit_id) REFERENCES medical_visits(medical_visits_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_diagnoses_disease_id (disease_id),
  CONSTRAINT fk_diagnoses_disease_id FOREIGN KEY (disease_id) REFERENCES disease_catalog(disease_catalog_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_diagnoses_organization_id (organization_id),
  CONSTRAINT fk_diagnoses_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] medical_conditions
CREATE TABLE IF NOT EXISTS medical_conditions (
  medical_conditions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medical_conditions_id),
  KEY ix_medical_conditions_animal_id (animal_id),
  CONSTRAINT fk_medical_conditions_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medical_conditions_organization_id (organization_id),
  CONSTRAINT fk_medical_conditions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] symptoms
CREATE TABLE IF NOT EXISTS symptoms (
  symptoms_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (symptoms_id)
) ENGINE=InnoDB;

-- [MEDICAL] visit_symptoms
CREATE TABLE IF NOT EXISTS visit_symptoms (
  visit_symptoms_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  medical_visit_id BIGINT UNSIGNED NULL,
  symptom_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (visit_symptoms_id),
  KEY ix_visit_symptoms_medical_visit_id (medical_visit_id),
  CONSTRAINT fk_visit_symptoms_medical_visit_id FOREIGN KEY (medical_visit_id) REFERENCES medical_visits(medical_visits_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_visit_symptoms_symptom_id (symptom_id),
  CONSTRAINT fk_visit_symptoms_symptom_id FOREIGN KEY (symptom_id) REFERENCES symptoms(symptoms_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_visit_symptoms_organization_id (organization_id),
  CONSTRAINT fk_visit_symptoms_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] vital_signs
CREATE TABLE IF NOT EXISTS vital_signs (
  vital_signs_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (vital_signs_id),
  KEY ix_vital_signs_animal_id (animal_id),
  CONSTRAINT fk_vital_signs_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_vital_signs_organization_id (organization_id),
  CONSTRAINT fk_vital_signs_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] laboratory_test_catalog
CREATE TABLE IF NOT EXISTS laboratory_test_catalog (
  laboratory_test_catalog_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (laboratory_test_catalog_id)
) ENGINE=InnoDB;

-- [MEDICAL] laboratory_tests
CREATE TABLE IF NOT EXISTS laboratory_tests (
  laboratory_tests_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  medical_visit_id BIGINT UNSIGNED NULL,
  test_catalog_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (laboratory_tests_id),
  KEY ix_laboratory_tests_medical_visit_id (medical_visit_id),
  CONSTRAINT fk_laboratory_tests_medical_visit_id FOREIGN KEY (medical_visit_id) REFERENCES medical_visits(medical_visits_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_laboratory_tests_test_catalog_id (test_catalog_id),
  CONSTRAINT fk_laboratory_tests_test_catalog_id FOREIGN KEY (test_catalog_id) REFERENCES laboratory_test_catalog(laboratory_test_catalog_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_laboratory_tests_organization_id (organization_id),
  CONSTRAINT fk_laboratory_tests_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] laboratory_results
CREATE TABLE IF NOT EXISTS laboratory_results (
  laboratory_results_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  laboratory_test_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (laboratory_results_id),
  KEY ix_laboratory_results_laboratory_test_id (laboratory_test_id),
  CONSTRAINT fk_laboratory_results_laboratory_test_id FOREIGN KEY (laboratory_test_id) REFERENCES laboratory_tests(laboratory_tests_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_laboratory_results_organization_id (organization_id),
  CONSTRAINT fk_laboratory_results_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] imaging_studies
CREATE TABLE IF NOT EXISTS imaging_studies (
  imaging_studies_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  medical_visit_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (imaging_studies_id),
  KEY ix_imaging_studies_medical_visit_id (medical_visit_id),
  CONSTRAINT fk_imaging_studies_medical_visit_id FOREIGN KEY (medical_visit_id) REFERENCES medical_visits(medical_visits_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_imaging_studies_organization_id (organization_id),
  CONSTRAINT fk_imaging_studies_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] medical_attachments
CREATE TABLE IF NOT EXISTS medical_attachments (
  medical_attachments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  medical_visit_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medical_attachments_id),
  KEY ix_medical_attachments_medical_visit_id (medical_visit_id),
  CONSTRAINT fk_medical_attachments_medical_visit_id FOREIGN KEY (medical_visit_id) REFERENCES medical_visits(medical_visits_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medical_attachments_organization_id (organization_id),
  CONSTRAINT fk_medical_attachments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] vaccine_catalog
CREATE TABLE IF NOT EXISTS vaccine_catalog (
  vaccine_catalog_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL,
  manufacturer VARCHAR(150),
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (vaccine_catalog_id)
) ENGINE=InnoDB;

-- [MEDICAL] vaccination_records
CREATE TABLE IF NOT EXISTS vaccination_records (
  vaccination_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  administered_at DATETIME NOT NULL,
  next_due_date DATE,
  batch_number VARCHAR(100),
  animal_id BIGINT UNSIGNED NULL,
  vaccine_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (vaccination_records_id),
  KEY ix_vaccination_records_animal_id (animal_id),
  CONSTRAINT fk_vaccination_records_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_vaccination_records_vaccine_id (vaccine_id),
  CONSTRAINT fk_vaccination_records_vaccine_id FOREIGN KEY (vaccine_id) REFERENCES vaccine_catalog(vaccine_catalog_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_vaccination_records_organization_id (organization_id),
  CONSTRAINT fk_vaccination_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] deworming_records
CREATE TABLE IF NOT EXISTS deworming_records (
  deworming_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (deworming_records_id),
  KEY ix_deworming_records_animal_id (animal_id),
  CONSTRAINT fk_deworming_records_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_deworming_records_organization_id (organization_id),
  CONSTRAINT fk_deworming_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] parasite_treatments
CREATE TABLE IF NOT EXISTS parasite_treatments (
  parasite_treatments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (parasite_treatments_id),
  KEY ix_parasite_treatments_animal_id (animal_id),
  CONSTRAINT fk_parasite_treatments_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_parasite_treatments_organization_id (organization_id),
  CONSTRAINT fk_parasite_treatments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] surgeries
CREATE TABLE IF NOT EXISTS surgeries (
  surgeries_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (surgeries_id),
  KEY ix_surgeries_animal_id (animal_id),
  CONSTRAINT fk_surgeries_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_surgeries_organization_id (organization_id),
  CONSTRAINT fk_surgeries_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] sterilization_records
CREATE TABLE IF NOT EXISTS sterilization_records (
  sterilization_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (sterilization_records_id),
  KEY ix_sterilization_records_animal_id (animal_id),
  CONSTRAINT fk_sterilization_records_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_sterilization_records_organization_id (organization_id),
  CONSTRAINT fk_sterilization_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] allergies
CREATE TABLE IF NOT EXISTS allergies (
  allergies_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (allergies_id)
) ENGINE=InnoDB;

-- [MEDICAL] animal_allergies
CREATE TABLE IF NOT EXISTS animal_allergies (
  animal_allergies_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  allergy_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_allergies_id),
  KEY ix_animal_allergies_animal_id (animal_id),
  CONSTRAINT fk_animal_allergies_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_allergies_allergy_id (allergy_id),
  CONSTRAINT fk_animal_allergies_allergy_id FOREIGN KEY (allergy_id) REFERENCES allergies(allergies_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_allergies_organization_id (organization_id),
  CONSTRAINT fk_animal_allergies_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] disabilities
CREATE TABLE IF NOT EXISTS disabilities (
  disabilities_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (disabilities_id)
) ENGINE=InnoDB;

-- [MEDICAL] animal_disabilities
CREATE TABLE IF NOT EXISTS animal_disabilities (
  animal_disabilities_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  disability_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_disabilities_id),
  KEY ix_animal_disabilities_animal_id (animal_id),
  CONSTRAINT fk_animal_disabilities_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_disabilities_disability_id (disability_id),
  CONSTRAINT fk_animal_disabilities_disability_id FOREIGN KEY (disability_id) REFERENCES disabilities(disabilities_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_disabilities_organization_id (organization_id),
  CONSTRAINT fk_animal_disabilities_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] medical_alerts
CREATE TABLE IF NOT EXISTS medical_alerts (
  medical_alerts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medical_alerts_id),
  KEY ix_medical_alerts_animal_id (animal_id),
  CONSTRAINT fk_medical_alerts_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medical_alerts_organization_id (organization_id),
  CONSTRAINT fk_medical_alerts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] medical_referrals
CREATE TABLE IF NOT EXISTS medical_referrals (
  medical_referrals_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  medical_visit_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medical_referrals_id),
  KEY ix_medical_referrals_medical_visit_id (medical_visit_id),
  CONSTRAINT fk_medical_referrals_medical_visit_id FOREIGN KEY (medical_visit_id) REFERENCES medical_visits(medical_visits_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medical_referrals_organization_id (organization_id),
  CONSTRAINT fk_medical_referrals_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] hospitalizations
CREATE TABLE IF NOT EXISTS hospitalizations (
  hospitalizations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (hospitalizations_id),
  KEY ix_hospitalizations_animal_id (animal_id),
  CONSTRAINT fk_hospitalizations_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_hospitalizations_organization_id (organization_id),
  CONSTRAINT fk_hospitalizations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] hospitalization_observations
CREATE TABLE IF NOT EXISTS hospitalization_observations (
  hospitalization_observations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  hospitalization_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (hospitalization_observations_id),
  KEY ix_hospitalization_observations_hospitalization_id (hospitalization_id),
  CONSTRAINT fk_hospitalization_observations_hospitalization_id FOREIGN KEY (hospitalization_id) REFERENCES hospitalizations(hospitalizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_hospitalization_observations_organization_id (organization_id),
  CONSTRAINT fk_hospitalization_observations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] medical_followups
CREATE TABLE IF NOT EXISTS medical_followups (
  medical_followups_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medical_followups_id),
  KEY ix_medical_followups_animal_id (animal_id),
  CONSTRAINT fk_medical_followups_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medical_followups_organization_id (organization_id),
  CONSTRAINT fk_medical_followups_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICAL] medical_certificates
CREATE TABLE IF NOT EXISTS medical_certificates (
  medical_certificates_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  medical_visit_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medical_certificates_id),
  KEY ix_medical_certificates_medical_visit_id (medical_visit_id),
  CONSTRAINT fk_medical_certificates_medical_visit_id FOREIGN KEY (medical_visit_id) REFERENCES medical_visits(medical_visits_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medical_certificates_organization_id (organization_id),
  CONSTRAINT fk_medical_certificates_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICATION] medications
CREATE TABLE IF NOT EXISTS medications (
  medications_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NOT NULL,
  active_ingredient VARCHAR(180),
  form VARCHAR(100),
  strength VARCHAR(100),
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medications_id)
) ENGINE=InnoDB;

-- [MEDICATION] prescriptions
CREATE TABLE IF NOT EXISTS prescriptions (
  prescriptions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  prescribed_at DATETIME NOT NULL,
  notes TEXT,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (prescriptions_id),
  KEY ix_prescriptions_animal_id (animal_id),
  CONSTRAINT fk_prescriptions_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_prescriptions_organization_id (organization_id),
  CONSTRAINT fk_prescriptions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICATION] prescription_items
CREATE TABLE IF NOT EXISTS prescription_items (
  prescription_items_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  dose_amount DECIMAL(12,4),
  dose_unit VARCHAR(40),
  frequency_text VARCHAR(120),
  route VARCHAR(60),
  start_date DATE,
  end_date DATE,
  prescription_id BIGINT UNSIGNED NULL,
  medication_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (prescription_items_id),
  KEY ix_prescription_items_prescription_id (prescription_id),
  CONSTRAINT fk_prescription_items_prescription_id FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescriptions_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_prescription_items_medication_id (medication_id),
  CONSTRAINT fk_prescription_items_medication_id FOREIGN KEY (medication_id) REFERENCES medications(medications_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_prescription_items_organization_id (organization_id),
  CONSTRAINT fk_prescription_items_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICATION] treatment_plans
CREATE TABLE IF NOT EXISTS treatment_plans (
  treatment_plans_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (treatment_plans_id),
  KEY ix_treatment_plans_animal_id (animal_id),
  CONSTRAINT fk_treatment_plans_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_treatment_plans_organization_id (organization_id),
  CONSTRAINT fk_treatment_plans_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICATION] medication_schedules
CREATE TABLE IF NOT EXISTS medication_schedules (
  medication_schedules_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  scheduled_at DATETIME NOT NULL,
  dose_amount DECIMAL(12,4),
  dose_unit VARCHAR(40),
  animal_id BIGINT UNSIGNED NULL,
  prescription_item_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medication_schedules_id),
  KEY ix_medication_schedules_animal_id (animal_id),
  CONSTRAINT fk_medication_schedules_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medication_schedules_prescription_item_id (prescription_item_id),
  CONSTRAINT fk_medication_schedules_prescription_item_id FOREIGN KEY (prescription_item_id) REFERENCES prescription_items(prescription_items_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medication_schedules_organization_id (organization_id),
  CONSTRAINT fk_medication_schedules_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICATION] medication_administrations
CREATE TABLE IF NOT EXISTS medication_administrations (
  medication_administrations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  administered_at DATETIME NOT NULL,
  dose_amount DECIMAL(12,4),
  outcome VARCHAR(60),
  notes TEXT,
  animal_id BIGINT UNSIGNED NULL,
  medication_schedule_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medication_administrations_id),
  KEY ix_medication_administrations_animal_id (animal_id),
  CONSTRAINT fk_medication_administrations_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medication_administrations_medication_schedule_id (medication_schedule_id),
  CONSTRAINT fk_medication_administrations_medication_schedule_id FOREIGN KEY (medication_schedule_id) REFERENCES medication_schedules(medication_schedules_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medication_administrations_organization_id (organization_id),
  CONSTRAINT fk_medication_administrations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICATION] medication_reactions
CREATE TABLE IF NOT EXISTS medication_reactions (
  medication_reactions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medication_reactions_id),
  KEY ix_medication_reactions_animal_id (animal_id),
  CONSTRAINT fk_medication_reactions_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medication_reactions_organization_id (organization_id),
  CONSTRAINT fk_medication_reactions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICATION] treatment_progress
CREATE TABLE IF NOT EXISTS treatment_progress (
  treatment_progress_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  treatment_plan_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (treatment_progress_id),
  KEY ix_treatment_progress_treatment_plan_id (treatment_plan_id),
  CONSTRAINT fk_treatment_progress_treatment_plan_id FOREIGN KEY (treatment_plan_id) REFERENCES treatment_plans(treatment_plans_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_treatment_progress_organization_id (organization_id),
  CONSTRAINT fk_treatment_progress_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICATION] medication_reminders
CREATE TABLE IF NOT EXISTS medication_reminders (
  medication_reminders_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  medication_schedule_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (medication_reminders_id),
  KEY ix_medication_reminders_medication_schedule_id (medication_schedule_id),
  CONSTRAINT fk_medication_reminders_medication_schedule_id FOREIGN KEY (medication_schedule_id) REFERENCES medication_schedules(medication_schedules_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_medication_reminders_organization_id (organization_id),
  CONSTRAINT fk_medication_reminders_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MEDICATION] controlled_drug_register
CREATE TABLE IF NOT EXISTS controlled_drug_register (
  controlled_drug_register_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  medication_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (controlled_drug_register_id),
  KEY ix_controlled_drug_register_medication_id (medication_id),
  CONSTRAINT fk_controlled_drug_register_medication_id FOREIGN KEY (medication_id) REFERENCES medications(medications_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_controlled_drug_register_organization_id (organization_id),
  CONSTRAINT fk_controlled_drug_register_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] care_plans
CREATE TABLE IF NOT EXISTS care_plans (
  care_plans_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (care_plans_id),
  KEY ix_care_plans_organization_id (organization_id),
  CONSTRAINT fk_care_plans_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_care_plans_animal_id (animal_id),
  CONSTRAINT fk_care_plans_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] care_tasks
CREATE TABLE IF NOT EXISTS care_tasks (
  care_tasks_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(160) NOT NULL,
  due_at DATETIME,
  status VARCHAR(40) NOT NULL DEFAULT 'PENDING',
  care_plan_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (care_tasks_id),
  KEY ix_care_tasks_care_plan_id (care_plan_id),
  CONSTRAINT fk_care_tasks_care_plan_id FOREIGN KEY (care_plan_id) REFERENCES care_plans(care_plans_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_care_tasks_organization_id (organization_id),
  CONSTRAINT fk_care_tasks_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] care_task_logs
CREATE TABLE IF NOT EXISTS care_task_logs (
  care_task_logs_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  care_task_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (care_task_logs_id),
  KEY ix_care_task_logs_care_task_id (care_task_id),
  CONSTRAINT fk_care_task_logs_care_task_id FOREIGN KEY (care_task_id) REFERENCES care_tasks(care_tasks_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_care_task_logs_organization_id (organization_id),
  CONSTRAINT fk_care_task_logs_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] feeding_plans
CREATE TABLE IF NOT EXISTS feeding_plans (
  feeding_plans_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (feeding_plans_id),
  KEY ix_feeding_plans_animal_id (animal_id),
  CONSTRAINT fk_feeding_plans_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_feeding_plans_organization_id (organization_id),
  CONSTRAINT fk_feeding_plans_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] feeding_schedules
CREATE TABLE IF NOT EXISTS feeding_schedules (
  feeding_schedules_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  feeding_plan_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (feeding_schedules_id),
  KEY ix_feeding_schedules_feeding_plan_id (feeding_plan_id),
  CONSTRAINT fk_feeding_schedules_feeding_plan_id FOREIGN KEY (feeding_plan_id) REFERENCES feeding_plans(feeding_plans_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_feeding_schedules_organization_id (organization_id),
  CONSTRAINT fk_feeding_schedules_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] feeding_logs
CREATE TABLE IF NOT EXISTS feeding_logs (
  feeding_logs_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (feeding_logs_id),
  KEY ix_feeding_logs_animal_id (animal_id),
  CONSTRAINT fk_feeding_logs_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_feeding_logs_organization_id (organization_id),
  CONSTRAINT fk_feeding_logs_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] dietary_requirements
CREATE TABLE IF NOT EXISTS dietary_requirements (
  dietary_requirements_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (dietary_requirements_id),
  KEY ix_dietary_requirements_animal_id (animal_id),
  CONSTRAINT fk_dietary_requirements_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_dietary_requirements_organization_id (organization_id),
  CONSTRAINT fk_dietary_requirements_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] food_restrictions
CREATE TABLE IF NOT EXISTS food_restrictions (
  food_restrictions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (food_restrictions_id),
  KEY ix_food_restrictions_animal_id (animal_id),
  CONSTRAINT fk_food_restrictions_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_food_restrictions_organization_id (organization_id),
  CONSTRAINT fk_food_restrictions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] exercise_plans
CREATE TABLE IF NOT EXISTS exercise_plans (
  exercise_plans_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (exercise_plans_id),
  KEY ix_exercise_plans_animal_id (animal_id),
  CONSTRAINT fk_exercise_plans_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_exercise_plans_organization_id (organization_id),
  CONSTRAINT fk_exercise_plans_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] exercise_logs
CREATE TABLE IF NOT EXISTS exercise_logs (
  exercise_logs_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (exercise_logs_id),
  KEY ix_exercise_logs_animal_id (animal_id),
  CONSTRAINT fk_exercise_logs_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_exercise_logs_organization_id (organization_id),
  CONSTRAINT fk_exercise_logs_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] grooming_schedules
CREATE TABLE IF NOT EXISTS grooming_schedules (
  grooming_schedules_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (grooming_schedules_id),
  KEY ix_grooming_schedules_animal_id (animal_id),
  CONSTRAINT fk_grooming_schedules_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_grooming_schedules_organization_id (organization_id),
  CONSTRAINT fk_grooming_schedules_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] grooming_records
CREATE TABLE IF NOT EXISTS grooming_records (
  grooming_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (grooming_records_id),
  KEY ix_grooming_records_animal_id (animal_id),
  CONSTRAINT fk_grooming_records_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_grooming_records_organization_id (organization_id),
  CONSTRAINT fk_grooming_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] behaviour_assessments
CREATE TABLE IF NOT EXISTS behaviour_assessments (
  behaviour_assessments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (behaviour_assessments_id),
  KEY ix_behaviour_assessments_animal_id (animal_id),
  CONSTRAINT fk_behaviour_assessments_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_behaviour_assessments_organization_id (organization_id),
  CONSTRAINT fk_behaviour_assessments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] training_plans
CREATE TABLE IF NOT EXISTS training_plans (
  training_plans_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (training_plans_id),
  KEY ix_training_plans_animal_id (animal_id),
  CONSTRAINT fk_training_plans_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_training_plans_organization_id (organization_id),
  CONSTRAINT fk_training_plans_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] welfare_assessments
CREATE TABLE IF NOT EXISTS welfare_assessments (
  welfare_assessments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (welfare_assessments_id),
  KEY ix_welfare_assessments_animal_id (animal_id),
  CONSTRAINT fk_welfare_assessments_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_welfare_assessments_organization_id (organization_id),
  CONSTRAINT fk_welfare_assessments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] special_needs
CREATE TABLE IF NOT EXISTS special_needs (
  special_needs_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (special_needs_id)
) ENGINE=InnoDB;

-- [CARE] animal_special_needs
CREATE TABLE IF NOT EXISTS animal_special_needs (
  animal_special_needs_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  special_need_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_special_needs_id),
  KEY ix_animal_special_needs_animal_id (animal_id),
  CONSTRAINT fk_animal_special_needs_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_special_needs_special_need_id (special_need_id),
  CONSTRAINT fk_animal_special_needs_special_need_id FOREIGN KEY (special_need_id) REFERENCES special_needs(special_needs_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_special_needs_organization_id (organization_id),
  CONSTRAINT fk_animal_special_needs_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] mobility_support
CREATE TABLE IF NOT EXISTS mobility_support (
  mobility_support_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (mobility_support_id),
  KEY ix_mobility_support_animal_id (animal_id),
  CONSTRAINT fk_mobility_support_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_mobility_support_organization_id (organization_id),
  CONSTRAINT fk_mobility_support_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CARE] daily_observations
CREATE TABLE IF NOT EXISTS daily_observations (
  daily_observations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (daily_observations_id),
  KEY ix_daily_observations_animal_id (animal_id),
  CONSTRAINT fk_daily_observations_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_daily_observations_organization_id (organization_id),
  CONSTRAINT fk_daily_observations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [QUARANTINE] quarantine_reasons
CREATE TABLE IF NOT EXISTS quarantine_reasons (
  quarantine_reasons_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (quarantine_reasons_id)
) ENGINE=InnoDB;

-- [QUARANTINE] quarantine_locations
CREATE TABLE IF NOT EXISTS quarantine_locations (
  quarantine_locations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  enclosure_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (quarantine_locations_id),
  KEY ix_quarantine_locations_enclosure_id (enclosure_id),
  CONSTRAINT fk_quarantine_locations_enclosure_id FOREIGN KEY (enclosure_id) REFERENCES enclosures(enclosures_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_quarantine_locations_organization_id (organization_id),
  CONSTRAINT fk_quarantine_locations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [QUARANTINE] quarantine_cases
CREATE TABLE IF NOT EXISTS quarantine_cases (
  quarantine_cases_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  started_at DATETIME NOT NULL,
  ended_at DATETIME,
  reason_notes TEXT,
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  quarantine_reason_id BIGINT UNSIGNED NULL,
  quarantine_location_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (quarantine_cases_id),
  KEY ix_quarantine_cases_organization_id (organization_id),
  CONSTRAINT fk_quarantine_cases_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_quarantine_cases_animal_id (animal_id),
  CONSTRAINT fk_quarantine_cases_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_quarantine_cases_quarantine_reason_id (quarantine_reason_id),
  CONSTRAINT fk_quarantine_cases_quarantine_reason_id FOREIGN KEY (quarantine_reason_id) REFERENCES quarantine_reasons(quarantine_reasons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_quarantine_cases_quarantine_location_id (quarantine_location_id),
  CONSTRAINT fk_quarantine_cases_quarantine_location_id FOREIGN KEY (quarantine_location_id) REFERENCES quarantine_locations(quarantine_locations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [QUARANTINE] quarantine_observations
CREATE TABLE IF NOT EXISTS quarantine_observations (
  quarantine_observations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  quarantine_case_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (quarantine_observations_id),
  KEY ix_quarantine_observations_quarantine_case_id (quarantine_case_id),
  CONSTRAINT fk_quarantine_observations_quarantine_case_id FOREIGN KEY (quarantine_case_id) REFERENCES quarantine_cases(quarantine_cases_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_quarantine_observations_organization_id (organization_id),
  CONSTRAINT fk_quarantine_observations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [QUARANTINE] infection_control_protocols
CREATE TABLE IF NOT EXISTS infection_control_protocols (
  infection_control_protocols_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (infection_control_protocols_id),
  KEY ix_infection_control_protocols_organization_id (organization_id),
  CONSTRAINT fk_infection_control_protocols_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [QUARANTINE] outbreak_incidents
CREATE TABLE IF NOT EXISTS outbreak_incidents (
  outbreak_incidents_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (outbreak_incidents_id),
  KEY ix_outbreak_incidents_organization_id (organization_id),
  CONSTRAINT fk_outbreak_incidents_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [QUARANTINE] exposure_records
CREATE TABLE IF NOT EXISTS exposure_records (
  exposure_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  outbreak_incident_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (exposure_records_id),
  KEY ix_exposure_records_outbreak_incident_id (outbreak_incident_id),
  CONSTRAINT fk_exposure_records_outbreak_incident_id FOREIGN KEY (outbreak_incident_id) REFERENCES outbreak_incidents(outbreak_incidents_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_exposure_records_animal_id (animal_id),
  CONSTRAINT fk_exposure_records_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_exposure_records_organization_id (organization_id),
  CONSTRAINT fk_exposure_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [QUARANTINE] isolation_clearances
CREATE TABLE IF NOT EXISTS isolation_clearances (
  isolation_clearances_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  quarantine_case_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (isolation_clearances_id),
  KEY ix_isolation_clearances_quarantine_case_id (quarantine_case_id),
  CONSTRAINT fk_isolation_clearances_quarantine_case_id FOREIGN KEY (quarantine_case_id) REFERENCES quarantine_cases(quarantine_cases_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_isolation_clearances_organization_id (organization_id),
  CONSTRAINT fk_isolation_clearances_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] adoption_profiles
CREATE TABLE IF NOT EXISTS adoption_profiles (
  adoption_profiles_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (adoption_profiles_id),
  KEY ix_adoption_profiles_animal_id (animal_id),
  CONSTRAINT fk_adoption_profiles_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_profiles_organization_id (organization_id),
  CONSTRAINT fk_adoption_profiles_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] adoption_applicants
CREATE TABLE IF NOT EXISTS adoption_applicants (
  adoption_applicants_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  person_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (adoption_applicants_id),
  KEY ix_adoption_applicants_person_id (person_id),
  CONSTRAINT fk_adoption_applicants_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_applicants_organization_id (organization_id),
  CONSTRAINT fk_adoption_applicants_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] adoption_applications
CREATE TABLE IF NOT EXISTS adoption_applications (
  adoption_applications_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  submitted_at DATETIME NOT NULL,
  status VARCHAR(40) NOT NULL DEFAULT 'SUBMITTED',
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  applicant_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (adoption_applications_id),
  KEY ix_adoption_applications_organization_id (organization_id),
  CONSTRAINT fk_adoption_applications_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_applications_animal_id (animal_id),
  CONSTRAINT fk_adoption_applications_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_applications_applicant_id (applicant_id),
  CONSTRAINT fk_adoption_applications_applicant_id FOREIGN KEY (applicant_id) REFERENCES adoption_applicants(adoption_applicants_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] adoption_criteria
CREATE TABLE IF NOT EXISTS adoption_criteria (
  adoption_criteria_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (adoption_criteria_id),
  KEY ix_adoption_criteria_organization_id (organization_id),
  CONSTRAINT fk_adoption_criteria_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] adoption_assessments
CREATE TABLE IF NOT EXISTS adoption_assessments (
  adoption_assessments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  adoption_application_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (adoption_assessments_id),
  KEY ix_adoption_assessments_adoption_application_id (adoption_application_id),
  CONSTRAINT fk_adoption_assessments_adoption_application_id FOREIGN KEY (adoption_application_id) REFERENCES adoption_applications(adoption_applications_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_assessments_organization_id (organization_id),
  CONSTRAINT fk_adoption_assessments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] adoption_interviews
CREATE TABLE IF NOT EXISTS adoption_interviews (
  adoption_interviews_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  adoption_application_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (adoption_interviews_id),
  KEY ix_adoption_interviews_adoption_application_id (adoption_application_id),
  CONSTRAINT fk_adoption_interviews_adoption_application_id FOREIGN KEY (adoption_application_id) REFERENCES adoption_applications(adoption_applications_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_interviews_organization_id (organization_id),
  CONSTRAINT fk_adoption_interviews_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] adoption_meetings
CREATE TABLE IF NOT EXISTS adoption_meetings (
  adoption_meetings_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  adoption_application_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (adoption_meetings_id),
  KEY ix_adoption_meetings_adoption_application_id (adoption_application_id),
  CONSTRAINT fk_adoption_meetings_adoption_application_id FOREIGN KEY (adoption_application_id) REFERENCES adoption_applications(adoption_applications_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_meetings_organization_id (organization_id),
  CONSTRAINT fk_adoption_meetings_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] home_visit_records
CREATE TABLE IF NOT EXISTS home_visit_records (
  home_visit_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  adoption_application_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (home_visit_records_id),
  KEY ix_home_visit_records_adoption_application_id (adoption_application_id),
  CONSTRAINT fk_home_visit_records_adoption_application_id FOREIGN KEY (adoption_application_id) REFERENCES adoption_applications(adoption_applications_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_home_visit_records_organization_id (organization_id),
  CONSTRAINT fk_home_visit_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] adoption_decisions
CREATE TABLE IF NOT EXISTS adoption_decisions (
  adoption_decisions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  adoption_application_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (adoption_decisions_id),
  KEY ix_adoption_decisions_adoption_application_id (adoption_application_id),
  CONSTRAINT fk_adoption_decisions_adoption_application_id FOREIGN KEY (adoption_application_id) REFERENCES adoption_applications(adoption_applications_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_decisions_organization_id (organization_id),
  CONSTRAINT fk_adoption_decisions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] adoption_contracts
CREATE TABLE IF NOT EXISTS adoption_contracts (
  adoption_contracts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  adoption_application_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (adoption_contracts_id),
  KEY ix_adoption_contracts_animal_id (animal_id),
  CONSTRAINT fk_adoption_contracts_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_contracts_adoption_application_id (adoption_application_id),
  CONSTRAINT fk_adoption_contracts_adoption_application_id FOREIGN KEY (adoption_application_id) REFERENCES adoption_applications(adoption_applications_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_contracts_organization_id (organization_id),
  CONSTRAINT fk_adoption_contracts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] adoption_followups
CREATE TABLE IF NOT EXISTS adoption_followups (
  adoption_followups_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  adoption_application_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (adoption_followups_id),
  KEY ix_adoption_followups_adoption_application_id (adoption_application_id),
  CONSTRAINT fk_adoption_followups_adoption_application_id FOREIGN KEY (adoption_application_id) REFERENCES adoption_applications(adoption_applications_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_followups_organization_id (organization_id),
  CONSTRAINT fk_adoption_followups_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] adoption_returns
CREATE TABLE IF NOT EXISTS adoption_returns (
  adoption_returns_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  adoption_contract_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (adoption_returns_id),
  KEY ix_adoption_returns_adoption_contract_id (adoption_contract_id),
  CONSTRAINT fk_adoption_returns_adoption_contract_id FOREIGN KEY (adoption_contract_id) REFERENCES adoption_contracts(adoption_contracts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_adoption_returns_organization_id (organization_id),
  CONSTRAINT fk_adoption_returns_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] foster_carers
CREATE TABLE IF NOT EXISTS foster_carers (
  foster_carers_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  person_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (foster_carers_id),
  KEY ix_foster_carers_person_id (person_id),
  CONSTRAINT fk_foster_carers_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_foster_carers_organization_id (organization_id),
  CONSTRAINT fk_foster_carers_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] foster_placements
CREATE TABLE IF NOT EXISTS foster_placements (
  foster_placements_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  foster_carer_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (foster_placements_id),
  KEY ix_foster_placements_animal_id (animal_id),
  CONSTRAINT fk_foster_placements_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_foster_placements_foster_carer_id (foster_carer_id),
  CONSTRAINT fk_foster_placements_foster_carer_id FOREIGN KEY (foster_carer_id) REFERENCES foster_carers(foster_carers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_foster_placements_organization_id (organization_id),
  CONSTRAINT fk_foster_placements_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ADOPTION] foster_followups
CREATE TABLE IF NOT EXISTS foster_followups (
  foster_followups_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  foster_placement_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (foster_followups_id),
  KEY ix_foster_followups_foster_placement_id (foster_placement_id),
  CONSTRAINT fk_foster_followups_foster_placement_id FOREIGN KEY (foster_placement_id) REFERENCES foster_placements(foster_placements_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_foster_followups_organization_id (organization_id),
  CONSTRAINT fk_foster_followups_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] employees
CREATE TABLE IF NOT EXISTS employees (
  employees_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  person_id BIGINT UNSIGNED NULL,
  department_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (employees_id),
  KEY ix_employees_organization_id (organization_id),
  CONSTRAINT fk_employees_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_employees_person_id (person_id),
  CONSTRAINT fk_employees_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_employees_department_id (department_id),
  CONSTRAINT fk_employees_department_id FOREIGN KEY (department_id) REFERENCES departments(departments_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] veterinarians
CREATE TABLE IF NOT EXISTS veterinarians (
  veterinarians_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  person_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (veterinarians_id),
  KEY ix_veterinarians_person_id (person_id),
  CONSTRAINT fk_veterinarians_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_veterinarians_organization_id (organization_id),
  CONSTRAINT fk_veterinarians_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] volunteers
CREATE TABLE IF NOT EXISTS volunteers (
  volunteers_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  person_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (volunteers_id),
  KEY ix_volunteers_organization_id (organization_id),
  CONSTRAINT fk_volunteers_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_volunteers_person_id (person_id),
  CONSTRAINT fk_volunteers_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] employment_contracts
CREATE TABLE IF NOT EXISTS employment_contracts (
  employment_contracts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  employee_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (employment_contracts_id),
  KEY ix_employment_contracts_employee_id (employee_id),
  CONSTRAINT fk_employment_contracts_employee_id FOREIGN KEY (employee_id) REFERENCES employees(employees_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_employment_contracts_organization_id (organization_id),
  CONSTRAINT fk_employment_contracts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] work_schedules
CREATE TABLE IF NOT EXISTS work_schedules (
  work_schedules_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (work_schedules_id),
  KEY ix_work_schedules_organization_id (organization_id),
  CONSTRAINT fk_work_schedules_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] shift_assignments
CREATE TABLE IF NOT EXISTS shift_assignments (
  shift_assignments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  work_schedule_id BIGINT UNSIGNED NULL,
  employee_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (shift_assignments_id),
  KEY ix_shift_assignments_work_schedule_id (work_schedule_id),
  CONSTRAINT fk_shift_assignments_work_schedule_id FOREIGN KEY (work_schedule_id) REFERENCES work_schedules(work_schedules_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_shift_assignments_employee_id (employee_id),
  CONSTRAINT fk_shift_assignments_employee_id FOREIGN KEY (employee_id) REFERENCES employees(employees_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_shift_assignments_organization_id (organization_id),
  CONSTRAINT fk_shift_assignments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] attendance_records
CREATE TABLE IF NOT EXISTS attendance_records (
  attendance_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  employee_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (attendance_records_id),
  KEY ix_attendance_records_employee_id (employee_id),
  CONSTRAINT fk_attendance_records_employee_id FOREIGN KEY (employee_id) REFERENCES employees(employees_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_attendance_records_organization_id (organization_id),
  CONSTRAINT fk_attendance_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] leave_requests
CREATE TABLE IF NOT EXISTS leave_requests (
  leave_requests_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  employee_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (leave_requests_id),
  KEY ix_leave_requests_employee_id (employee_id),
  CONSTRAINT fk_leave_requests_employee_id FOREIGN KEY (employee_id) REFERENCES employees(employees_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_leave_requests_organization_id (organization_id),
  CONSTRAINT fk_leave_requests_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] leave_balances
CREATE TABLE IF NOT EXISTS leave_balances (
  leave_balances_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  employee_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (leave_balances_id),
  KEY ix_leave_balances_employee_id (employee_id),
  CONSTRAINT fk_leave_balances_employee_id FOREIGN KEY (employee_id) REFERENCES employees(employees_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_leave_balances_organization_id (organization_id),
  CONSTRAINT fk_leave_balances_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] volunteer_availability
CREATE TABLE IF NOT EXISTS volunteer_availability (
  volunteer_availability_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  volunteer_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (volunteer_availability_id),
  KEY ix_volunteer_availability_volunteer_id (volunteer_id),
  CONSTRAINT fk_volunteer_availability_volunteer_id FOREIGN KEY (volunteer_id) REFERENCES volunteers(volunteers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_volunteer_availability_organization_id (organization_id),
  CONSTRAINT fk_volunteer_availability_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] volunteer_assignments
CREATE TABLE IF NOT EXISTS volunteer_assignments (
  volunteer_assignments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  volunteer_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (volunteer_assignments_id),
  KEY ix_volunteer_assignments_volunteer_id (volunteer_id),
  CONSTRAINT fk_volunteer_assignments_volunteer_id FOREIGN KEY (volunteer_id) REFERENCES volunteers(volunteers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_volunteer_assignments_organization_id (organization_id),
  CONSTRAINT fk_volunteer_assignments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] training_records
CREATE TABLE IF NOT EXISTS training_records (
  training_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  employee_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (training_records_id),
  KEY ix_training_records_employee_id (employee_id),
  CONSTRAINT fk_training_records_employee_id FOREIGN KEY (employee_id) REFERENCES employees(employees_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_training_records_organization_id (organization_id),
  CONSTRAINT fk_training_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] certifications
CREATE TABLE IF NOT EXISTS certifications (
  certifications_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  employee_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (certifications_id),
  KEY ix_certifications_employee_id (employee_id),
  CONSTRAINT fk_certifications_employee_id FOREIGN KEY (employee_id) REFERENCES employees(employees_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_certifications_organization_id (organization_id),
  CONSTRAINT fk_certifications_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] staff_incidents
CREATE TABLE IF NOT EXISTS staff_incidents (
  staff_incidents_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  employee_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (staff_incidents_id),
  KEY ix_staff_incidents_employee_id (employee_id),
  CONSTRAINT fk_staff_incidents_employee_id FOREIGN KEY (employee_id) REFERENCES employees(employees_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_staff_incidents_organization_id (organization_id),
  CONSTRAINT fk_staff_incidents_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [HR] staffing_requirements
CREATE TABLE IF NOT EXISTS staffing_requirements (
  staffing_requirements_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  department_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (staffing_requirements_id),
  KEY ix_staffing_requirements_department_id (department_id),
  CONSTRAINT fk_staffing_requirements_department_id FOREIGN KEY (department_id) REFERENCES departments(departments_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_staffing_requirements_organization_id (organization_id),
  CONSTRAINT fk_staffing_requirements_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] product_categories
CREATE TABLE IF NOT EXISTS product_categories (
  product_categories_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (product_categories_id)
) ENGINE=InnoDB;

-- [INVENTORY] brands
CREATE TABLE IF NOT EXISTS brands (
  brands_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (brands_id)
) ENGINE=InnoDB;

-- [INVENTORY] products
CREATE TABLE IF NOT EXISTS products (
  products_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  sku VARCHAR(90),
  name VARCHAR(180) NOT NULL,
  description TEXT,
  unit VARCHAR(40) NOT NULL DEFAULT 'piece',
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  organization_id BIGINT UNSIGNED NULL,
  product_category_id BIGINT UNSIGNED NULL,
  brand_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (products_id),
  KEY ix_products_organization_id (organization_id),
  CONSTRAINT fk_products_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_products_product_category_id (product_category_id),
  CONSTRAINT fk_products_product_category_id FOREIGN KEY (product_category_id) REFERENCES product_categories(product_categories_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_products_brand_id (brand_id),
  CONSTRAINT fk_products_brand_id FOREIGN KEY (brand_id) REFERENCES brands(brands_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  UNIQUE KEY uq_product_org_sku (organization_id, sku)
) ENGINE=InnoDB;

-- [INVENTORY] product_species
CREATE TABLE IF NOT EXISTS product_species (
  product_species_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  product_id BIGINT UNSIGNED NULL,
  species_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (product_species_id),
  KEY ix_product_species_product_id (product_id),
  CONSTRAINT fk_product_species_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_product_species_species_id (species_id),
  CONSTRAINT fk_product_species_species_id FOREIGN KEY (species_id) REFERENCES species(species_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_product_species_organization_id (organization_id),
  CONSTRAINT fk_product_species_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] suppliers
CREATE TABLE IF NOT EXISTS suppliers (
  suppliers_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (suppliers_id),
  KEY ix_suppliers_organization_id (organization_id),
  CONSTRAINT fk_suppliers_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] warehouses
CREATE TABLE IF NOT EXISTS warehouses (
  warehouses_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (warehouses_id),
  KEY ix_warehouses_organization_id (organization_id),
  CONSTRAINT fk_warehouses_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] storage_locations
CREATE TABLE IF NOT EXISTS storage_locations (
  storage_locations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  warehouse_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (storage_locations_id),
  KEY ix_storage_locations_warehouse_id (warehouse_id),
  CONSTRAINT fk_storage_locations_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouses_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_storage_locations_organization_id (organization_id),
  CONSTRAINT fk_storage_locations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] inventory_batches
CREATE TABLE IF NOT EXISTS inventory_batches (
  inventory_batches_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  lot_number VARCHAR(120),
  expires_on DATE,
  received_at DATETIME,
  product_id BIGINT UNSIGNED NULL,
  warehouse_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (inventory_batches_id),
  KEY ix_inventory_batches_product_id (product_id),
  CONSTRAINT fk_inventory_batches_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_inventory_batches_warehouse_id (warehouse_id),
  CONSTRAINT fk_inventory_batches_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouses_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_inventory_batches_organization_id (organization_id),
  CONSTRAINT fk_inventory_batches_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] stock_movements
CREATE TABLE IF NOT EXISTS stock_movements (
  stock_movements_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  quantity_delta DECIMAL(14,3) NOT NULL,
  occurred_at DATETIME NOT NULL,
  movement_type VARCHAR(50) NOT NULL,
  reference_code VARCHAR(100),
  product_id BIGINT UNSIGNED NULL,
  inventory_batch_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (stock_movements_id),
  KEY ix_stock_movements_product_id (product_id),
  CONSTRAINT fk_stock_movements_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_stock_movements_inventory_batch_id (inventory_batch_id),
  CONSTRAINT fk_stock_movements_inventory_batch_id FOREIGN KEY (inventory_batch_id) REFERENCES inventory_batches(inventory_batches_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_stock_movements_organization_id (organization_id),
  CONSTRAINT fk_stock_movements_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT chk_stock_movement_nonzero CHECK (quantity_delta <> 0)
) ENGINE=InnoDB;

-- [INVENTORY] stock_adjustments
CREATE TABLE IF NOT EXISTS stock_adjustments (
  stock_adjustments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (stock_adjustments_id),
  KEY ix_stock_adjustments_product_id (product_id),
  CONSTRAINT fk_stock_adjustments_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_stock_adjustments_organization_id (organization_id),
  CONSTRAINT fk_stock_adjustments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] stock_reservations
CREATE TABLE IF NOT EXISTS stock_reservations (
  stock_reservations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (stock_reservations_id),
  KEY ix_stock_reservations_product_id (product_id),
  CONSTRAINT fk_stock_reservations_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_stock_reservations_organization_id (organization_id),
  CONSTRAINT fk_stock_reservations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] stock_alerts
CREATE TABLE IF NOT EXISTS stock_alerts (
  stock_alerts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (stock_alerts_id),
  KEY ix_stock_alerts_product_id (product_id),
  CONSTRAINT fk_stock_alerts_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_stock_alerts_organization_id (organization_id),
  CONSTRAINT fk_stock_alerts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] reorder_rules
CREATE TABLE IF NOT EXISTS reorder_rules (
  reorder_rules_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (reorder_rules_id),
  KEY ix_reorder_rules_product_id (product_id),
  CONSTRAINT fk_reorder_rules_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_reorder_rules_organization_id (organization_id),
  CONSTRAINT fk_reorder_rules_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] purchase_requests
CREATE TABLE IF NOT EXISTS purchase_requests (
  purchase_requests_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (purchase_requests_id),
  KEY ix_purchase_requests_organization_id (organization_id),
  CONSTRAINT fk_purchase_requests_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] purchase_orders
CREATE TABLE IF NOT EXISTS purchase_orders (
  purchase_orders_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  order_number VARCHAR(100) NOT NULL,
  ordered_at DATETIME NOT NULL,
  status VARCHAR(40) NOT NULL DEFAULT 'DRAFT',
  organization_id BIGINT UNSIGNED NULL,
  supplier_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (purchase_orders_id),
  KEY ix_purchase_orders_organization_id (organization_id),
  CONSTRAINT fk_purchase_orders_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_purchase_orders_supplier_id (supplier_id),
  CONSTRAINT fk_purchase_orders_supplier_id FOREIGN KEY (supplier_id) REFERENCES suppliers(suppliers_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] purchase_order_items
CREATE TABLE IF NOT EXISTS purchase_order_items (
  purchase_order_items_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  quantity DECIMAL(14,3) NOT NULL,
  unit_price DECIMAL(14,2) NOT NULL,
  purchase_order_id BIGINT UNSIGNED NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (purchase_order_items_id),
  KEY ix_purchase_order_items_purchase_order_id (purchase_order_id),
  CONSTRAINT fk_purchase_order_items_purchase_order_id FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(purchase_orders_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_purchase_order_items_product_id (product_id),
  CONSTRAINT fk_purchase_order_items_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_purchase_order_items_organization_id (organization_id),
  CONSTRAINT fk_purchase_order_items_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT chk_purchase_order_items_qty CHECK (quantity > 0)
) ENGINE=InnoDB;

-- [INVENTORY] goods_receipts
CREATE TABLE IF NOT EXISTS goods_receipts (
  goods_receipts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  purchase_order_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (goods_receipts_id),
  KEY ix_goods_receipts_purchase_order_id (purchase_order_id),
  CONSTRAINT fk_goods_receipts_purchase_order_id FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(purchase_orders_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_goods_receipts_organization_id (organization_id),
  CONSTRAINT fk_goods_receipts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] supplier_invoices
CREATE TABLE IF NOT EXISTS supplier_invoices (
  supplier_invoices_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  supplier_id BIGINT UNSIGNED NULL,
  purchase_order_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (supplier_invoices_id),
  KEY ix_supplier_invoices_supplier_id (supplier_id),
  CONSTRAINT fk_supplier_invoices_supplier_id FOREIGN KEY (supplier_id) REFERENCES suppliers(suppliers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_supplier_invoices_purchase_order_id (purchase_order_id),
  CONSTRAINT fk_supplier_invoices_purchase_order_id FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(purchase_orders_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_supplier_invoices_organization_id (organization_id),
  CONSTRAINT fk_supplier_invoices_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] supplier_returns
CREATE TABLE IF NOT EXISTS supplier_returns (
  supplier_returns_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  supplier_id BIGINT UNSIGNED NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (supplier_returns_id),
  KEY ix_supplier_returns_supplier_id (supplier_id),
  CONSTRAINT fk_supplier_returns_supplier_id FOREIGN KEY (supplier_id) REFERENCES suppliers(suppliers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_supplier_returns_product_id (product_id),
  CONSTRAINT fk_supplier_returns_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_supplier_returns_organization_id (organization_id),
  CONSTRAINT fk_supplier_returns_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] product_recalls
CREATE TABLE IF NOT EXISTS product_recalls (
  product_recalls_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (product_recalls_id),
  KEY ix_product_recalls_product_id (product_id),
  CONSTRAINT fk_product_recalls_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_product_recalls_organization_id (organization_id),
  CONSTRAINT fk_product_recalls_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] inventory_counts
CREATE TABLE IF NOT EXISTS inventory_counts (
  inventory_counts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  warehouse_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (inventory_counts_id),
  KEY ix_inventory_counts_warehouse_id (warehouse_id),
  CONSTRAINT fk_inventory_counts_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouses_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_inventory_counts_organization_id (organization_id),
  CONSTRAINT fk_inventory_counts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [INVENTORY] inventory_count_items
CREATE TABLE IF NOT EXISTS inventory_count_items (
  inventory_count_items_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  inventory_count_id BIGINT UNSIGNED NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (inventory_count_items_id),
  KEY ix_inventory_count_items_inventory_count_id (inventory_count_id),
  CONSTRAINT fk_inventory_count_items_inventory_count_id FOREIGN KEY (inventory_count_id) REFERENCES inventory_counts(inventory_counts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_inventory_count_items_product_id (product_id),
  CONSTRAINT fk_inventory_count_items_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_inventory_count_items_organization_id (organization_id),
  CONSTRAINT fk_inventory_count_items_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] donors
CREATE TABLE IF NOT EXISTS donors (
  donors_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  person_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (donors_id),
  KEY ix_donors_person_id (person_id),
  CONSTRAINT fk_donors_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_donors_organization_id (organization_id),
  CONSTRAINT fk_donors_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] donations
CREATE TABLE IF NOT EXISTS donations (
  donations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  donated_at DATETIME NOT NULL,
  amount DECIMAL(14,2),
  donation_type VARCHAR(40) NOT NULL,
  organization_id BIGINT UNSIGNED NULL,
  donor_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (donations_id),
  KEY ix_donations_organization_id (organization_id),
  CONSTRAINT fk_donations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_donations_donor_id (donor_id),
  CONSTRAINT fk_donations_donor_id FOREIGN KEY (donor_id) REFERENCES donors(donors_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] donation_items
CREATE TABLE IF NOT EXISTS donation_items (
  donation_items_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  donation_id BIGINT UNSIGNED NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (donation_items_id),
  KEY ix_donation_items_donation_id (donation_id),
  CONSTRAINT fk_donation_items_donation_id FOREIGN KEY (donation_id) REFERENCES donations(donations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_donation_items_product_id (product_id),
  CONSTRAINT fk_donation_items_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_donation_items_organization_id (organization_id),
  CONSTRAINT fk_donation_items_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] sponsors
CREATE TABLE IF NOT EXISTS sponsors (
  sponsors_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (sponsors_id),
  KEY ix_sponsors_organization_id (organization_id),
  CONSTRAINT fk_sponsors_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] sponsorship_agreements
CREATE TABLE IF NOT EXISTS sponsorship_agreements (
  sponsorship_agreements_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  sponsor_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (sponsorship_agreements_id),
  KEY ix_sponsorship_agreements_sponsor_id (sponsor_id),
  CONSTRAINT fk_sponsorship_agreements_sponsor_id FOREIGN KEY (sponsor_id) REFERENCES sponsors(sponsors_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_sponsorship_agreements_organization_id (organization_id),
  CONSTRAINT fk_sponsorship_agreements_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] sponsorship_deliverables
CREATE TABLE IF NOT EXISTS sponsorship_deliverables (
  sponsorship_deliverables_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  sponsorship_agreement_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (sponsorship_deliverables_id),
  KEY ix_sponsorship_deliverables_sponsorship_agreement_i (sponsorship_agreement_id),
  CONSTRAINT fk_sponsorship_deliverables_sponsorship_agreement_id FOREIGN KEY (sponsorship_agreement_id) REFERENCES sponsorship_agreements(sponsorship_agreements_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_sponsorship_deliverables_organization_id (organization_id),
  CONSTRAINT fk_sponsorship_deliverables_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] animal_sponsorships
CREATE TABLE IF NOT EXISTS animal_sponsorships (
  animal_sponsorships_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  sponsor_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_sponsorships_id),
  KEY ix_animal_sponsorships_animal_id (animal_id),
  CONSTRAINT fk_animal_sponsorships_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_sponsorships_sponsor_id (sponsor_id),
  CONSTRAINT fk_animal_sponsorships_sponsor_id FOREIGN KEY (sponsor_id) REFERENCES sponsors(sponsors_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_sponsorships_organization_id (organization_id),
  CONSTRAINT fk_animal_sponsorships_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] fundraising_campaigns
CREATE TABLE IF NOT EXISTS fundraising_campaigns (
  fundraising_campaigns_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (fundraising_campaigns_id),
  KEY ix_fundraising_campaigns_organization_id (organization_id),
  CONSTRAINT fk_fundraising_campaigns_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] fundraising_goals
CREATE TABLE IF NOT EXISTS fundraising_goals (
  fundraising_goals_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  fundraising_campaign_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (fundraising_goals_id),
  KEY ix_fundraising_goals_fundraising_campaign_id (fundraising_campaign_id),
  CONSTRAINT fk_fundraising_goals_fundraising_campaign_id FOREIGN KEY (fundraising_campaign_id) REFERENCES fundraising_campaigns(fundraising_campaigns_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_fundraising_goals_organization_id (organization_id),
  CONSTRAINT fk_fundraising_goals_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] donation_receipts
CREATE TABLE IF NOT EXISTS donation_receipts (
  donation_receipts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  donation_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (donation_receipts_id),
  KEY ix_donation_receipts_donation_id (donation_id),
  CONSTRAINT fk_donation_receipts_donation_id FOREIGN KEY (donation_id) REFERENCES donations(donations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_donation_receipts_organization_id (organization_id),
  CONSTRAINT fk_donation_receipts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] partner_organizations
CREATE TABLE IF NOT EXISTS partner_organizations (
  partner_organizations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (partner_organizations_id),
  KEY ix_partner_organizations_organization_id (organization_id),
  CONSTRAINT fk_partner_organizations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] grant_applications
CREATE TABLE IF NOT EXISTS grant_applications (
  grant_applications_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (grant_applications_id),
  KEY ix_grant_applications_organization_id (organization_id),
  CONSTRAINT fk_grant_applications_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FUNDRAISING] grant_awards
CREATE TABLE IF NOT EXISTS grant_awards (
  grant_awards_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  grant_application_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (grant_awards_id),
  KEY ix_grant_awards_grant_application_id (grant_application_id),
  CONSTRAINT fk_grant_awards_grant_application_id FOREIGN KEY (grant_application_id) REFERENCES grant_applications(grant_applications_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_grant_awards_organization_id (organization_id),
  CONSTRAINT fk_grant_awards_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] financial_accounts
CREATE TABLE IF NOT EXISTS financial_accounts (
  financial_accounts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (financial_accounts_id),
  KEY ix_financial_accounts_organization_id (organization_id),
  CONSTRAINT fk_financial_accounts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] financial_transactions
CREATE TABLE IF NOT EXISTS financial_transactions (
  financial_transactions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  occurred_at DATETIME NOT NULL,
  amount DECIMAL(14,2) NOT NULL,
  currency CHAR(3) NOT NULL DEFAULT 'EUR',
  direction ENUM('IN','OUT') NOT NULL,
  organization_id BIGINT UNSIGNED NULL,
  financial_account_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (financial_transactions_id),
  KEY ix_financial_transactions_organization_id (organization_id),
  CONSTRAINT fk_financial_transactions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_financial_transactions_financial_account_id (financial_account_id),
  CONSTRAINT fk_financial_transactions_financial_account_id FOREIGN KEY (financial_account_id) REFERENCES financial_accounts(financial_accounts_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] income_categories
CREATE TABLE IF NOT EXISTS income_categories (
  income_categories_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (income_categories_id),
  KEY ix_income_categories_organization_id (organization_id),
  CONSTRAINT fk_income_categories_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] expense_categories
CREATE TABLE IF NOT EXISTS expense_categories (
  expense_categories_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (expense_categories_id),
  KEY ix_expense_categories_organization_id (organization_id),
  CONSTRAINT fk_expense_categories_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] budgets
CREATE TABLE IF NOT EXISTS budgets (
  budgets_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(160) NOT NULL,
  fiscal_year SMALLINT NOT NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (budgets_id),
  KEY ix_budgets_organization_id (organization_id),
  CONSTRAINT fk_budgets_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] cost_centers
CREATE TABLE IF NOT EXISTS cost_centers (
  cost_centers_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (cost_centers_id),
  KEY ix_cost_centers_organization_id (organization_id),
  CONSTRAINT fk_cost_centers_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] budget_lines
CREATE TABLE IF NOT EXISTS budget_lines (
  budget_lines_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  planned_amount DECIMAL(14,2) NOT NULL DEFAULT 0,
  budget_id BIGINT UNSIGNED NULL,
  cost_center_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (budget_lines_id),
  KEY ix_budget_lines_budget_id (budget_id),
  CONSTRAINT fk_budget_lines_budget_id FOREIGN KEY (budget_id) REFERENCES budgets(budgets_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_budget_lines_cost_center_id (cost_center_id),
  CONSTRAINT fk_budget_lines_cost_center_id FOREIGN KEY (cost_center_id) REFERENCES cost_centers(cost_centers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_budget_lines_organization_id (organization_id),
  CONSTRAINT fk_budget_lines_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] vendor_bills
CREATE TABLE IF NOT EXISTS vendor_bills (
  vendor_bills_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  supplier_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (vendor_bills_id),
  KEY ix_vendor_bills_supplier_id (supplier_id),
  CONSTRAINT fk_vendor_bills_supplier_id FOREIGN KEY (supplier_id) REFERENCES suppliers(suppliers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_vendor_bills_organization_id (organization_id),
  CONSTRAINT fk_vendor_bills_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] customer_invoices
CREATE TABLE IF NOT EXISTS customer_invoices (
  customer_invoices_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (customer_invoices_id),
  KEY ix_customer_invoices_organization_id (organization_id),
  CONSTRAINT fk_customer_invoices_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] payments
CREATE TABLE IF NOT EXISTS payments (
  payments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  financial_account_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (payments_id),
  KEY ix_payments_financial_account_id (financial_account_id),
  CONSTRAINT fk_payments_financial_account_id FOREIGN KEY (financial_account_id) REFERENCES financial_accounts(financial_accounts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_payments_organization_id (organization_id),
  CONSTRAINT fk_payments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] payment_allocations
CREATE TABLE IF NOT EXISTS payment_allocations (
  payment_allocations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  payment_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (payment_allocations_id),
  KEY ix_payment_allocations_payment_id (payment_id),
  CONSTRAINT fk_payment_allocations_payment_id FOREIGN KEY (payment_id) REFERENCES payments(payments_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_payment_allocations_organization_id (organization_id),
  CONSTRAINT fk_payment_allocations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] recurring_expenses
CREATE TABLE IF NOT EXISTS recurring_expenses (
  recurring_expenses_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (recurring_expenses_id),
  KEY ix_recurring_expenses_organization_id (organization_id),
  CONSTRAINT fk_recurring_expenses_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] emergency_funds
CREATE TABLE IF NOT EXISTS emergency_funds (
  emergency_funds_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (emergency_funds_id),
  KEY ix_emergency_funds_organization_id (organization_id),
  CONSTRAINT fk_emergency_funds_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] financial_forecasts
CREATE TABLE IF NOT EXISTS financial_forecasts (
  financial_forecasts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (financial_forecasts_id),
  KEY ix_financial_forecasts_organization_id (organization_id),
  CONSTRAINT fk_financial_forecasts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] fund_allocations
CREATE TABLE IF NOT EXISTS fund_allocations (
  fund_allocations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  budget_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (fund_allocations_id),
  KEY ix_fund_allocations_budget_id (budget_id),
  CONSTRAINT fk_fund_allocations_budget_id FOREIGN KEY (budget_id) REFERENCES budgets(budgets_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_fund_allocations_organization_id (organization_id),
  CONSTRAINT fk_fund_allocations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [FINANCE] financial_approvals
CREATE TABLE IF NOT EXISTS financial_approvals (
  financial_approvals_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  financial_transaction_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (financial_approvals_id),
  KEY ix_financial_approvals_financial_transaction_i (financial_transaction_id),
  CONSTRAINT fk_financial_approvals_financial_transaction_id FOREIGN KEY (financial_transaction_id) REFERENCES financial_transactions(financial_transactions_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_financial_approvals_organization_id (organization_id),
  CONSTRAINT fk_financial_approvals_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MAINTENANCE] asset_categories
CREATE TABLE IF NOT EXISTS asset_categories (
  asset_categories_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (asset_categories_id)
) ENGINE=InnoDB;

-- [MAINTENANCE] assets
CREATE TABLE IF NOT EXISTS assets (
  assets_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  asset_category_id BIGINT UNSIGNED NULL,
  facility_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (assets_id),
  KEY ix_assets_asset_category_id (asset_category_id),
  CONSTRAINT fk_assets_asset_category_id FOREIGN KEY (asset_category_id) REFERENCES asset_categories(asset_categories_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_assets_facility_id (facility_id),
  CONSTRAINT fk_assets_facility_id FOREIGN KEY (facility_id) REFERENCES facilities(facilities_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_assets_organization_id (organization_id),
  CONSTRAINT fk_assets_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MAINTENANCE] maintenance_requests
CREATE TABLE IF NOT EXISTS maintenance_requests (
  maintenance_requests_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  asset_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (maintenance_requests_id),
  KEY ix_maintenance_requests_asset_id (asset_id),
  CONSTRAINT fk_maintenance_requests_asset_id FOREIGN KEY (asset_id) REFERENCES assets(assets_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_maintenance_requests_organization_id (organization_id),
  CONSTRAINT fk_maintenance_requests_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MAINTENANCE] maintenance_work_orders
CREATE TABLE IF NOT EXISTS maintenance_work_orders (
  maintenance_work_orders_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  maintenance_request_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (maintenance_work_orders_id),
  KEY ix_maintenance_work_orders_maintenance_request_id (maintenance_request_id),
  CONSTRAINT fk_maintenance_work_orders_maintenance_request_id FOREIGN KEY (maintenance_request_id) REFERENCES maintenance_requests(maintenance_requests_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_maintenance_work_orders_organization_id (organization_id),
  CONSTRAINT fk_maintenance_work_orders_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MAINTENANCE] maintenance_schedules
CREATE TABLE IF NOT EXISTS maintenance_schedules (
  maintenance_schedules_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  asset_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (maintenance_schedules_id),
  KEY ix_maintenance_schedules_asset_id (asset_id),
  CONSTRAINT fk_maintenance_schedules_asset_id FOREIGN KEY (asset_id) REFERENCES assets(assets_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_maintenance_schedules_organization_id (organization_id),
  CONSTRAINT fk_maintenance_schedules_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MAINTENANCE] maintenance_history
CREATE TABLE IF NOT EXISTS maintenance_history (
  maintenance_history_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  maintenance_work_order_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (maintenance_history_id),
  KEY ix_maintenance_history_maintenance_work_order_ (maintenance_work_order_id),
  CONSTRAINT fk_maintenance_history_maintenance_work_order_i FOREIGN KEY (maintenance_work_order_id) REFERENCES maintenance_work_orders(maintenance_work_orders_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_maintenance_history_organization_id (organization_id),
  CONSTRAINT fk_maintenance_history_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MAINTENANCE] facility_inspections
CREATE TABLE IF NOT EXISTS facility_inspections (
  facility_inspections_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  facility_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (facility_inspections_id),
  KEY ix_facility_inspections_facility_id (facility_id),
  CONSTRAINT fk_facility_inspections_facility_id FOREIGN KEY (facility_id) REFERENCES facilities(facilities_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_facility_inspections_organization_id (organization_id),
  CONSTRAINT fk_facility_inspections_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MAINTENANCE] safety_incidents
CREATE TABLE IF NOT EXISTS safety_incidents (
  safety_incidents_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  facility_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (safety_incidents_id),
  KEY ix_safety_incidents_facility_id (facility_id),
  CONSTRAINT fk_safety_incidents_facility_id FOREIGN KEY (facility_id) REFERENCES facilities(facilities_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_safety_incidents_organization_id (organization_id),
  CONSTRAINT fk_safety_incidents_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MAINTENANCE] contractors
CREATE TABLE IF NOT EXISTS contractors (
  contractors_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (contractors_id),
  KEY ix_contractors_organization_id (organization_id),
  CONSTRAINT fk_contractors_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MAINTENANCE] service_contracts
CREATE TABLE IF NOT EXISTS service_contracts (
  service_contracts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  contractor_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (service_contracts_id),
  KEY ix_service_contracts_contractor_id (contractor_id),
  CONSTRAINT fk_service_contracts_contractor_id FOREIGN KEY (contractor_id) REFERENCES contractors(contractors_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_service_contracts_organization_id (organization_id),
  CONSTRAINT fk_service_contracts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MAINTENANCE] utility_readings
CREATE TABLE IF NOT EXISTS utility_readings (
  utility_readings_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  facility_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (utility_readings_id),
  KEY ix_utility_readings_facility_id (facility_id),
  CONSTRAINT fk_utility_readings_facility_id FOREIGN KEY (facility_id) REFERENCES facilities(facilities_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_utility_readings_organization_id (organization_id),
  CONSTRAINT fk_utility_readings_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MAINTENANCE] equipment_calibrations
CREATE TABLE IF NOT EXISTS equipment_calibrations (
  equipment_calibrations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  asset_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (equipment_calibrations_id),
  KEY ix_equipment_calibrations_asset_id (asset_id),
  CONSTRAINT fk_equipment_calibrations_asset_id FOREIGN KEY (asset_id) REFERENCES assets(assets_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_equipment_calibrations_organization_id (organization_id),
  CONSTRAINT fk_equipment_calibrations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CLINIC] appointment_types
CREATE TABLE IF NOT EXISTS appointment_types (
  appointment_types_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (appointment_types_id)
) ENGINE=InnoDB;

-- [CLINIC] appointments
CREATE TABLE IF NOT EXISTS appointments (
  appointments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  starts_at DATETIME NOT NULL,
  ends_at DATETIME NOT NULL,
  status VARCHAR(40) NOT NULL DEFAULT 'SCHEDULED',
  organization_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  appointment_type_id BIGINT UNSIGNED NULL,
  veterinarian_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (appointments_id),
  KEY ix_appointments_organization_id (organization_id),
  CONSTRAINT fk_appointments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_appointments_animal_id (animal_id),
  CONSTRAINT fk_appointments_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_appointments_appointment_type_id (appointment_type_id),
  CONSTRAINT fk_appointments_appointment_type_id FOREIGN KEY (appointment_type_id) REFERENCES appointment_types(appointment_types_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_appointments_veterinarian_id (veterinarian_id),
  CONSTRAINT fk_appointments_veterinarian_id FOREIGN KEY (veterinarian_id) REFERENCES veterinarians(veterinarians_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT chk_appointment_times CHECK (ends_at > starts_at)
) ENGINE=InnoDB;

-- [CLINIC] appointment_status_history
CREATE TABLE IF NOT EXISTS appointment_status_history (
  appointment_status_history_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  appointment_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (appointment_status_history_id),
  KEY ix_appointment_status_history_appointment_id (appointment_id),
  CONSTRAINT fk_appointment_status_history_appointment_id FOREIGN KEY (appointment_id) REFERENCES appointments(appointments_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_appointment_status_history_organization_id (organization_id),
  CONSTRAINT fk_appointment_status_history_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CLINIC] clinic_services
CREATE TABLE IF NOT EXISTS clinic_services (
  clinic_services_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (clinic_services_id),
  KEY ix_clinic_services_organization_id (organization_id),
  CONSTRAINT fk_clinic_services_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CLINIC] service_prices
CREATE TABLE IF NOT EXISTS service_prices (
  service_prices_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  clinic_service_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (service_prices_id),
  KEY ix_service_prices_clinic_service_id (clinic_service_id),
  CONSTRAINT fk_service_prices_clinic_service_id FOREIGN KEY (clinic_service_id) REFERENCES clinic_services(clinic_services_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_service_prices_organization_id (organization_id),
  CONSTRAINT fk_service_prices_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CLINIC] consultation_rooms
CREATE TABLE IF NOT EXISTS consultation_rooms (
  consultation_rooms_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  facility_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (consultation_rooms_id),
  KEY ix_consultation_rooms_facility_id (facility_id),
  CONSTRAINT fk_consultation_rooms_facility_id FOREIGN KEY (facility_id) REFERENCES facilities(facilities_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_consultation_rooms_organization_id (organization_id),
  CONSTRAINT fk_consultation_rooms_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CLINIC] veterinarian_availability
CREATE TABLE IF NOT EXISTS veterinarian_availability (
  veterinarian_availability_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  veterinarian_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (veterinarian_availability_id),
  KEY ix_veterinarian_availability_veterinarian_id (veterinarian_id),
  CONSTRAINT fk_veterinarian_availability_veterinarian_id FOREIGN KEY (veterinarian_id) REFERENCES veterinarians(veterinarians_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_veterinarian_availability_organization_id (organization_id),
  CONSTRAINT fk_veterinarian_availability_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CLINIC] waiting_lists
CREATE TABLE IF NOT EXISTS waiting_lists (
  waiting_lists_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (waiting_lists_id),
  KEY ix_waiting_lists_animal_id (animal_id),
  CONSTRAINT fk_waiting_lists_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_waiting_lists_organization_id (organization_id),
  CONSTRAINT fk_waiting_lists_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CLINIC] client_accounts
CREATE TABLE IF NOT EXISTS client_accounts (
  client_accounts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  person_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (client_accounts_id),
  KEY ix_client_accounts_person_id (person_id),
  CONSTRAINT fk_client_accounts_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_client_accounts_organization_id (organization_id),
  CONSTRAINT fk_client_accounts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [CLINIC] client_animal_relationships
CREATE TABLE IF NOT EXISTS client_animal_relationships (
  client_animal_relationships_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  client_account_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (client_animal_relationships_id),
  KEY ix_client_animal_relationships_animal_id (animal_id),
  CONSTRAINT fk_client_animal_relationships_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_client_animal_relationships_client_account_id (client_account_id),
  CONSTRAINT fk_client_animal_relationships_client_account_id FOREIGN KEY (client_account_id) REFERENCES client_accounts(client_accounts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_client_animal_relationships_organization_id (organization_id),
  CONSTRAINT fk_client_animal_relationships_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] breeding_programs
CREATE TABLE IF NOT EXISTS breeding_programs (
  breeding_programs_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (breeding_programs_id),
  KEY ix_breeding_programs_organization_id (organization_id),
  CONSTRAINT fk_breeding_programs_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] animal_pedigrees
CREATE TABLE IF NOT EXISTS animal_pedigrees (
  animal_pedigrees_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  sire_id BIGINT UNSIGNED NULL,
  dam_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (animal_pedigrees_id),
  KEY ix_animal_pedigrees_animal_id (animal_id),
  CONSTRAINT fk_animal_pedigrees_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_pedigrees_sire_id (sire_id),
  CONSTRAINT fk_animal_pedigrees_sire_id FOREIGN KEY (sire_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_pedigrees_dam_id (dam_id),
  CONSTRAINT fk_animal_pedigrees_dam_id FOREIGN KEY (dam_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_animal_pedigrees_organization_id (organization_id),
  CONSTRAINT fk_animal_pedigrees_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] breeding_pairs
CREATE TABLE IF NOT EXISTS breeding_pairs (
  breeding_pairs_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  male_animal_id BIGINT UNSIGNED NULL,
  female_animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (breeding_pairs_id),
  KEY ix_breeding_pairs_male_animal_id (male_animal_id),
  CONSTRAINT fk_breeding_pairs_male_animal_id FOREIGN KEY (male_animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_breeding_pairs_female_animal_id (female_animal_id),
  CONSTRAINT fk_breeding_pairs_female_animal_id FOREIGN KEY (female_animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_breeding_pairs_organization_id (organization_id),
  CONSTRAINT fk_breeding_pairs_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] breeding_events
CREATE TABLE IF NOT EXISTS breeding_events (
  breeding_events_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  breeding_pair_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (breeding_events_id),
  KEY ix_breeding_events_breeding_pair_id (breeding_pair_id),
  CONSTRAINT fk_breeding_events_breeding_pair_id FOREIGN KEY (breeding_pair_id) REFERENCES breeding_pairs(breeding_pairs_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_breeding_events_organization_id (organization_id),
  CONSTRAINT fk_breeding_events_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] pregnancy_records
CREATE TABLE IF NOT EXISTS pregnancy_records (
  pregnancy_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  breeding_event_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (pregnancy_records_id),
  KEY ix_pregnancy_records_animal_id (animal_id),
  CONSTRAINT fk_pregnancy_records_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_pregnancy_records_breeding_event_id (breeding_event_id),
  CONSTRAINT fk_pregnancy_records_breeding_event_id FOREIGN KEY (breeding_event_id) REFERENCES breeding_events(breeding_events_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_pregnancy_records_organization_id (organization_id),
  CONSTRAINT fk_pregnancy_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] birth_events
CREATE TABLE IF NOT EXISTS birth_events (
  birth_events_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  pregnancy_record_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (birth_events_id),
  KEY ix_birth_events_pregnancy_record_id (pregnancy_record_id),
  CONSTRAINT fk_birth_events_pregnancy_record_id FOREIGN KEY (pregnancy_record_id) REFERENCES pregnancy_records(pregnancy_records_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_birth_events_organization_id (organization_id),
  CONSTRAINT fk_birth_events_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] offspring_records
CREATE TABLE IF NOT EXISTS offspring_records (
  offspring_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  birth_event_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (offspring_records_id),
  KEY ix_offspring_records_birth_event_id (birth_event_id),
  CONSTRAINT fk_offspring_records_birth_event_id FOREIGN KEY (birth_event_id) REFERENCES birth_events(birth_events_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_offspring_records_animal_id (animal_id),
  CONSTRAINT fk_offspring_records_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_offspring_records_organization_id (organization_id),
  CONSTRAINT fk_offspring_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] genetic_tests
CREATE TABLE IF NOT EXISTS genetic_tests (
  genetic_tests_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (genetic_tests_id),
  KEY ix_genetic_tests_animal_id (animal_id),
  CONSTRAINT fk_genetic_tests_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_genetic_tests_organization_id (organization_id),
  CONSTRAINT fk_genetic_tests_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] reproductive_health_records
CREATE TABLE IF NOT EXISTS reproductive_health_records (
  reproductive_health_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (reproductive_health_records_id),
  KEY ix_reproductive_health_records_animal_id (animal_id),
  CONSTRAINT fk_reproductive_health_records_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_reproductive_health_records_organization_id (organization_id),
  CONSTRAINT fk_reproductive_health_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] breeding_restrictions
CREATE TABLE IF NOT EXISTS breeding_restrictions (
  breeding_restrictions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (breeding_restrictions_id),
  KEY ix_breeding_restrictions_animal_id (animal_id),
  CONSTRAINT fk_breeding_restrictions_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_breeding_restrictions_organization_id (organization_id),
  CONSTRAINT fk_breeding_restrictions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] livestock_groups
CREATE TABLE IF NOT EXISTS livestock_groups (
  livestock_groups_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (livestock_groups_id),
  KEY ix_livestock_groups_organization_id (organization_id),
  CONSTRAINT fk_livestock_groups_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] livestock_group_memberships
CREATE TABLE IF NOT EXISTS livestock_group_memberships (
  livestock_group_memberships_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  livestock_group_id BIGINT UNSIGNED NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (livestock_group_memberships_id),
  KEY ix_livestock_group_memberships_livestock_group_id (livestock_group_id),
  CONSTRAINT fk_livestock_group_memberships_livestock_group_id FOREIGN KEY (livestock_group_id) REFERENCES livestock_groups(livestock_groups_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_livestock_group_memberships_animal_id (animal_id),
  CONSTRAINT fk_livestock_group_memberships_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_livestock_group_memberships_organization_id (organization_id),
  CONSTRAINT fk_livestock_group_memberships_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] production_records
CREATE TABLE IF NOT EXISTS production_records (
  production_records_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  animal_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (production_records_id),
  KEY ix_production_records_animal_id (animal_id),
  CONSTRAINT fk_production_records_animal_id FOREIGN KEY (animal_id) REFERENCES animals(animals_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_production_records_organization_id (organization_id),
  CONSTRAINT fk_production_records_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [BREEDING] herd_movements
CREATE TABLE IF NOT EXISTS herd_movements (
  herd_movements_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  livestock_group_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (herd_movements_id),
  KEY ix_herd_movements_livestock_group_id (livestock_group_id),
  CONSTRAINT fk_herd_movements_livestock_group_id FOREIGN KEY (livestock_group_id) REFERENCES livestock_groups(livestock_groups_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_herd_movements_organization_id (organization_id),
  CONSTRAINT fk_herd_movements_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] shops
CREATE TABLE IF NOT EXISTS shops (
  shops_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (shops_id),
  KEY ix_shops_organization_id (organization_id),
  CONSTRAINT fk_shops_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] shop_products
CREATE TABLE IF NOT EXISTS shop_products (
  shop_products_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  shop_id BIGINT UNSIGNED NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (shop_products_id),
  KEY ix_shop_products_shop_id (shop_id),
  CONSTRAINT fk_shop_products_shop_id FOREIGN KEY (shop_id) REFERENCES shops(shops_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_shop_products_product_id (product_id),
  CONSTRAINT fk_shop_products_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_shop_products_organization_id (organization_id),
  CONSTRAINT fk_shop_products_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] product_prices
CREATE TABLE IF NOT EXISTS product_prices (
  product_prices_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (product_prices_id),
  KEY ix_product_prices_product_id (product_id),
  CONSTRAINT fk_product_prices_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_product_prices_organization_id (organization_id),
  CONSTRAINT fk_product_prices_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] product_images
CREATE TABLE IF NOT EXISTS product_images (
  product_images_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (product_images_id),
  KEY ix_product_images_product_id (product_id),
  CONSTRAINT fk_product_images_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_product_images_organization_id (organization_id),
  CONSTRAINT fk_product_images_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] customers
CREATE TABLE IF NOT EXISTS customers (
  customers_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  person_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (customers_id),
  KEY ix_customers_person_id (person_id),
  CONSTRAINT fk_customers_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_customers_organization_id (organization_id),
  CONSTRAINT fk_customers_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] shopping_carts
CREATE TABLE IF NOT EXISTS shopping_carts (
  shopping_carts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  customer_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (shopping_carts_id),
  KEY ix_shopping_carts_customer_id (customer_id),
  CONSTRAINT fk_shopping_carts_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_shopping_carts_organization_id (organization_id),
  CONSTRAINT fk_shopping_carts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] cart_items
CREATE TABLE IF NOT EXISTS cart_items (
  cart_items_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  shopping_cart_id BIGINT UNSIGNED NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (cart_items_id),
  KEY ix_cart_items_shopping_cart_id (shopping_cart_id),
  CONSTRAINT fk_cart_items_shopping_cart_id FOREIGN KEY (shopping_cart_id) REFERENCES shopping_carts(shopping_carts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_cart_items_product_id (product_id),
  CONSTRAINT fk_cart_items_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_cart_items_organization_id (organization_id),
  CONSTRAINT fk_cart_items_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] sales_orders
CREATE TABLE IF NOT EXISTS sales_orders (
  sales_orders_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  order_number VARCHAR(100) NOT NULL,
  ordered_at DATETIME NOT NULL,
  status VARCHAR(40) NOT NULL DEFAULT 'PENDING',
  organization_id BIGINT UNSIGNED NULL,
  customer_id BIGINT UNSIGNED NULL,
  shop_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (sales_orders_id),
  KEY ix_sales_orders_organization_id (organization_id),
  CONSTRAINT fk_sales_orders_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_sales_orders_customer_id (customer_id),
  CONSTRAINT fk_sales_orders_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_sales_orders_shop_id (shop_id),
  CONSTRAINT fk_sales_orders_shop_id FOREIGN KEY (shop_id) REFERENCES shops(shops_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] sales_order_items
CREATE TABLE IF NOT EXISTS sales_order_items (
  sales_order_items_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  quantity DECIMAL(14,3) NOT NULL,
  unit_price DECIMAL(14,2) NOT NULL,
  sales_order_id BIGINT UNSIGNED NULL,
  product_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (sales_order_items_id),
  KEY ix_sales_order_items_sales_order_id (sales_order_id),
  CONSTRAINT fk_sales_order_items_sales_order_id FOREIGN KEY (sales_order_id) REFERENCES sales_orders(sales_orders_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_sales_order_items_product_id (product_id),
  CONSTRAINT fk_sales_order_items_product_id FOREIGN KEY (product_id) REFERENCES products(products_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_sales_order_items_organization_id (organization_id),
  CONSTRAINT fk_sales_order_items_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT chk_sales_order_items_qty CHECK (quantity > 0)
) ENGINE=InnoDB;

-- [COMMERCE] order_status_history
CREATE TABLE IF NOT EXISTS order_status_history (
  order_status_history_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  sales_order_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (order_status_history_id),
  KEY ix_order_status_history_sales_order_id (sales_order_id),
  CONSTRAINT fk_order_status_history_sales_order_id FOREIGN KEY (sales_order_id) REFERENCES sales_orders(sales_orders_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_order_status_history_organization_id (organization_id),
  CONSTRAINT fk_order_status_history_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] shipments
CREATE TABLE IF NOT EXISTS shipments (
  shipments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  sales_order_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (shipments_id),
  KEY ix_shipments_sales_order_id (sales_order_id),
  CONSTRAINT fk_shipments_sales_order_id FOREIGN KEY (sales_order_id) REFERENCES sales_orders(sales_orders_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_shipments_organization_id (organization_id),
  CONSTRAINT fk_shipments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] shipping_addresses
CREATE TABLE IF NOT EXISTS shipping_addresses (
  shipping_addresses_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  customer_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (shipping_addresses_id),
  KEY ix_shipping_addresses_customer_id (customer_id),
  CONSTRAINT fk_shipping_addresses_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_shipping_addresses_organization_id (organization_id),
  CONSTRAINT fk_shipping_addresses_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] sales_returns
CREATE TABLE IF NOT EXISTS sales_returns (
  sales_returns_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  sales_order_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (sales_returns_id),
  KEY ix_sales_returns_sales_order_id (sales_order_id),
  CONSTRAINT fk_sales_returns_sales_order_id FOREIGN KEY (sales_order_id) REFERENCES sales_orders(sales_orders_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_sales_returns_organization_id (organization_id),
  CONSTRAINT fk_sales_returns_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] refunds
CREATE TABLE IF NOT EXISTS refunds (
  refunds_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  sales_return_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (refunds_id),
  KEY ix_refunds_sales_return_id (sales_return_id),
  CONSTRAINT fk_refunds_sales_return_id FOREIGN KEY (sales_return_id) REFERENCES sales_returns(sales_returns_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_refunds_organization_id (organization_id),
  CONSTRAINT fk_refunds_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] discounts
CREATE TABLE IF NOT EXISTS discounts (
  discounts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (discounts_id),
  KEY ix_discounts_organization_id (organization_id),
  CONSTRAINT fk_discounts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] coupons
CREATE TABLE IF NOT EXISTS coupons (
  coupons_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  discount_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (coupons_id),
  KEY ix_coupons_discount_id (discount_id),
  CONSTRAINT fk_coupons_discount_id FOREIGN KEY (discount_id) REFERENCES discounts(discounts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_coupons_organization_id (organization_id),
  CONSTRAINT fk_coupons_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [COMMERCE] payment_provider_transactions
CREATE TABLE IF NOT EXISTS payment_provider_transactions (
  payment_provider_transactions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  sales_order_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (payment_provider_transactions_id),
  KEY ix_payment_provider_transactions_sales_order_id (sales_order_id),
  CONSTRAINT fk_payment_provider_transactions_sales_order_id FOREIGN KEY (sales_order_id) REFERENCES sales_orders(sales_orders_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_payment_provider_transactions_organization_id (organization_id),
  CONSTRAINT fk_payment_provider_transactions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] contacts
CREATE TABLE IF NOT EXISTS contacts (
  contacts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  person_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (contacts_id),
  KEY ix_contacts_person_id (person_id),
  CONSTRAINT fk_contacts_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_contacts_organization_id (organization_id),
  CONSTRAINT fk_contacts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] contact_tags
CREATE TABLE IF NOT EXISTS contact_tags (
  contact_tags_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (contact_tags_id),
  KEY ix_contact_tags_organization_id (organization_id),
  CONSTRAINT fk_contact_tags_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] contact_tag_assignments
CREATE TABLE IF NOT EXISTS contact_tag_assignments (
  contact_tag_assignments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  contact_id BIGINT UNSIGNED NULL,
  contact_tag_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (contact_tag_assignments_id),
  KEY ix_contact_tag_assignments_contact_id (contact_id),
  CONSTRAINT fk_contact_tag_assignments_contact_id FOREIGN KEY (contact_id) REFERENCES contacts(contacts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_contact_tag_assignments_contact_tag_id (contact_tag_id),
  CONSTRAINT fk_contact_tag_assignments_contact_tag_id FOREIGN KEY (contact_tag_id) REFERENCES contact_tags(contact_tags_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_contact_tag_assignments_organization_id (organization_id),
  CONSTRAINT fk_contact_tag_assignments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] communication_preferences
CREATE TABLE IF NOT EXISTS communication_preferences (
  communication_preferences_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  contact_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (communication_preferences_id),
  KEY ix_communication_preferences_contact_id (contact_id),
  CONSTRAINT fk_communication_preferences_contact_id FOREIGN KEY (contact_id) REFERENCES contacts(contacts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_communication_preferences_organization_id (organization_id),
  CONSTRAINT fk_communication_preferences_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] marketing_consents
CREATE TABLE IF NOT EXISTS marketing_consents (
  marketing_consents_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  contact_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (marketing_consents_id),
  KEY ix_marketing_consents_contact_id (contact_id),
  CONSTRAINT fk_marketing_consents_contact_id FOREIGN KEY (contact_id) REFERENCES contacts(contacts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_marketing_consents_organization_id (organization_id),
  CONSTRAINT fk_marketing_consents_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] marketing_campaigns
CREATE TABLE IF NOT EXISTS marketing_campaigns (
  marketing_campaigns_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NOT NULL,
  starts_on DATE,
  ends_on DATE,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (marketing_campaigns_id),
  KEY ix_marketing_campaigns_organization_id (organization_id),
  CONSTRAINT fk_marketing_campaigns_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] campaign_audiences
CREATE TABLE IF NOT EXISTS campaign_audiences (
  campaign_audiences_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  marketing_campaign_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (campaign_audiences_id),
  KEY ix_campaign_audiences_marketing_campaign_id (marketing_campaign_id),
  CONSTRAINT fk_campaign_audiences_marketing_campaign_id FOREIGN KEY (marketing_campaign_id) REFERENCES marketing_campaigns(marketing_campaigns_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_campaign_audiences_organization_id (organization_id),
  CONSTRAINT fk_campaign_audiences_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] campaign_messages
CREATE TABLE IF NOT EXISTS campaign_messages (
  campaign_messages_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  marketing_campaign_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (campaign_messages_id),
  KEY ix_campaign_messages_marketing_campaign_id (marketing_campaign_id),
  CONSTRAINT fk_campaign_messages_marketing_campaign_id FOREIGN KEY (marketing_campaign_id) REFERENCES marketing_campaigns(marketing_campaigns_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_campaign_messages_organization_id (organization_id),
  CONSTRAINT fk_campaign_messages_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] campaign_performance
CREATE TABLE IF NOT EXISTS campaign_performance (
  campaign_performance_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  marketing_campaign_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (campaign_performance_id),
  KEY ix_campaign_performance_marketing_campaign_id (marketing_campaign_id),
  CONSTRAINT fk_campaign_performance_marketing_campaign_id FOREIGN KEY (marketing_campaign_id) REFERENCES marketing_campaigns(marketing_campaigns_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_campaign_performance_organization_id (organization_id),
  CONSTRAINT fk_campaign_performance_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] social_media_accounts
CREATE TABLE IF NOT EXISTS social_media_accounts (
  social_media_accounts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (social_media_accounts_id),
  KEY ix_social_media_accounts_organization_id (organization_id),
  CONSTRAINT fk_social_media_accounts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] social_media_posts
CREATE TABLE IF NOT EXISTS social_media_posts (
  social_media_posts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  social_media_account_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (social_media_posts_id),
  KEY ix_social_media_posts_social_media_account_id (social_media_account_id),
  CONSTRAINT fk_social_media_posts_social_media_account_id FOREIGN KEY (social_media_account_id) REFERENCES social_media_accounts(social_media_accounts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_social_media_posts_organization_id (organization_id),
  CONSTRAINT fk_social_media_posts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] events
CREATE TABLE IF NOT EXISTS events (
  events_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(180) NOT NULL,
  starts_at DATETIME NOT NULL,
  ends_at DATETIME,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (events_id),
  KEY ix_events_organization_id (organization_id),
  CONSTRAINT fk_events_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] event_registrations
CREATE TABLE IF NOT EXISTS event_registrations (
  event_registrations_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  event_id BIGINT UNSIGNED NULL,
  person_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (event_registrations_id),
  KEY ix_event_registrations_event_id (event_id),
  CONSTRAINT fk_event_registrations_event_id FOREIGN KEY (event_id) REFERENCES events(events_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_event_registrations_person_id (person_id),
  CONSTRAINT fk_event_registrations_person_id FOREIGN KEY (person_id) REFERENCES persons(persons_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_event_registrations_organization_id (organization_id),
  CONSTRAINT fk_event_registrations_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] event_volunteers
CREATE TABLE IF NOT EXISTS event_volunteers (
  event_volunteers_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  event_id BIGINT UNSIGNED NULL,
  volunteer_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (event_volunteers_id),
  KEY ix_event_volunteers_event_id (event_id),
  CONSTRAINT fk_event_volunteers_event_id FOREIGN KEY (event_id) REFERENCES events(events_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_event_volunteers_volunteer_id (volunteer_id),
  CONSTRAINT fk_event_volunteers_volunteer_id FOREIGN KEY (volunteer_id) REFERENCES volunteers(volunteers_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_event_volunteers_organization_id (organization_id),
  CONSTRAINT fk_event_volunteers_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] event_sponsors
CREATE TABLE IF NOT EXISTS event_sponsors (
  event_sponsors_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  event_id BIGINT UNSIGNED NULL,
  sponsor_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (event_sponsors_id),
  KEY ix_event_sponsors_event_id (event_id),
  CONSTRAINT fk_event_sponsors_event_id FOREIGN KEY (event_id) REFERENCES events(events_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_event_sponsors_sponsor_id (sponsor_id),
  CONSTRAINT fk_event_sponsors_sponsor_id FOREIGN KEY (sponsor_id) REFERENCES sponsors(sponsors_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_event_sponsors_organization_id (organization_id),
  CONSTRAINT fk_event_sponsors_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] newsletter_subscriptions
CREATE TABLE IF NOT EXISTS newsletter_subscriptions (
  newsletter_subscriptions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  contact_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (newsletter_subscriptions_id),
  KEY ix_newsletter_subscriptions_contact_id (contact_id),
  CONSTRAINT fk_newsletter_subscriptions_contact_id FOREIGN KEY (contact_id) REFERENCES contacts(contacts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_newsletter_subscriptions_organization_id (organization_id),
  CONSTRAINT fk_newsletter_subscriptions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [MARKETING] communication_logs
CREATE TABLE IF NOT EXISTS communication_logs (
  communication_logs_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  contact_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (communication_logs_id),
  KEY ix_communication_logs_contact_id (contact_id),
  CONSTRAINT fk_communication_logs_contact_id FOREIGN KEY (contact_id) REFERENCES contacts(contacts_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_communication_logs_organization_id (organization_id),
  CONSTRAINT fk_communication_logs_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] media_files
CREATE TABLE IF NOT EXISTS media_files (
  media_files_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  storage_key VARCHAR(500) NOT NULL,
  mime_type VARCHAR(120) NOT NULL,
  original_filename VARCHAR(255),
  byte_size BIGINT UNSIGNED,
  checksum_sha256 CHAR(64),
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (media_files_id),
  KEY ix_media_files_organization_id (organization_id),
  CONSTRAINT fk_media_files_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] media_links
CREATE TABLE IF NOT EXISTS media_links (
  media_links_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  media_file_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (media_links_id),
  KEY ix_media_links_media_file_id (media_file_id),
  CONSTRAINT fk_media_links_media_file_id FOREIGN KEY (media_file_id) REFERENCES media_files(media_files_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_media_links_organization_id (organization_id),
  CONSTRAINT fk_media_links_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] document_types
CREATE TABLE IF NOT EXISTS document_types (
  document_types_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (document_types_id)
) ENGINE=InnoDB;

-- [WORKFLOW] document_versions
CREATE TABLE IF NOT EXISTS document_versions (
  document_versions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  media_file_id BIGINT UNSIGNED NULL,
  document_type_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (document_versions_id),
  KEY ix_document_versions_media_file_id (media_file_id),
  CONSTRAINT fk_document_versions_media_file_id FOREIGN KEY (media_file_id) REFERENCES media_files(media_files_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_document_versions_document_type_id (document_type_id),
  CONSTRAINT fk_document_versions_document_type_id FOREIGN KEY (document_type_id) REFERENCES document_types(document_types_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_document_versions_organization_id (organization_id),
  CONSTRAINT fk_document_versions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] document_access_logs
CREATE TABLE IF NOT EXISTS document_access_logs (
  document_access_logs_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  media_file_id BIGINT UNSIGNED NULL,
  user_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (document_access_logs_id),
  KEY ix_document_access_logs_media_file_id (media_file_id),
  CONSTRAINT fk_document_access_logs_media_file_id FOREIGN KEY (media_file_id) REFERENCES media_files(media_files_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_document_access_logs_user_id (user_id),
  CONSTRAINT fk_document_access_logs_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_document_access_logs_organization_id (organization_id),
  CONSTRAINT fk_document_access_logs_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] notifications
CREATE TABLE IF NOT EXISTS notifications (
  notifications_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  user_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (notifications_id),
  KEY ix_notifications_user_id (user_id),
  CONSTRAINT fk_notifications_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_notifications_organization_id (organization_id),
  CONSTRAINT fk_notifications_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] notification_templates
CREATE TABLE IF NOT EXISTS notification_templates (
  notification_templates_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (notification_templates_id),
  KEY ix_notification_templates_organization_id (organization_id),
  CONSTRAINT fk_notification_templates_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] notification_preferences
CREATE TABLE IF NOT EXISTS notification_preferences (
  notification_preferences_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  user_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (notification_preferences_id),
  KEY ix_notification_preferences_user_id (user_id),
  CONSTRAINT fk_notification_preferences_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_notification_preferences_organization_id (organization_id),
  CONSTRAINT fk_notification_preferences_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] scheduled_reminders
CREATE TABLE IF NOT EXISTS scheduled_reminders (
  scheduled_reminders_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (scheduled_reminders_id),
  KEY ix_scheduled_reminders_organization_id (organization_id),
  CONSTRAINT fk_scheduled_reminders_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] notification_deliveries
CREATE TABLE IF NOT EXISTS notification_deliveries (
  notification_deliveries_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  notification_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (notification_deliveries_id),
  KEY ix_notification_deliveries_notification_id (notification_id),
  CONSTRAINT fk_notification_deliveries_notification_id FOREIGN KEY (notification_id) REFERENCES notifications(notifications_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_notification_deliveries_organization_id (organization_id),
  CONSTRAINT fk_notification_deliveries_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] tasks
CREATE TABLE IF NOT EXISTS tasks (
  tasks_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(180) NOT NULL,
  status VARCHAR(40) NOT NULL DEFAULT 'TODO',
  due_at DATETIME,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (tasks_id),
  KEY ix_tasks_organization_id (organization_id),
  CONSTRAINT fk_tasks_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] task_assignments
CREATE TABLE IF NOT EXISTS task_assignments (
  task_assignments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  task_id BIGINT UNSIGNED NULL,
  user_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (task_assignments_id),
  KEY ix_task_assignments_task_id (task_id),
  CONSTRAINT fk_task_assignments_task_id FOREIGN KEY (task_id) REFERENCES tasks(tasks_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_task_assignments_user_id (user_id),
  CONSTRAINT fk_task_assignments_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_task_assignments_organization_id (organization_id),
  CONSTRAINT fk_task_assignments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] task_comments
CREATE TABLE IF NOT EXISTS task_comments (
  task_comments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  task_id BIGINT UNSIGNED NULL,
  user_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (task_comments_id),
  KEY ix_task_comments_task_id (task_id),
  CONSTRAINT fk_task_comments_task_id FOREIGN KEY (task_id) REFERENCES tasks(tasks_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_task_comments_user_id (user_id),
  CONSTRAINT fk_task_comments_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_task_comments_organization_id (organization_id),
  CONSTRAINT fk_task_comments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [WORKFLOW] task_attachments
CREATE TABLE IF NOT EXISTS task_attachments (
  task_attachments_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  task_id BIGINT UNSIGNED NULL,
  media_file_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (task_attachments_id),
  KEY ix_task_attachments_task_id (task_id),
  CONSTRAINT fk_task_attachments_task_id FOREIGN KEY (task_id) REFERENCES tasks(tasks_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_task_attachments_media_file_id (media_file_id),
  CONSTRAINT fk_task_attachments_media_file_id FOREIGN KEY (media_file_id) REFERENCES media_files(media_files_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_task_attachments_organization_id (organization_id),
  CONSTRAINT fk_task_attachments_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANALYTICS] report_definitions
CREATE TABLE IF NOT EXISTS report_definitions (
  report_definitions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (report_definitions_id),
  KEY ix_report_definitions_organization_id (organization_id),
  CONSTRAINT fk_report_definitions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANALYTICS] report_schedules
CREATE TABLE IF NOT EXISTS report_schedules (
  report_schedules_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  report_definition_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (report_schedules_id),
  KEY ix_report_schedules_report_definition_id (report_definition_id),
  CONSTRAINT fk_report_schedules_report_definition_id FOREIGN KEY (report_definition_id) REFERENCES report_definitions(report_definitions_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_report_schedules_organization_id (organization_id),
  CONSTRAINT fk_report_schedules_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANALYTICS] report_exports
CREATE TABLE IF NOT EXISTS report_exports (
  report_exports_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  report_definition_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (report_exports_id),
  KEY ix_report_exports_report_definition_id (report_definition_id),
  CONSTRAINT fk_report_exports_report_definition_id FOREIGN KEY (report_definition_id) REFERENCES report_definitions(report_definitions_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_report_exports_organization_id (organization_id),
  CONSTRAINT fk_report_exports_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANALYTICS] dashboard_preferences
CREATE TABLE IF NOT EXISTS dashboard_preferences (
  dashboard_preferences_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  user_id BIGINT UNSIGNED NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (dashboard_preferences_id),
  KEY ix_dashboard_preferences_user_id (user_id),
  CONSTRAINT fk_dashboard_preferences_user_id FOREIGN KEY (user_id) REFERENCES users(users_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_dashboard_preferences_organization_id (organization_id),
  CONSTRAINT fk_dashboard_preferences_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANALYTICS] kpi_definitions
CREATE TABLE IF NOT EXISTS kpi_definitions (
  kpi_definitions_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (kpi_definitions_id),
  KEY ix_kpi_definitions_organization_id (organization_id),
  CONSTRAINT fk_kpi_definitions_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANALYTICS] analytics_snapshots
CREATE TABLE IF NOT EXISTS analytics_snapshots (
  analytics_snapshots_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (analytics_snapshots_id),
  KEY ix_analytics_snapshots_organization_id (organization_id),
  CONSTRAINT fk_analytics_snapshots_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANALYTICS] forecast_results
CREATE TABLE IF NOT EXISTS forecast_results (
  forecast_results_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (forecast_results_id),
  KEY ix_forecast_results_organization_id (organization_id),
  CONSTRAINT fk_forecast_results_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- [ANALYTICS] operational_alerts
CREATE TABLE IF NOT EXISTS operational_alerts (
  operational_alerts_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(180) NULL,
  description TEXT NULL,
  status VARCHAR(40) NULL,
  organization_id BIGINT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (operational_alerts_id),
  KEY ix_operational_alerts_organization_id (organization_id),
  CONSTRAINT fk_operational_alerts_organization_id FOREIGN KEY (organization_id) REFERENCES organizations(organizations_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- VERIFY
SELECT COUNT(*) AS created_tables FROM information_schema.tables WHERE table_schema = DATABASE();
SELECT table_name FROM information_schema.tables WHERE table_schema = DATABASE() ORDER BY table_name;
SELECT COUNT(*) AS foreign_keys FROM information_schema.referential_constraints WHERE constraint_schema = DATABASE();
