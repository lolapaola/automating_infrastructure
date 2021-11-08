FROM python:3.9.2-slim-buster

RUN apt update && apt -y install git gcc vim itools lsof net-tools sudo

ARG USERNAME=devuser
RUN useradd --create-home $USERNAME && echo "$USERNAME:$USERNAME" | chpasswd && adduser $USERNAME sudo


ENV ANSIBLE_HOST_KEY_CHECKING=False
ENV ANSIBLE_RETRY_FILES_ENABLED=False
ENV ANSIBLE_SSH_PIPELINING=True
ENV ANSIBLE_CONFIG=/home/$USERNAME/ansible.cfg
ENV ANSIBLE_PYTHON_INTERPRETER=/usr/local/bin/python
ENV ANSIBLE_ROLES_PATH=/home/$USERNAME/roles
ENV ANSIBLE_COLLECTIONS_PATHS=/home/$USERNAME/collections
ENV ANSIBLE_CALLABLE_WHITELIST=profile_tasks
ENV ANSIBLE_INVENTORY=/home/$USERNAME/ansible/inventory

COPY requirements*.txt /home/$USERNAME/
COPY collections/requirements.yml /home/$USERNAME/collections/

# Install Python and Ansible dependencies
RUN pip install -r /home/$USERNAME/requirements-dev.txt && \
    ansible-galaxy collection install -r /home/$USERNAME/collections/requirements.yml

COPY . /home/$USERNAME/
WORKDIR /home/$USERNAME

# Install pre-commit hook
# RUN  pre-commit install

# [Optional] Set the default user
USER $USERNAME
CMD /bin/bash