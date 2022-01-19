# URL Shortener

This a URL shortener which creates short links via a JSON API.

## Scope

The plan is to build a service which can handle 100M requests every month.
This amounts to roughly 37 requests per second if we divide 100M by the
number of seconds in 31 days.

## Structure

The code base is split into the following directories shorten and redirect.
Shorten writes changes to the database while redirect only makes lookups.

The project is built with the [Roda][0] framework, the database interaction is done with [Sequel][1] using [PostgresSQL][2]. For caching [Redis][3] is used.

[0]: https://github.com/jeremyevans/roda
[1]: https://github.com/jeremyevans/sequel
[2]: https://github.com/postgres/postgres
[3]: https://redis.io/
