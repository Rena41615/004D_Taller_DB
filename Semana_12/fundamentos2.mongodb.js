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
