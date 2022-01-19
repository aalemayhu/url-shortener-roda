# URL Shortener

This a URL shortener which creates short links via a JSON API.

Before setting up the project, I was talking with a friend of mine. He suggested using a microdesign pattern. This way we can deploy the two endpoints seperately.

## Structure

The code base is split into the two directories. shorten and redirect.
Shorten writes changes to the database while redirect only makes lookups.

The project is built with the [Roda][0] framework, the database interaction is done with [Sequel][1] using [PostgresSQL][2]. For caching [Redis][3] is used.

## Scope

The goal is to build a service which can handle 100M requests every month.
This amounts to roughly 37 requests per second if we divide 100M by the
number of seconds in 31 days.

## Ideas for scaling

On the writer to handle enough incoming requests we can run multiple instances of the shortener
and connect to a database cluser. This approach accepts that conflicts will arise in practice and that they can be handled by attempting retries up to 10 times. Another approach I was thinking of was to use a worker that can handle the shortening part by allocating new ones so when the an id is used, it's unused.

For the reader we can use Redis with `allkeys-lru` where the less recently used keys get removed
first with an appropriate `maxmemory`.

## Uadressed Concerns

- Is the `securerandom` secure enough?
- What is the likely hood of collisions in practice?
- How much storage for a single url?

## Acknowledgements

Thanks to [Torbjørn Tiltnes][4] for giving me this challenge!

[0]: https://github.com/jeremyevans/roda
[1]: https://github.com/jeremyevans/sequel
[2]: https://github.com/postgres/postgres
[3]: https://redis.io/
[4]: https://github.com/Tiltnes
