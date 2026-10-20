use('tinder');

//para que la base de datos aparezca necesita al menos una coleccion
//Una colección en MongoDB es un grupo de documentos que se almacenan juntos en una base de datos,
//similar a una tabla en bases de datos relacionales pero con una estructura más flexible.

//db devuelve por debajo la base de datos que estab usando
db.explorar.insertOne(
    {
        "username": "Pepita",
        "age": 45,
        "description": "Soy Pepita, me gusta escalar, andar en bicicleta y hacer yoga, me gustan los gatos y no los perros, tengo dos hijos, busco algo serio",
        "hobbies": ["Fumar", "Ciclismo", "Danza", "Yoga"],
        "photos": ["https://static.wikia.nocookie.net/theamazingworldofgumball/images/4/4c/TheBoring53.png/revision/latest/scale-to-width-down/1200?cb=20250728132022"]
    }
);

use("tinder");
db.explorar.fin();

use("tinder");
db.explorar.finOne(
    { "username": "Pepita" }
);