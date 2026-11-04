use("directorio_talento");

db.perfiles.find();

skills:CSS
"skills" : "CSS"
{skills: {$in : "CSS"}}

///

skills[1]
//Asi es como se busca un elemento de una lista

estudios[0].titulo
//Busqueda de elemento que esta en una coleccion
estudios[1].institucion
//Otro ejemplo

//Si quiero filtrar
use("directorio_talento");

db.perfiles.countDocuments(
  {
    seccion : "004D"
  }
);

use("directori_talento")
db.perfiles.distinct("seccion");
//1. Bloquear duplicados:
//se dbe crear un indice unico de la coleccion

use("directorio_talento");
db.instagram.insertOne({
    account : "pepito"
});

use("directorio_talento");
db.instagram.find();

use("directorio_talento");
db.instagram.createIndex({"account":1},{
unique:true});

//Tarea: ver esquemas, ptt documento word de todos los comandos que
//salen en la presentacion, profundizar, investigar que hace cada cosa
//hasta el domingo 8 a las 23:59pm
