(import atexit)
(import functools)
(import hy)
(import logging)
(import os)
(import sys)
(import urllib)
; ---
(import requests)
(import [bs4 [BeautifulSoup]])

(setv
  url
  "https://govt.westlaw.com/calregs/Browse/Home/California/CaliforniaCodeofRegulations?transitionType=Default&contextData=%28sc.Default%29"
)

(defn init-log []
  "Init logging infrastructure"
  (logging.basicConfig
    :format
    "[%(asctime)s] [%(levelname)-8s] %(message)s"
    :level
    logging.DEBUG
    :datefmt
    "%Y-%m-%d %H:%M:%S"
  )
)

(defn init-hi []
  "hi :)"
  (logging.info "hi :)")
)

(defn init-bye []
  "bye :("
  (logging.info "bye :(")
)

(with-decorator functools.cache
  (defn get-http
    [url]
    "Make HTTP GET request and cache it"
    (. (requests.get url) text)
  )
)


(with-decorator functools.cache
  (defn get-soup
    [web]
    "Build soup object"
    (BeautifulSoup web "html.parser")
  )
)

(defn get-links?
  [tag]
  "Is this the right a tag"
  (and
    (.has_attr tag "name")
    (= (. tag name) "a")
  )
)

(with-decorator functools.cache
  (defn get-links
    [soup]
    "Get all links"
    (.find_all soup get-links?)
  )
)

(defn build-url
  [url]
  (urllib.parse.urlparse url)
)

(defn cache
  [func url]
)

(defn compose
  [f g]
  "Compose two functions"
  (fn [h]
    "Lambda that composes functions"
    (f (g h))
  )
)

(defn init []
  "Initialize init funcs"
  (init-log)
  (init-hi)
  (init-bye)
)

(defn body []
  "Payload of app"
  (setv func1 (compose get-soup get-http))
  (setv func2 (compose get-links func1))
  (print (func2 url))
)

(defmain
  [&rest args]
  "Main func"
  (init)
  (body)
)
