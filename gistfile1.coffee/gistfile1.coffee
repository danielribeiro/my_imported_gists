Function::property = (prop, desc) ->
  Object.defineProperty @prototype, prop, desc

class Person
  constructor: (@firstName, @lastName) ->
  @property 'fullName',
    get: -> "#{@firstName} #{@lastName}"
    set: (name) -> [@firstName, @lastName] = name.split ' '

p = new Person 'Leroy', 'Jenkins'
console.log p.fullName # Leroy Jenkins
p.fullName = 'Leroy Monkey'
console.log p.lastName # Monkey
console.log p.fullName # Leroy Monkey
p.lastName = 'Jenkins'
console.log p.fullName