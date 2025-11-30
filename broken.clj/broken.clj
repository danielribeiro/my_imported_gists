; Gives warning: Assert failed....
(ns light.core
(:use [clojure.pprint]))
(def p pprint)
  
(+ 1 1)

(def x (into {} (map (fn [x] [x (inc x)]) (take 1000 (range)))))
 
(pprint x)
 
(pprint 8)