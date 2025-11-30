(ns ruby-to-clojure.seq-utils)

(defn map-with-index 
  "Like clojure/map, but f should accept 2 arguments: the element and its index
  in the collection."
  [f coll]
  (map f coll (iterate inc 0)))

(defn some-index 
  "Returns the index of the first element of coll for which (f elem) returns
  logical truth, or nil of no such element exists."
  [f coll]
  (loop [rcoll coll index 0]
    (when (seq rcoll)
      (if (f (first rcoll))
        index
        (recur (rest rcoll) (inc index))))))

(defn grep
  "Returns a lazy seq of strings in coll that match the given pattern."
  [re coll]
  (filter #(re-find re %) coll))

(defn index-by
  "Returns a map from the results of invoking f on elements of coll
  to the corresponding elements.  The order of elements in the values of the map
  reflects their order in the original collection, and there may be duplicates
  if there were duplicates in the collection."
  [f coll]
    (reduce
      (fn [map x]
        (let [k (f x)]
          (assoc map k (conj (get map k []) x))))
      {}
      coll))

(defn exactly?
  "Returns true if (f x) returns logical truth for exactly n xs in coll."
  [n f coll]
  (loop [m n more coll]
    (when (seq more)
      (if (f (first more)) 
        (if (= m 1)
          (not-any? f (rest more))
          (recur (dec m) (rest more)))
        (recur m (rest more))))))
        
(defn one? 
  "Returns true if (f x) returns logical truth for exactly 1 x in coll."
  [f coll]
  (exactly? 1 f coll))


(defn remove 
  "Returns a lazy seq: (filter (complement pred) coll)."
  [pred coll]
  (filter (complement pred) coll))

(defn zip 
  "Returns a sequence of sequences where the jth element of the ith inner 
  sequence corresponds to the ith element in the jth sequence in coll."
  [& colls]
  (apply map (fn [& xs] xs) colls))

(defn ncycle
  "Returns a lazy seq of repetitions of the items in coll n times."  
  [n coll]
    (take (* n (count coll)) (cycle coll)))

(defn choice
  "Returns a random element from the given vecotr."
  [#^clojure.lang.IPersistentVector vec]
  (get vec (rand-int (count vec))))

(defn compact 
  "Returns a lazy seq of non-nil elements in coll."
  [coll]
  (remove nil? coll))

; http://groups.google.com/group/clojure/browse_thread/thread/180842eb58c58370/43239b0de45a5d56?lnk=gst&q=shuffle#
(defn shuffle
  "Returns a shuffled seq for the given coll."
  [coll]
  (let [l (java.util.ArrayList. coll)]
    (java.util.Collections/shuffle l)
    (seq l)))