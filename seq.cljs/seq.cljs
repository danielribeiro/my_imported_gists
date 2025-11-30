(js-obj "a" 1)

(extend-type js/Number ISeqable (-seq [v] [v]))

(extend-type js/Number ISeqable (-seq [v] v ))

(extend-type js/Number ISeqable (-seq [v] v ))
;(extend-type js/Number ISeqable (-sieq [v] v ))

(map identity 1)


(extend-type number ISeq (-seq [x] x))

(-prototype ISeq)