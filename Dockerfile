# Kaggle向けのデータサイエンス環境 (Python 3.12 + 必要なライブラリ)
FROM python:3.12-slim

# 環境変数の設定
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    DEBIAN_FRONTEND=noninteractive

# 作業ディレクトリ
WORKDIR /app

# 必要なパッケージのインストール
RUN apt update && apt install -y \
    curl \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Kaggle API クライアントをインストール
RUN pip install --upgrade pip && \
    pip install kaggle jupyterlab && \
    mkdir -p ~/.kaggle

# 依存関係をインストール
COPY requirements.txt .
RUN pip install -r requirements.txt

# Jupyterの設定
EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--NotebookApp.token=''"]