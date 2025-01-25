{
  "$GMObject":"",
  "%Name":"obj_liquidificador",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":13,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":8,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_liquidificador",
  "overriddenProperties":[],
  "parent":{
    "name":"Liquidos",
    "path":"folders/Objects/Jogo/Cozinha/Liquidos.yy",
  },
  "parentObjectId":null,
  "persistent":false,
  "physicsAngularDamping":0.1,
  "physicsDensity":0.5,
  "physicsFriction":0.2,
  "physicsGroup":1,
  "physicsKinematic":false,
  "physicsLinearDamping":0.1,
  "physicsObject":false,
  "physicsRestitution":0.1,
  "physicsSensor":false,
  "physicsShape":1,
  "physicsShapePoints":[],
  "physicsStartAwake":true,
  "properties":[
    {"$GMObjectProperty":"v1","%Name":"tempo_produzir","filters":[],"listItems":[],"multiselect":false,"name":"tempo_produzir","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"5","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"copo_alvo","filters":[
        "GMObject",
      ],"listItems":[],"multiselect":false,"name":"copo_alvo","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resource":{"name":"obj_liquido_suco","path":"objects/obj_liquido_suco/obj_liquido_suco.yy",},"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"obj_liquido_suco","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"sfx_ligando","filters":[
        "GMSound",
      ],"listItems":[],"multiselect":false,"name":"sfx_ligando","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
    {"$GMObjectProperty":"v1","%Name":"sfx_desligando","filters":[
        "GMPath",
      ],"listItems":[],"multiselect":false,"name":"sfx_desligando","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"","varType":5,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":{
    "name":"spr_cafeteira",
    "path":"sprites/spr_cafeteira/spr_cafeteira.yy",
  },
  "spriteMaskId":null,
  "visible":true,
}