# Essential Files Setup - Create these files one by one

# =============================================================================
# 1. Create README.md in root directory
# =============================================================================
cat > README.md << 'EOF'
# Algorithmic Trading Platform

A full-stack algorithmic trading application with Java Spring Boot backend and React TypeScript frontend.

## 🚀 Quick Start

### Prerequisites
- Java 17+
- Node.js 16+
- Maven 3.6+

### Setup
```bash
# Backend
cd backend && mvn clean install && mvn spring-boot:run

# Frontend (new terminal)
cd frontend && npm install && npm start
```

### Access
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000

## 🔧 Features
- Real-time trading dashboard
- Strategy management
- WebSocket integration
- Market data visualization
- Docker deployment ready
EOF

# =============================================================================
# 2. Create backend/pom.xml
# =============================================================================
mkdir -p backend
cat > backend/pom.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.1.0</version>
        <relativePath/>
    </parent>
    <groupId>com.tradingplatform</groupId>
    <artifactId>algo-trading-backend</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>algo-trading-backend</name>
    <description>Algorithmic Trading Platform Backend</description>
    <properties>
        <java.version>17</java.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-websocket</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
EOF

# =============================================================================
# 3. Create backend folder structure and basic application
# =============================================================================
mkdir -p backend/src/main/java/com/tradingplatform
mkdir -p backend/src/main/resources

cat > backend/src/main/java/com/tradingplatform/AlgoTradingApplication.java << 'EOF'
package com.tradingplatform;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class AlgoTradingApplication {
    public static void main(String[] args) {
        SpringApplication.run(AlgoTradingApplication.class, args);
    }
}
EOF

cat > backend/src/main/resources/application.properties << 'EOF'
# Server Configuration
server.port=5000

# Database Configuration (H2 in-memory)
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=

# JPA Configuration
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=true

# H2 Console
spring.h2.console.enabled=true

# CORS Configuration
spring.web.cors.allowed-origins=http://localhost:3000
spring.web.cors.allowed-methods=GET,POST,PUT,DELETE,OPTIONS
spring.web.cors.allowed-headers=*
spring.web.cors.allow-credentials=true
EOF

# =============================================================================
# 4. Create frontend package.json
# =============================================================================
mkdir -p frontend/src frontend/public

cat > frontend/package.json << 'EOF'
{
  "name": "algo-trading-frontend",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "@testing-library/jest-dom": "^5.16.4",
    "@testing-library/react": "^13.3.0",
    "@testing-library/user-event": "^13.5.0",
    "@types/jest": "^27.5.2",
    "@types/node": "^16.11.47",
    "@types/react": "^18.0.15",
    "@types/react-dom": "^18.0.6",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-scripts": "5.0.1",
    "typescript": "^4.7.4",
    "web-vitals": "^2.1.4",
    "recharts": "^2.8.0",
    "lucide-react": "^0.263.1",
    "tailwindcss": "^3.3.3",
    "autoprefixer": "^10.4.14",
    "postcss": "^8.4.27"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "eslintConfig": {
    "extends": [
      "react-app",
      "react-app/jest"
    ]
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  }
}
EOF

# =============================================================================
# 5. Create basic frontend files
# =============================================================================
cat > frontend/public/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="theme-color" content="#000000" />
    <meta name="description" content="Algorithmic Trading Platform" />
    <title>AlgoTrading Platform</title>
  </head>
  <body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"></div>
  </body>
</html>
EOF

cat > frontend/src/index.tsx << 'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

cat > frontend/src/App.tsx << 'EOF'
import React from 'react';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>Algorithmic Trading Platform</h1>
        <p>Backend: <a href="http://localhost:5000/health" target="_blank" rel="noopener noreferrer">http://localhost:5000</a></p>
        <p>Setting up the trading dashboard...</p>
      </header>
    </div>
  );
}

export default App;
EOF

cat > frontend/src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.App {
  text-align: center;
}

.App-header {
  background-color: #282c34;
  padding: 20px;
  color: white;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
EOF

cat > frontend/src/App.css << 'EOF'
/* App specific styles will go here */
EOF

# =============================================================================
# 6. Create TypeScript config
# =============================================================================
cat > frontend/tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "es5",
    "lib": [
      "dom",
      "dom.iterable",
      "es6"
    ],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noFallthroughCasesInSwitch": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx"
  },
  "include": [
    "src"
  ]
}
EOF

# =============================================================================
# 7. Create Tailwind config
# =============================================================================
cat > frontend/tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOF

# =============================================================================
# 8. Create .gitignore
# =============================================================================
cat > .gitignore << 'EOF'
# Java/Maven
backend/target/
*.jar
*.war
*.ear
*.class

# Node.js/React
frontend/node_modules/
frontend/build/
npm-debug.log*

# IDEs
.idea/
.vscode/
*.swp

# OS
.DS_Store
Thumbs.db

# Logs
*.log

# Environment variables
.env
.env.local
EOF

echo "✅ Essential files created!"
echo ""
echo "🚀 Next steps:"
echo "1. Test backend: cd backend && mvn spring-boot:run"
echo "2. Test frontend: cd frontend && npm install && npm start"
echo "3. Add complete application code from the provided artifacts"
echo "4. Commit to git: git add . && git commit -m 'Initial setup' && git push"