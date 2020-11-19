FROM tensorflow/tensorflow:1.15.4-gpu-py3-jupyter

ENV APP_PATH /usr/src/app
ENV PYTHONPATH ${APP_PATH}

COPY requirements.txt .
RUN pip install -r requirements.txt

WORKDIR ${APP_PATH}
CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter lab --ip 0.0.0.0 --no-browser --allow-root"]