set :stage, :vagrant

server 'localhost', user: 'funamushi', roles: %w{web app}, ssh_options: {port: 2222}
