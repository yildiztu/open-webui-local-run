# Create a Dockerfile for Open WebUI
FROM python:3.11-slim
RUN pip install open-webui
EXPOSE 8080
CMD ["open-webui", "serve", "--host", "0.0.0.0", "--port", "8080"]