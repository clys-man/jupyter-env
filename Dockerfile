FROM nvidia/cuda:13.2.1-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHON_VERSION=3.12
ENV JUPYTER_TOKEN=senha123
ENV PYTHONPATH=/home/jovyan/work

RUN apt-get update && apt-get install -y \
    python3.12 \
    python3.12-dev \
    python3.12-venv \
    python3-pip \
    python3.12-distutils \
    build-essential \
    curl \
    git \
    libssl-dev \
    libffi-dev \
    libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1 \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1

RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12

RUN useradd -m -s /bin/bash jovyan
WORKDIR /home/jovyan/work

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

RUN mkdir -p /home/jovyan/.jupyter
COPY jupyter_lab_config.py /home/jovyan/.jupyter/jupyter_lab_config.py

RUN chown -R jovyan:jovyan /home/jovyan

USER jovyan

EXPOSE 8888

CMD ["python3", "-m", "jupyterlab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--NotebookApp.token=${JUPYTER_TOKEN}"]
