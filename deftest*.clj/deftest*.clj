(require 'clojure.test)

; Source: https://gist.github.com/mybuddymichael/4425558
(defmacro spec
  [name-string & body]
  (let [name-symbol
        (-> name-string
          clojure.string/lower-case
          (clojure.string/replace #"\W" "-")
          (clojure.string/replace #"-+" "-")
          (clojure.string/replace #"-$" "")
          symbol)]
    `(clojure.test/deftest ~name-symbol ~@body)))
; ignoring specs
(defmacro xspec [name-string & body])

(macroexpand-1 '(spec "this is a test" (is true)))
;=> (clojure.test/deftest this-is-a-test (is true))