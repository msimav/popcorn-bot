# -*- coding: utf-8 -*-
import os
import requests

GIF = os.getenv('GIF_URL', 'https://media.giphy.com/media/pUeXcg80cO8I8/giphy.gif')
BASE = 'https://api.telegram.org/bot%s' % (os.environ['TOKEN'],)


def send_gif(chat_id):
    requests.post(BASE + '/sendDocument', json={'chat_id': chat_id, 'document': GIF})


def send_fuck_you(chat_id):
    requests.post(BASE + '/sendMessage', json={'chat_id': chat_id, 'text': u'🖕🏻'})


def handler(event, context):
    if 'message' in event and 'text' in event['message']:
        chat_id = event['message']['chat']['id']
        msg = event['message']['text']
        if msg == '/popcorn':
            send_gif(chat_id)
        elif msg == '/popcorndegilUSTUNEBASMA':
            send_fuck_you(chat_id)
