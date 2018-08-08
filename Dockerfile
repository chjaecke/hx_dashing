FROM 		ruby
MAINTAINER	Christian Jaeckel "chjaecke@cisco.com"

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# Install dashing and bundle
RUN gem install dashing
RUN gem install bundle
RUN gem install twitter

# Add Dashing files and startup script
ADD start.sh /start.sh
ADD hx_dashboard /hx_dashboard

# Start dashboard
CMD ["bash", "/start.sh"]