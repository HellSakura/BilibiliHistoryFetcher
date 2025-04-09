FROM python:3.11.11 AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

FROM python:3.11.11-slim
WORKDIR /app/BilibiliHistoryFetcher
COPY --from=builder /root/.local /root/.local
COPY . .
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*
ENV PATH=/root/.local/bin:$PATH \
    PYTHONUNBUFFERED=1

EXPOSE 8899
CMD ["python", "main.py"]