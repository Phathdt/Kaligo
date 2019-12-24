abcd = Hotel.create(name: "abcd", location: "Room")
defg = Hotel.create(name: "defg", location: "Room")
mnop = Hotel.create(name: "mnop", location: "Tokyo")

supplier1 = Supplier.create(name: "supplier1", url: "https://api.myjson.com/bins/2tlb8")
supplier2 = Supplier.create(name: "supplier2", url: "https://api.myjson.com/bins/42lok")
supplier3 = Supplier.create(name: "supplier3", url: "https://api.myjson.com/bins/15ktg")

Offer.create(hotel: abcd, supplier: supplier1)
Offer.create(hotel: abcd, supplier: supplier2)
Offer.create(hotel: abcd, supplier: supplier3)
Offer.create(hotel: defg, supplier: supplier1)
Offer.create(hotel: defg, supplier: supplier3)
Offer.create(hotel: mnop, supplier: supplier1)
Offer.create(hotel: mnop, supplier: supplier2)
Offer.create(hotel: mnop, supplier: supplier3)
