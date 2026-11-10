//Siempre se debe empezar con use

//Se veran comparadores y operadores logicos

use('directorio_talento');

db.empresas.insertMany(
    [
        {
            nombre: 'Polideportivo',
            rubro: 'Deportes',
            empleados: 54,
            ciudad: 'Puerto Montt',
            creado_por: 'Renata Orellana'
        },
        {
            nombre: 'Librería Tarot',
            rubro: 'Barajas',
            empleados: 6,
            ciudad: 'Puerto Montt',
            creado_por: 'Renata Orellana'
        }
    ]
);

//JSON - JavaScript

use('directorio_talento');
db.ofertas.insertMany(
    [
        {
            cargo: 'Científico de datos',
            seniority: 'Semi-senior',
            empresa:'Decathlon',
            ciudad: 'Puerto Montt',
            habilidades: ['R', 'Python'],
            activa:true,
            creado_por: 'Renata Orellana'
        }
    ]
);

//Operador igual a
use('directorio_talento');

//Operador $GT

use('directorio_talento');
db.ofertas.find(
    {
        sueldo : ($gte : 20000000)
    }
);

//menor a
use('directorio_talento')
db.ofertas.find(
    {
        sueldo : ($lte : 50000000)
    }
);

//Not in para cadenas de texto
//Igual esto no es muy buena practica no se optimiza la
//normalizacion de caracteres en upper o lower
use('directorio_talento');
db.ofertas.find(
    {
        modalidad : {$nin : ['Presencial', 'presencial']}
    }
)
