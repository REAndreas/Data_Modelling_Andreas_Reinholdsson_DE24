## 2. Library Bookly

A)
    Member and Book

B) 
    one to many

c)

<img src = "../../Assets/Bookly.png">

## 3. Conceptual ERD to words

A)
    Customer kan hyra flera bilar
    Rent kan kopplas till en kund
    En bil kan kopplas till en hyra
    En eller flera hyror kan kopplas till flera bilar

B)
    Customer makes a rental
    Rental contains Car

c)
    One to many 
    Many to one

## 4. Online store

A)
    Entitys = Customer, Order, Product

B)

<img src = "../../Assets/4.Online_store.png">

## 5. University management system

A)
    Student, Course, Professor

B)
    Student = Student_id, name
    Student_courses = student_id, Course_id
    Course = Course_id, name, professor_id
    Professor = professor_id, name

C)
<img src = "../../Assets/5.University.png">

D)
    If a course has zero students it's cancelled and does not start

## 6. Onshop

A)

B)
<img src = "../../Assets/6.Onshop.png">

## 7. Theory question

A)
    För att ge en enkel överblick hur man vill lägga upp databasens struktur

B)
    It's not a good idea, because then you have to change the data every year, better to stor date of birth

C)
    Structural data = organised in defined schemas
    Semi structural data = partly organised data lite json data that doesnt fit in a table
    unstructured data = lacks a predefined structure, files like pictures, sound and video

D)
    Structural data = business data like excel sheets or databases
    Semi structural data = API:es
    unstructured data = spotify, youtube and instagram

E)
    Describes the connection between entitys in a databas
    one to many, many to many, many to one, one to one

F)
    figure out business rules
    set up entitys and relationships
    create a Conceptual model
    create a logical model
    create a physical model

G)
    RDBMS fits better for structured data banking, healthcare systems
    NOSQL better for semi structured data or unstructured like IOT or social media