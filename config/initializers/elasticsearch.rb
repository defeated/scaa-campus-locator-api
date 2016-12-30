require 'elasticsearch/rails/instrumentation'

elasticsearch_url = ENV['ELASTICSEARCH_URL']
Elasticsearch::Model.client = Elasticsearch::Client.new log: true,
                                                        host: elasticsearch_url
