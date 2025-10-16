class Corsa {
  var color
  method capacidad() = 4
  method velocidad() = 150
  method peso() = 1300
  method color() = color
  method pintar(unColor) { color = unColor }
}

class Kwid {
  var tieneGasAdicional
  method capacidad() = if (tieneGasAdicional) 3 else 4
  method velocidad() = if (tieneGasAdicional) 120 else 110
  method peso() = if (tieneGasAdicional) 1350 else 1200
  method color() = "Azul"
  method adicionarGas() { tieneGasAdicional = true }
  method sacarGas() { tieneGasAdicional = false }
}

object trafic {
  var interior = comodo
  var motor = pulenta
  method capacidad() = interior.capacidad()
  method velocidad() = motor.velocidad()
  method peso() = 4000 + interior.peso() + motor.peso()
  method color() = "Blanco"
  method cambiarInterior(unInterior) { interior = unInterior }
  method cambiarMotor(unMotor) { motor = unMotor }
}

object comodo {
  method capacidad() = 5
  method peso() = 700
}

object popular {
  method capacidad() = 12
  method peso() = 1000
}

object pulenta {
  method peso() = 800
  method velocidad() = 130
}

object bataton {
  method peso() = 500
  method velocidad() = 80
}

class Especial {
  const property capacidad
  const property velocidad
  const property peso
  const property color  
}

class Dependencia {
  var empleados
  const rodados = new List()
  const pedidos = new List()
  method agregarAFlota(rodado) { rodados.add(rodado) }
  method quitarDeFlota(rodado) { rodados.remove(rodado) }
  method agregarPedido(pedido) { pedidos.add(pedido) }
  method quitarPedido(pedido) { pedidos.remove(pedido) }
  method pesoTotalFlota() = rodados.sum({r => r.peso()})
  method estaBienEquipada() = rodados.size() > 2 and rodados.all({r => r.velocidad() > 99})
  method rodadosDeColor(color) = rodados.filter({r => r.color() == color})
  method capacidadTotalEnColor(color) = self.rodadosDeColor(color).sum({r => r.capacidad()})
  method colorDelRodadoMasRapido() = (rodados.max({r => r.velocidad()})).color()
  method capacidadTotal() = rodados.sum({r => r.capacidad()})
  method capacidadFaltante() = (empleados - self.capacidadTotal()).max(0)
  method esGrande() = rodados.size() > 4 and empleados > 39
  method contratarEmpleados(cantidad) { empleados = cantidad }
  method totalDePasajerosDePedidos() = pedidos.sum({p => p.pasajeros()})
  method pedidosNoSatisfechos() = pedidos.filter { p => !rodados.any{r => p.puedeSatisfacerUnPedido(r)} }
  method todosLosPedidosTienenDeIncompatible(color) = pedidos.all({p => p.coloresIncompatibles().contains(color)})
  method relajarTodosLosPedidos() { pedidos.forEach({p => p.relajar()})}
}

class Pedido {
  var tiempo
  const property distancia
  const property pasajeros
  const property coloresIncompatibles = #{}
  method tiempo() = tiempo
  method velocidad() = distancia.div(tiempo)
  method puedeSatisfacerUnPedido(rodado) = (rodado.velocidad() + 10) > self.velocidad() and rodado.capacidad() >= pasajeros and !coloresIncompatibles.contains(rodado.color())
  method acelerar() { tiempo -= 1 }
  method relajar() { tiempo += 1 }
}