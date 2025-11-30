require 'json'
require 'ostruct'
require 'pp'

str = { woo: [ 1, 2, 3], yay: { foo: true, bar: ["42", 2, {}] } }.to_json
pp JSON.parse(str, object_class: OpenStruct).yay.bar