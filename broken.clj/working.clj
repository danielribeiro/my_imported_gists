(ns light.core
   (:use [clojure.pprint :only [pprint]]))
(def p (comp println pprint))
 
(+ 1 1)

(def x (into {} (map (fn [x] [x (inc x)]) (take 1000 (range)))))
 
(p x)
 
(p 8)
