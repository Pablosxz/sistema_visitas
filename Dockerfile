# Use a imagem oficial do Ruby como base
FROM ruby:3.2.2

# Instale dependências do sistema
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Defina o diretório de trabalho dentro do container
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock para o container
COPY Gemfile Gemfile.lock /app/

# Defina o ambiente como produção
ENV RAILS_ENV=production

# Instale as gems de produção
RUN bundle config set without 'development test' && \
    bundle install

# Copie todo o código da aplicação para o container
COPY . /app

# Pré-compile os assets
RUN bundle exec rake assets:precompile RAILS_ENV=production

# Exponha a porta 3000 (porta padrão do Rails)
EXPOSE 3000

# Comando para rodar a aplicação
CMD ["rails", "server", "-b", "0.0.0.0"]