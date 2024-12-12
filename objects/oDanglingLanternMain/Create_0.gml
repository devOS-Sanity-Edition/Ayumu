lightsVerletSystem = new verletSystem(0.999, 0.5)

chain1 = verletGroupCreateRopeTextured(lightsVerletSystem, x, y, sLanternChain, 12, 10, 100)
var lantern = instance_create_layer(x, y, "Light", oDanglingLanternVisual)
//lantern.sprite_index = sDanglingLantern
chain1.vertexAttachObject(last, lantern, vertexAttachmentType.both)