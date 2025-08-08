# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this module.

## Module Overview

The `authorization_server-db` module manages database schema and data for the OAuth2 authorization server of the ERP system. This is a database-only module that uses Liquibase for schema migrations and provides Docker containerization for PostgreSQL database instances supporting OAuth2 authentication and authorization.

## Technology Stack

- **Database**: PostgreSQL
- **Migration Tool**: Liquibase
- **Container**: Docker
- **Package Manager**: npm
- **Testing**: Cucumber.js with BDD approach
- **Test Database**: pg-promise for database connections

## Project Structure

```
authorization_server-db/
├── Dockerfile                    # Database container configuration
├── database_change_log.yml       # Liquibase main changelog
├── package.json                 # Node.js dependencies and scripts
├── package-lock.json            # Exact dependency versions
├── sql/                         # Database initialization scripts
│   ├── 01-install-extensions.sql
│   ├── 02-create-database.sql
│   └── 03-initial-data.sql
└── features/                    # BDD test specifications (if present)
    ├── step_definitions/
    └── support/
```

## Build and Development Commands

### Database Operations
```bash
# Install dependencies
npm install

# Build database schema (offline)
npm run build:database

# Build Docker container
npm run build:docker

# Apply database changes to running database
npm run update_database

# Start database container
npm run start

# Push container to registry
npm run push

# Clean up build artifacts and containers
npm run clean
```

### Testing
```bash
# Run BDD tests for authorization database
npm test
```

## Development Workflow

### OAuth2 Database Schema Management
1. **OAuth2 Tables**: Manage standard OAuth2 tables (clients, tokens, authorizations, consents)
2. **User Management**: Handle user authentication data and authorities
3. **Schema Changes**: Add new changesets to `database_change_log.yml`
4. **Test Changes**: Use Liquibase offline generation to verify SQL
5. **Apply Changes**: Deploy to development database
6. **Write Tests**: Create BDD scenarios for OAuth2 functionality

### Key OAuth2 Database Components

#### Standard OAuth2 Tables
- **oauth2_registered_client**: Client application registrations
- **oauth2_authorization**: Active authorization grants and tokens
- **oauth2_authorization_consent**: User consent records
- **users**: User authentication information
- **authorities**: User roles and permissions

#### Database Security Considerations
- **Token Storage**: Secure storage of access and refresh tokens
- **Client Secrets**: Encrypted storage of client credentials
- **User Credentials**: Hashed password storage
- **Audit Trails**: Token usage and authentication events

## Configuration Details

### Database Connection
- **Target Database**: OAuth2 authorization data
- **Default Port**: 5432
- **Container Integration**: Designed for microservice architecture

### Liquibase Configuration
- **Main Changelog**: `database_change_log.yml`
- **Change Tracking**: Automated changelog table management
- **Environment Support**: Development, staging, and production configurations

## Testing Standards

### OAuth2-Specific Testing
- **Token Management**: Test token creation, validation, and expiration
- **Client Registration**: Verify client application management
- **User Authentication**: Test user login and authorization flows
- **Consent Management**: Validate user permission grants
- **Security**: Test authorization failures and edge cases

### BDD Test Organization
- **Authentication Flows**: Login, logout, and session management
- **Authorization Grants**: Authorization code, client credentials, etc.
- **Token Operations**: Token refresh, revocation, and validation
- **Client Management**: Client registration and configuration
- **Security Scenarios**: Failed authentication and authorization attempts

## Security Considerations

### Database Security
- **Access Control**: Restricted database user permissions
- **Encryption**: Sensitive data encryption at rest
- **Connection Security**: SSL/TLS for database connections
- **Backup Security**: Encrypted backups with key management

### OAuth2 Security Standards
- **PKCE Support**: Proof Key for Code Exchange implementation
- **Scope Management**: Fine-grained permission scoping
- **Token Security**: Secure token generation and validation
- **Client Authentication**: Multiple client authentication methods

## Docker Integration

The module produces a Docker container named `erpmicroservices/authorization_server-db` that:
- Extends PostgreSQL base image
- Initializes OAuth2 database schema
- Configures appropriate security settings
- Integrates with authorization server application
- Supports horizontal scaling and replication

## Dependencies and Requirements

### Runtime Dependencies
- PostgreSQL database server (12+ recommended)
- Docker (for containerized deployment)
- Liquibase (managed through npm scripts)

### Development Dependencies
- Node.js and npm
- Cucumber.js testing framework
- Chai assertion library
- pg-promise for database connectivity

## Integration Points

### Authorization Server Integration
- **Spring Security OAuth2**: Compatible with Spring Authorization Server
- **Token Storage**: Provides persistent token storage
- **User Details**: Integrates with Spring Security UserDetailsService
- **Client Details**: Supports Spring Security ClientDetailsService

### Microservice Architecture
- **Service Discovery**: Database service registration
- **Configuration Management**: Externalized database configuration
- **Health Checks**: Database health monitoring endpoints
- **Metrics**: Database performance and usage metrics

## Important Notes

- **OAuth2 Compliance**: Implements OAuth2 and OpenID Connect specifications
- **Security First**: Security considerations are paramount for authorization data
- **Token Lifecycle**: Proper management of token creation, renewal, and expiration
- **Audit Requirements**: Comprehensive logging for security and compliance
- **High Availability**: Design supports clustering and failover scenarios
- **Performance**: Optimized for high-frequency token validation operations