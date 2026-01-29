FROM alpine:3.19

# Install essential dependencies including zsh
RUN apk add --no-cache \
    bash \
    zsh \
    curl \
    git \
    jq \
    unzip \
    python3 \
    py3-pip \
    ca-certificates \
    gcompat \
    libstdc++ \
    aws-cli

# Create vscode user for dev container compatibility
RUN addgroup -g 1000 vscode && \
    adduser -D -u 1000 -G vscode -s /bin/zsh vscode

# Install oh-my-zsh for vscode user
RUN su - vscode -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'

# Install aws-sso-util
RUN pip3 install --no-cache-dir aws-sso-util --break-system-packages

# Install tfswitch
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

# Configure zsh to source bin files on startup and set right prompt
RUN echo '' >> /home/vscode/.zshrc \
    && echo '# Enable bash completion compatibility' >> /home/vscode/.zshrc \
    && echo 'autoload -Uz compinit bashcompinit' >> /home/vscode/.zshrc \
    && echo 'compinit' >> /home/vscode/.zshrc \
    && echo 'bashcompinit' >> /home/vscode/.zshrc \
    && echo '' >> /home/vscode/.zshrc \
    && echo '# Source bin directory files' >> /home/vscode/.zshrc \
    && echo 'if [ -d "/workspace/.devcontainer/.zshrc.d" ]; then' >> /home/vscode/.zshrc \
    && echo '  for file in /workspace/.devcontainer/.zshrc.d/*.sh; do' >> /home/vscode/.zshrc \
    && echo '    if [ -f "$file" ]; then' >> /home/vscode/.zshrc \
    && echo '      source "$file"' >> /home/vscode/.zshrc \
    && echo '    fi' >> /home/vscode/.zshrc \
    && echo '  done' >> /home/vscode/.zshrc \
    && echo 'fi' >> /home/vscode/.zshrc \
    && echo '' >> /home/vscode/.zshrc

# Terraform will be installed here using tfswitch
RUN echo 'export PATH="$PATH:/home/vscode/bin"' >> /home/vscode/.zshrc

# Set the default user
USER vscode

# Ensure .aws directory exists
RUN mkdir -p /home/vscode/.aws

# Ensure tfswitch terraform install path exists
RUN mkdir -p /home/vscode/bin

# Install latest version of terraorm by default to enable formatter on start
RUN tfswitch -u

# Set working directory
WORKDIR /workspace
