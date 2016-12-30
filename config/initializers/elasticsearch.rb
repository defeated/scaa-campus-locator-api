require 'elasticsearch/rails/instrumentation'

elasticsearch_url = Rails.application.secrets.elasticsearch_url
Elasticsearch::Model.client = Elasticsearch::Client.new log: true,
                                                        host: elasticsearch_url
