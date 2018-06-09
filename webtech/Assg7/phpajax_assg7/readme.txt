The onreadystatechange Event

The readyState property holds the status of the XMLHttpRequest.

The onreadystatechange event is triggered every time the readyState changes.

During a server request, the readyState changes from 0 to 4:

0: request not initialized
1: server connection established
2: request received
3: processing request
4: request finished and response is ready

In the onreadystatechange property, specify a function to be executed when the readyState changes:





open(method, url, async) 	Specifies the type of request
        method: the type of request: GET or POST
        url: the file location
        async: true (asynchronous) or false (synchronous)
send() 	Sends a request to the server (used for GET)
send(string) 	Sends a request string to the server (used for POST)