(import atexit)
(import functools)
(import hy)
(import logging)
(import os)
(import sys)
(import urllib)
; ---
(import bs4)
(import requests)

(setv
  url
  "https://govt.westlaw.com/calregs/Browse/Home/California/CaliforniaCodeofRegulations?transitionType=Default&contextData=%28sc.Default%29"
)

(defn init-log
  []
  (logging.basicConfig
    :format
    "[%(asctime)s] [%(levelname)-8s] %(message)s"
    :level
    logging.DEBUG
    :datefmt
    "%Y-%m-%d %H:%M:%S"
  )
)

(defn init-hi
  []
  (logging.info "hi :)")
)

(defn init-bye
  []
  (logging.info "bye :(")
)

(with-decorator functools.cache
  (defn get-http
    [url]
    (requests.get url)
  )
)

(defn build-url
  [url]
  (urllib.parse.urlparse url)
)

(defn cache
  [func url]
)

(defn init
  []
  (init-log)
  (init-hi)
  (init-bye)
)

(defn main
  []
  (init)
)

(if (= __name__ "__main__")
    (main))
