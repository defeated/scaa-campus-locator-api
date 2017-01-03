# SCAA Campus API

It bummed me out that the data on http://scaaeducation.org/campuses/ is kind
of unusable (sorted by name instead of locale) and unsearchable.

So I hacked this little API together. Below are the interesting bits:

## TL;DR

Docs at http://docs.scaacampuslocator.apiary.io/

## Details

1. Nokogiri to parse content from SCAA paginated website.
  [code](lib/scaa/campus/parser.rb)
2. Google geocoding API to get address latitude & longitude.
  [code](lib/scaa/campus/geocoder.rb)
3. Elasticsearch to search campuses by distance.
  [code](lib/scaa/campus/indexer.rb) -
  [code](app/models/campus.rb)
4. Rake task runs each night. `rake scaa:campus:rebuild`
  [code](lib/tasks/scaa/campus.rake)
5. Ruby 2.4 + Rails 5 API
6. JSONAPI Resources
  [code](app/resources/api/v1/campus_resource.rb) -
  [code](app/resources/api/v1/campus_search_resource.rb) -
  [code](app/controllers/api/v1/campuses_controller.rb)
7. Hosted on Heroku (because easy mode.)

## Try it

Sorry, no frontend yet (WIP) but you can curl the
live API at http://scaa-campus-locator.herokuapp.com
