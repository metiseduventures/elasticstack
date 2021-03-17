from httplib2 import Http
from json import dumps
import sys
from devopsroom import *

boturl='https://chat.googleapis.com/v1/spaces/'+roomid+'/messages?key='+key+'&token='+token+'&thread_key='+threadid
msg = 'test';
msg = sys.argv[1];

def main():
    url = boturl 
    bot_message = {
        'text' : msg}

    message_headers = { 'Content-Type': 'application/json; charset=UTF-8'}

    http_obj = Http()

    response = http_obj.request(
        uri=url,
        method='POST',
        headers=message_headers,
        body=dumps(bot_message),
    )

    print(response)

if __name__ == '__main__':
    main()

