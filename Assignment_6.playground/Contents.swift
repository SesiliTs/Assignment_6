//1-ი თასქი ბიბლიოთეკის სიმულაცია. (თავისი ქვეთასქებით).

//1. შევქმნათ Class Book.

//Properties: bookID(უნიკალური იდენტიფიკატორი Int), String title, String author, Bool isBorrowed.
//Designated Init.

class Book {
    let bookID: Int
    let title: String
    let author: String
    var isBorrowed: Bool
    
    init(bookID: Int, title: String, author: String, isBorrowed: Bool) {
        self.bookID = bookID
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }
    
    //Method რომელიც ნიშნავს წიგნს როგორც borrowed-ს.
    
    func bookIsBorrowed() {
        isBorrowed = true
    }
    
    //Method რომელიც ნიშნავს წიგნს როგორც დაბრუნებულს.
    
    func bookIsReturned() {
        isBorrowed = false
    }
}

//2. შევქმნათ Class Owner

//Properties: ownerId(უნიკალური იდენტიფიკატორი Int), String name, Books Array სახელით borrowedBooks.
//Designated Init.

class Owner {
    let ownerID: Int
    let name: String
    var borrowedBooks: [Book]?
    
    init(ownerID: Int, name: String, borrowedBooks: [Book]?) {
        self.ownerID = ownerID
        self.name = name
        self.borrowedBooks = borrowedBooks
    }
    
    //Method რომელიც აძლევს უფლებას რომ აიღოს წიგნი ბიბლიოთეკიდან.
    
    func takeBook(book: Book) {
        if book.isBorrowed == false {
            borrowedBooks?.append(book)
            book.isBorrowed = true
        } else {
            print("Book is not available")
        }
    }
    
    //Method რომელიც აძლევს უფლებას რომ დააბრუნოს წაღებული წიგნი.
    
    func returnBook(book: Book) {
        //ეს სოლუშენიც ერთადერთი იყო ალბათ რომელიც ნაწილობრივ მაინც გავიგე :დ მარა ბოლომდე clear არ არი ინდექსს როგორ ადგენს
        if var borrowedBooks = borrowedBooks, let index = borrowedBooks.firstIndex(where: { $0 === book }) {
            borrowedBooks.remove(at: index)
            self.borrowedBooks = borrowedBooks
        }
        book.isBorrowed = false
    }
}


//3. შევქმნათ Class Library
//Properties: Books Array, Owners Array.
//Designated Init.

class Library {
    var books: [Book]
    var owners: [Owner]
    
    init(books: [Book], owners: [Owner]) {
        self.books = books
        self.owners = owners
    }
    //Method წიგნის დამატება, რათა ჩვენი ბიბლიოთეკა შევავსოთ წიგნებით.
    func addBook(book: Book) {
        books.append(book)
    }
    //Method რომელიც ბიბლიოთეკაში ამატებს Owner-ს.
    func addOwner(owner: Owner) {
        owners.append(owner)
    }
    //Method რომელიც პოულობს და აბრუნებს ყველა ხელმისაწვდომ წიგნს.
    func availableBooks() -> [Book] {
        var availableArray: [Book] = []
        for book in books {
            if book.isBorrowed == false {
                availableArray.append(book)
            }
        }
        return availableArray
    }
    //Method რომელიც პოულობს და აბრუნებს ყველა წაღებულ წიგნს.
    func takenBooks() -> [Book] {
        var takenArray: [Book] = []
        for book in books {
            if book.isBorrowed == true {
                takenArray.append(book)
            }
        }
        return takenArray
    }
    //Method რომელიც ეძებს Owner-ს თავისი აიდით თუ ეგეთი არსებობს.
    func findOwner(id: Int) -> Owner?{
        let owner = owners.filter { $0.ownerID == id }
        return owner.first
    }
    //Method რომელიც ეძებს წაღებულ წიგნებს კონკრეტული Owner-ის მიერ.
    func findTakenBooks(ownerID: Int) -> [Book]? {
        if let owner = owners.first(where: { $0.ownerID == ownerID }) {
            return owner.borrowedBooks
        }
        return nil
    }
    //Method რომელიც აძლევს უფლებას Owner-ს წააღებინოს წიგნი თუ ის თავისუფალია.
    func giveOwnerBooks(book: Book, ownerID: Int) {
        if book.isBorrowed == false {
            if let owner = owners.first(where: { $0.ownerID == ownerID }) {
                owner.borrowedBooks?.append(book)
                book.isBorrowed = true
            } else {
                print("Wrong owner ID")
            }
        } else { print("Book is not available") }
    }
}


//4. გავაკეთოთ ბიბლიოთეკის სიმულაცია.

//შევქმნათ რამოდენიმე წიგნი და რამოდენიმე Owner-ი, შევქმნათ ბიბლიოთეკა.

let library = Library(books: [], owners: [])
//ეს კარგად არ მესმის პირდაპირ კლასის ფუნქციის გამოძახება რატო არ შემიძლია და ინსტანსის შექმნა რატო მჭირდება

let jackLondon = Book(bookID: 01, title: "Martin Eden", author: "Jack London", isBorrowed: false)
let bulgakov = Book(bookID: 02, title: "The Master and Margarita", author: "Mikhail Bulgakov", isBorrowed: false)
let bloch = Book(bookID: 03, title: "Psycho", author: "Robert Block", isBorrowed: false)
let burgess = Book(bookID: 04, title: "A Clockwork Orange", author: "Anthony Burgess", isBorrowed: false)
let salinger = Book(bookID: 05, title: "The Catcher in the Rye", author: "J.D. Salinger", isBorrowed: false)


let owner01 = Owner(ownerID: 01, name: "Powder", borrowedBooks: [])
let owner02 = Owner(ownerID: 02, name: "Violet", borrowedBooks: [])

//დავამატოთ წიგნები და Owner-ები ბიბლიოთეკაში
library.addBook(book: jackLondon)
library.addBook(book: bulgakov)
library.addBook(book: bloch)
library.addBook(book: burgess)
library.addBook(book: salinger)

library.addOwner(owner: owner01)
library.addOwner(owner: owner02)

//წავაღებინოთ Owner-ებს წიგნები და დავაბრუნებინოთ რაღაც ნაწილი.
library.giveOwnerBooks(book: jackLondon, ownerID: 01)
owner01.takeBook(book: salinger)
owner02.takeBook(book: bulgakov)
owner02.takeBook(book: burgess)
owner01.returnBook(book: jackLondon)

//დავბეჭდოთ ინფორმაცია ბიბლიოთეკიდან წაღებულ წიგნებზე, ხელმისაწვდომ წიგნებზე და გამოვიტანოთ წაღებული წიგნები კონკრეტულად ერთი Owner-ის მიერ.
for book in library.availableBooks() {
    print("available:", book.title, book.author)
}
for book in library.takenBooks() {
    print("taken:", book.title, book.author)
}
library.findTakenBooks(ownerID: 02)


//====================================================================


//2 თასქი ავაწყოთ პატარა E-commerce სისტემა. (თავისი ქვეთასქებით).

//1. შევქმნათ Class Product,
//შევქმნათ შემდეგი properties productID (უნიკალური იდენტიფიკატორი Int), String name, Double price.
//შევქმნათ Designated Init.

class Product {
    let productID: Int
    let name: String
    let price: Double
    
    init(productID: Int, name: String, price: Double) {
        self.productID = productID
        self.name = name
        self.price = price
    }
}

//2. შევქმნათ Class Cart
//Properties: cartID(უნიკალური იდენტიფიკატორი Int), Product-ების Array სახელად items.
//შევქმნათ Designated Init.

class Cart {
    let cartID: Int
    var items: [Product]
    
    init(cartID: Int, items: [Product]) {
        self.cartID = cartID
        self.items = items
    }
    
    //Method იმისათვის რომ ჩვენს კალათაში დავამატოთ პროდუქტი.
    func addProduct(product: Product) {
        items.append(product)
    }
    //Method იმისათვის რომ ჩვენი კალათიდან წავშალოთ პროდუქტი მისი აიდით.
    func removeProduct(productID: Int) {
        items = items.filter { $0.productID != productID }
    }
    //Method რომელიც დაგვითვლის ფასს ყველა იმ არსებული პროდუქტის რომელიც ჩვენს კალათაშია.
    func finalPrice() -> Double {
        var price: Double = 0
        for item in items {
            price += item.price
        }
        return price
    }
}


//3. შევქმნათ Class User
//Properties: userID(უნიკალური იდენტიფიკატორი Int), String username, Cart cart.
//Designated Init.

class User {
    let userID: Int
    let username: String
    let cart: Cart
    
    init(userID: Int, username: String, cart: Cart) {
        self.userID = userID
        self.username = username
        self.cart = cart
    }
    //Method რომელიც კალათაში ამატებს პროდუქტს.
    func addToCart(product: Product) {
        cart.items.append(product)
    }
    //Method რომელიც კალათიდან უშლის პროდუქტს.
    func removeProduct(product: Product) {
        cart.items = cart.items.filter { $0 !== product }
    }
    //Method რომელიც checkout (გადახდის)  იმიტაციას გააკეთებს დაგვითვლის თანხას და გაასუფთავებს ჩვენს shopping cart-ს.
    func checkout() {
        print("Price of your order is:", cart.finalPrice(), "please proceed to checkout")
        cart.items.removeAll()
        print("Your cart is empty")
    }
}

//4. გავაკეთოთ იმიტაცია და ვამუშაოთ ჩვენი ობიექტები ერთად.
//შევქმნათ რამოდენიმე პროდუქტი.

let scooter = Product(productID: 001, name: "Electric Scooter", price: 1300)
let speaker = Product(productID: 002, name: "Wireless Speaker", price: 349.99)
let compressor = Product(productID: 003, name: "Car Air Compressor", price: 120)
let jigsaw = Product(productID: 004, name: "Jigsaw", price: 250)
let vacuum = Product(productID: 005, name: "Robot Vacuum Cleaner", price: 1399.99)

//შევქმნათ 2 user-ი, თავისი კალათებით,
let cart1 = Cart(cartID: 01, items: [])
let cart2 = Cart(cartID: 02, items: [])

let user1 = User(userID: 01, username: "Aloy", cart: cart1)
let user2 = User(userID: 02, username: "Varl", cart: cart2)

//დავუმატოთ ამ იუზერებს კალათებში სხვადასხვა პროდუქტები,
user1.addToCart(product: jigsaw)
user1.cart.addProduct(product: speaker)
user1.addToCart(product: compressor)
user2.cart.addProduct(product: jigsaw)
user2.addToCart(product: vacuum)

user1.removeProduct(product: jigsaw)
user2.cart.removeProduct(productID: 005)

//დავბეჭდოთ price ყველა item-ის ამ იუზერების კალათიდან.
for item in user1.cart.items {
    print(item.name, item.price)
}
//ყველას საერთო ფასი გინდოდათ თუ სათითაოდ ვერ მივხვდი და ორივე ვარიანტს დავტოვებ
print(user2.cart.finalPrice())

//და ბოლოს გავაკეთოთ სიმულაცია ჩექაუთის, დავაბეჭდინოთ იუზერების გადასხდელი თანხა და გავუსუფთაოთ კალათები.

user1.checkout()
user2.checkout()
