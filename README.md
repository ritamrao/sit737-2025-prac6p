# SIT737 – Cloud Native Application Development  
## Practical Task 6.1P – Kubernetes Cluster Deployment

---

## Overview

This project involves containerizing a Node.js + Express app and deploying it to a Kubernetes cluster using Docker Desktop.

---

## Steps

### 1. Node.js App

Basic Express app listening on port 3000.

```js
const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Welcome to SIT737 Kubernetes Node.js App!'));
app.listen(3000);
```

---

### 2. Dockerization

**Dockerfile:**
```Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]
```

Build and run:
```bash
docker build -t sit737-task6p-app .
docker run -p 3000:3000 sit737-task6p-app
```

---

### 3. Kubernetes Deployment

**deployment.yaml:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sit737-task6p-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sit737-task6p-app
  template:
    metadata:
      labels:
        app: sit737-task6p-app
    spec:
      containers:
      - name: sit737-task6p-container
        image: sit737-task6p-app
        imagePullPolicy: Never
        ports:
        - containerPort: 3000
```

---

### 4. Kubernetes Service

**service.yaml:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: sit737-task6p-service
spec:
  type: NodePort
  selector:
    app: sit737-task6p-app
  ports:
    - port: 3000
      targetPort: 3000
      nodePort: 30036
```

Apply:
```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

---

### 5. Test

Access at: `http://localhost:30036`

---
