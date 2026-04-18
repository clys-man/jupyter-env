FROM python:3.12-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV JUPYTER_TOKEN=senha123
ENV PYTHONPATH=/home/jovyan/work

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libssl-dev \
    libffi-dev \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Criar usuário não-root
RUN useradd -m -s /bin/bash jovyan

# Instalar bibliotecas Python
RUN pip install --no-cache-dir \
    jupyterlab \
    ipywidgets \
    matplotlib \
    numpy \
    scipy \
    pandas \
    seaborn \
    scikit-learn \
    polars \
    plotly \
    statsmodels \
    mysql-connector-python \
    sqlalchemy \
    PyMySQL \
    torch \
    torchvision \
    torchaudio \
    --extra-index-url https://download.pytorch.org/whl/cu121

# Configurar JupyterLab
RUN mkdir -p /home/jovyan/.jupyter
COPY jupyter_lab_config.py /home/jovyan/.jupyter/jupyter_lab_config.py
RUN chown -R jovyan:jovyan /home/jovyan

USER jovyan
WORKDIR /home/jovyan/work

EXPOSE 8888

CMD ["python3", "-m", "jupyterlab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser"]
