{
  "$GMObject":"",
  "%Name":"obj_controlador_fase",
  "eventList":[
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
    {"$GMEvent":"v1","%Name":"","collisionObjectId":null,"eventNum":0,"eventType":12,"isDnD":false,"name":"","resourceType":"GMEvent","resourceVersion":"2.0",},
  ],
  "managed":true,
  "name":"obj_controlador_fase",
  "overriddenProperties":[],
  "parent":{
    "name":"Jogo",
    "path":"folders/Objects/Jogo.yy",
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
    {"$GMObjectProperty":"v1","%Name":"tempo_fase","filters":[],"listItems":[],"multiselect":false,"name":"tempo_fase","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"40","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"delay_inicial","filters":[],"listItems":[],"multiselect":false,"name":"delay_inicial","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"1","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"delay_entre_clientes","filters":[],"listItems":[],"multiselect":false,"name":"delay_entre_clientes","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"5","varType":0,},
    {"$GMObjectProperty":"v1","%Name":"clientes_possiveis","filters":[],"listItems":[],"multiselect":false,"name":"clientes_possiveis","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[obj_cliente, obj_cliente_2, obj_cliente_3]","varType":4,},
    {"$GMObjectProperty":"v1","%Name":"receitas_possiveis","filters":[],"listItems":[],"multiselect":false,"name":"receitas_possiveis","rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"resourceType":"GMObjectProperty","resourceVersion":"2.0","value":"[obj_receita_tapioca_queijo, obj_receita_tapioca_simples, [obj_receita_tapioca_queijo, obj_liquido_cafe]]","varType":4,},
  ],
  "resourceType":"GMObject",
  "resourceVersion":"2.0",
  "solid":false,
  "spriteId":null,
  "spriteMaskId":null,
  "visible":false,
}