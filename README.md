It began with a [tweet](https://twitter.com/philandstuff/status/798585028984745984)

It does, of course, return 300:


    ➔ curl -I -H 'Accept: application/json' https://lunar-sword.herokuapp.com/0/0/

    HTTP/1.1 300 Multiple Choices
    Server: Cowboy
    Date: Fri, 18 Nov 2016 00:00:05 GMT
    Connection: keep-alive
    Content-Type: application/json
    Vary: Accept
    X-Content-Type-Options: nosniff
    Content-Length: 55
    Via: 1.1 vegur
