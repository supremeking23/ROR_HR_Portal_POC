# Use official Ruby image
FROM ruby:3.4.2

# Set working directory
WORKDIR /app

# Install system dependencies, and to keep the image lean
RUN apt-get update -qq && \
    apt-get install -y build-essential default-libmysqlclient-dev nodejs && \
    rm -rf /var/lib/apt/lists/*


# Copy Gemfiles and install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copy the rest of the app
COPY . .

# Expose Rails port
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
