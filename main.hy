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
  base
  "https://govt.westlaw.com"
)

(defclass Init []
  "Class for init funcs"
  (with-decorator staticmethod
    (defn init-hi []
      "hi :)"
      (logging.info "hi :)")
    )
  )

  (with-decorator staticmethod
    (defn init-bye []
      "bye :("
      (logging.info "bye :(")
    )
  )

  (with-decorator staticmethod
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
  )

  (with-decorator staticmethod
    (defn init []
      "Initialize init funds"
      (init-log)
      (init-hi)
      (init-bye)
    )
  )
)


(defclass Operator []
  "Class for operators"
  (with-decorator functools.cache
    (defn get-http
      [url]
      "Make HTTP GET request and cache it"
      (. (requests.get url) text)))


  (with-decorator functools.cache
    (defn get-soup
      [html]
      "Build soup object from html"
      (BeautifulSoup html "html.parser")))

  (with-decorator functools.cache
    (defn get-links
      [soup]
      "Get all links"
      (.find_all soup get-links?)))
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
  "Initialize init funds"
  (init-log)
  (init-hi)
  (init-bye)
)

(defn build-func []
  "Build up functions sequential"
  (compose
    (. Operator get-links)
    (compose (. Operator get-soup) (. Operator get-http))
  )
)

(setv func (build-func))

(defn body []
  "Payload of app"
  (for [a (func url)]
    (print (. a text))
  )
)

(defmain
  [&rest args]
  "Main func"
  (. Init init)
  (body)
)
