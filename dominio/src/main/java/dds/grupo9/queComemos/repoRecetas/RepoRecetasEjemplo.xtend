package dds.grupo9.queComemos.repoRecetas

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.Estacion
import queComemos.entrega3.dominio.Dificultad
import dds.grupo9.queComemos.Receta
import org.uqbar.commons.utils.Observable
import dds.grupo9.queComemos.RecetaSimple
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import dds.grupo9.queComemos.condicionPreexistente.Celiaco
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.Persona
import java.util.Collection

@Observable
class RepoRecetasEjemplo extends RepoRecetasPropio {
	
	@Accessors RecetaSimple receta1
	@Accessors RecetaSimple receta2
	@Accessors RecetaSimple receta3
	@Accessors RecetaSimple receta4
	@Accessors RecetaSimple receta5
	@Accessors RecetaSimple receta6
	@Accessors RecetaSimple receta7
	@Accessors RecetaSimple receta8
	@Accessors RecetaSimple receta9
	@Accessors RecetaSimple receta10
	@Accessors RecetaSimple receta11
	@Accessors RecetaSimple receta12
	
	new()
	{
      	receta1 = new RecetaSimple(this)
      	receta2 = new RecetaSimple(this)
      	receta3 = new RecetaSimple(this)
      	receta4 = new RecetaSimple(this)
      	receta5 = new RecetaSimple(this)
      	receta1.nombre = "Super sal"
      	receta1.agregarIngrediente(new Ingrediente("sal",10))
      	receta1.agregarCondimento("sal gruesa")
		receta1.calorias = 650
		receta1.agregarTemporada(Estacion.VERANO)
		receta1.dificultad = Dificultad.FACIL
		receta2.nombre = "Alto fish"
		receta2.agregarIngrediente(new Ingrediente("pescado",2))
		receta2.calorias = 420
      	receta2.agregarTemporada(Estacion.INVIERNO)
      	receta2.dificultad = Dificultad.DIFICIL
      	receta3.agregarIngrediente(new Ingrediente("lechuga",3))
		receta3.calorias = 300
		receta3.nombre = "Ensalada Cesar"
		receta3.agregarTemporada(Estacion.PRIMAVERA)
      	receta3.dificultad = Dificultad.MEDIANA
		receta4.agregarIngrediente(new Ingrediente("huevo",2))
		receta4.calorias = 550
		receta4.nombre = "Comidita"
		receta4.agregarTemporada(Estacion.OTOGNO)
      	receta4.dificultad = Dificultad.FACIL
		receta5.agregarIngrediente(new Ingrediente("lomo",1))
		receta5.calorias = 350
		receta5.nombre = "MacQueso"
		receta5.agregarTemporada(Estacion.INVIERNO)
      	receta5.dificultad = Dificultad.FACIL
      	
      	receta6 = new RecetaSimple(this)
      	receta7 = new RecetaSimple(this)
      	receta8 = new RecetaSimple(this)
      	receta9 = new RecetaSimple(this)
      	receta10 = new RecetaSimple(this)
      	receta11 = new RecetaSimple(this)
      	receta12= new RecetaSimple(this)
      	receta6.nombre = "Milanga"
      	receta6.agregarIngrediente(new Ingrediente("pan rallado",80))
      	receta6.agregarCondimento("limon")
		receta6.calorias = 500
		receta6.agregarTemporada(Estacion.PRIMAVERA)
		receta6.dificultad = Dificultad.FACIL
		receta7.nombre = "Chocotorta"
		receta7.agregarIngrediente(new Ingrediente("chocolinas",20))
		receta7.agregarIngrediente(new Ingrediente("dulce de leche",300))
		receta7.calorias = 700
      	receta7.agregarTemporada(Estacion.INVIERNO)
      	receta7.dificultad = Dificultad.DIFICIL
      	receta8.agregarIngrediente(new Ingrediente("carne",10))
      	receta8.agregarIngrediente(new Ingrediente("pan",20))
      	receta8.agregarCondimento("sal")
		receta8.calorias = 600
		receta8.nombre = "Asadito dominguero"
		receta8.agregarTemporada(Estacion.PRIMAVERA)
      	receta8.dificultad = Dificultad.MEDIANA
		receta9.agregarIngrediente(new Ingrediente("arroz",200))
		receta9.agregarIngrediente(new Ingrediente("carne",2))
		receta9.agregarIngrediente(new Ingrediente("verduras",10))
		receta9.calorias = 500
		receta9.nombre = "Chop Suey"
		receta9.agregarTemporada(Estacion.OTOGNO)
      	receta9.dificultad = Dificultad.MEDIANA
		receta10.agregarIngrediente(new Ingrediente("crema",30))
		receta10.agregarIngrediente(new Ingrediente("queso rallado",20))
		receta10.agregarIngrediente(new Ingrediente("fideos",200))
		receta10.calorias = 600
		receta10.nombre = "Fideos con crema"
		receta10.agregarTemporada(Estacion.INVIERNO)
      	receta10.dificultad = Dificultad.FACIL
      	receta11.agregarIngrediente(new Ingrediente("chori",1))
      	receta11.agregarIngrediente(new Ingrediente("veneno",30))
		receta11.calorias = 350
		receta11.nombre = "Chori de cancha"
		receta11.agregarTemporada(Estacion.INVIERNO)
		receta11.agregarTemporada(Estacion.OTOGNO)
		receta11.agregarTemporada(Estacion.PRIMAVERA)
		receta11.agregarTemporada(Estacion.VERANO)
		receta11.dificultad = Dificultad.FACIL
		receta11.explicacion="Tirar el chori a la parrilla, previamente contaminada de veneno para ratas. NUNCA dejar
                              que quede cocido si hay un cliente esperando a comprar"
      	receta12.agregarIngrediente(new Ingrediente("polvito loco",200))
		receta12.calorias = 200
		receta12.nombre = "Puré chef"
		receta12.agregarTemporada(Estacion.OTOGNO)
      	receta12.dificultad = Dificultad.FACIL
      	
      	this.agregarRecetaPublica(receta1)
      	this.agregarRecetaPublica(receta2)
      	this.agregarRecetaPublica(receta3)
      	this.agregarRecetaPublica(receta4)
      	this.agregarRecetaPublica(receta5)
      	receta6 = this.construirRecetaPublica()
      	this.agregarRecetaPublica(receta6)
      	this.agregarRecetaPublica(receta7)
      	this.agregarRecetaPublica(receta8)
      	this.agregarRecetaPublica(receta9)
      	this.agregarRecetaPublica(receta10)
      	this.agregarRecetaPublica(receta11)
      	this.agregarRecetaPublica(receta12)
   	}
	
	def construirRecetaPrivada(Persona p) {
		var r = new RecetaSimple(p)
		r.nombre = "Ravioles con crema"
		r.calorias = 550
		r.dificultad = Dificultad.FACIL
		r.agregarIngrediente(new Ingrediente("harina", 500))
		r.agregarIngrediente(new Ingrediente("huevos", 3))
		r.agregarIngrediente(new Ingrediente("aceite", 3))
		r.agregarIngrediente(new Ingrediente("agua", 200))
		r.agregarIngrediente(new Ingrediente("queso azul", 200))
		r.agregarIngrediente(new Ingrediente("espinaca", 1))
		r.agregarIngrediente(new Ingrediente("jamon", 100))
		r.agregarCondimento("sal")
		r.agregarCondimento("salsa de soja")
		r.agregarCondimento("nueces")
		r.agregarTemporada(Estacion.VERANO)
		r.agregarTemporada(Estacion.OTOGNO)
		r.explicacion = "Preparar la masa mezclando el harina, los huevos, el agua y el aceite. 
		Dejar reposar. Cortar en forma de tapas circulares. Preparar relleno. 
		Armar los ravioes. Hervir, colar y servir. Poner crema, nueces y salsa de soja a gusto!!"
		p.marcarRecetaComoFavorita(r)
		return r
	}
	
	def construirRecetaPublica() {
		var r = new RecetaSimple(this)
		r.nombre = "Ravioles con crema"
		r.calorias = 550
		r.dificultad = Dificultad.FACIL
		r.agregarIngrediente(new Ingrediente("harina", 500))
		r.agregarIngrediente(new Ingrediente("huevos", 3))
		r.agregarIngrediente(new Ingrediente("aceite", 3))
		r.agregarIngrediente(new Ingrediente("agua", 200))
		r.agregarIngrediente(new Ingrediente("queso azul", 200))
		r.agregarIngrediente(new Ingrediente("espinaca", 1))
		r.agregarIngrediente(new Ingrediente("jamon", 100))
		r.agregarCondimento("sal")
		r.agregarCondimento("salsa de soja")
		r.agregarCondimento("nueces")
		r.agregarTemporada(Estacion.VERANO)
		r.agregarTemporada(Estacion.OTOGNO)
		r.explicacion = "Preparar la masa mezclando el harina, los huevos, el agua y el aceite. 
		Dejar reposar. Cortar en forma de tapas circulares. Preparar relleno. 
		Armar los ravioes. Hervir, colar y servir. Poner crema, nueces y salsa de soja a gusto!!"
		return r
	}
	
	override buscarRecetaPorNombre(String nombre){
		var recetas = newHashSet
		recetas.add(receta1)
		recetas.add(receta2)
		recetas.add(receta3)
		recetas.add(receta4)
		recetas.add(receta5)
		recetas.add(receta6)
		recetas.add(receta7)
		recetas.add(receta8)
		recetas.add(receta9)
		recetas.add(receta10)
		recetas.add(receta11)
		recetas.add(receta12)
		recetas.findFirst[r|r.nombre==nombre]
	}
}