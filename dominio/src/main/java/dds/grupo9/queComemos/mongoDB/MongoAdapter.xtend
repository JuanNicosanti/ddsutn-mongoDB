package dds.grupo9.queComemos.mongoDB

import org.mongojack.MapReduce
import org.mongojack.DBQuery
import org.mongojack.Id
import java.util.List
import org.junit.Test
import org.apache.log4j.PropertyConfigurator
import org.junit.Assert
import dds.grupo9.queComemos.Persona
import org.mongojack.Aggregation
import org.mongojack.DBSort
import org.mongojack.Aggregation.Group

class MongoAdapter extends HomeUsuariosEjemplo{
	
//	@Test
//	def void findByName() {
//		var personas = homeUsuario.getMongoCollection().find(DBQuery.is("nombre", "Juani"))
//		Assert.assertEquals(personas.size(), 1)
//		
//		println(personas)
//		val persona = personas.get(0)
//		println(persona)
//		var persona = personas.get(0)
//		Assert.assertEquals("Masculino", persona.sexo)
//	}
	

//	@Test
//	def void findByZone() {
//		val query = DBQuery.in("codigo", "1111111", "2222222", "5555555")
//		val productos = homeProducto.getMongoCollection().find(query)
//		Assert.assertEquals(productos.size(), 2);
//	}
	
@Test
	def void mapReduce() {
		val map = '''
			function() { 
				for (i in this.recetasFavoritas) {
					emit(this.nombre, this.recetasFavoritas[i].nombre);
				}
			}
		'''

		val reduce = '''
			function(key, values) {
				var nombres = [];
				nombres += '['
				for(var i in values) {
					nombres += values[i];
					nombres += ', '
				}
				nombres += ']'
				return nombres;
			}
		'''

		val command = MapReduce.build(map, reduce, 
			MapReduce.OutputType.REPLACE, "recetasFavoritas", 
			FavoritasPorPersona, String)

		command.query = DBQuery.in("nombre", "Santi", "Juani", "Pedrito")
		
		//PropertyConfigurator.configure(this.getClass().getResource("log4j.properties.mongo"))

		val output = homeUsuario.mongoCollection.mapReduce(command)

		output.results().forEach [
			println('''La persona «nombre» tiene las siguientes recetas favoritas: «value»''')
		]
	}
	
	@Test
	def void aggregate() {
	val pipeline = Aggregation
			.match(DBQuery.in("nombre", "Santi", "Juani", "Peter"))
			.unwind("recetasFavoritas")
			.projectFields("nombre", "recetasFavoritas.nombre")
			.group("nombre").set("value", Group.list("recetasFavoritas.nombre"))
			.sort(DBSort.asc("_id"))
				
		val output = homeUsuario.mongoCollection.aggregate(pipeline, FavoritasPorPersona)
		
		output.results().forEach[
			println('''El usuario «nombre» tiene las siguientes recetas favoritas: «value»''')
		]
	}
	
	@Test
	def void aggregate2() {
	val pipeline = Aggregation
			.match(DBQuery.in("nombre", "Santi", "Juani", "Peter"))
			.unwind("recetasFavoritas")
			.projectFields("nombre", "recetasFavoritas.nombre")
			.group("nombre").set("value", Group.list("recetasFavoritas.nombre"))
			.sort(DBSort.asc("_id"))
				
		val output = homeUsuario.mongoCollection.aggregate(pipeline, FavoritasPorPersona)
		
		output.results().forEach[
			println('''El usuario «nombre» tiene las siguientes recetas favoritas: «value»''')
		]
		
		println(persona3.recetasFavoritas.size)
		persona3.marcarRecetaComoFavorita(persona3.repoRecetas.getRecetas.findFirst[it.nombre=="Asadito dominguero"])
		p3.actualizar(persona3)
		homeUsuario.insert(p3)
		println(persona3.recetasFavoritas.size)
		
		
		
		val pipeline2 = Aggregation
			.match(DBQuery.in("nombre", "Santi", "Juani", "Peter"))
			.unwind("recetasFavoritas")
			.projectFields("nombre", "recetasFavoritas.nombre")
			.group("nombre").set("value", Group.list("recetasFavoritas.nombre"))
			.sort(DBSort.asc("_id"))
				
		val output2 = homeUsuario.mongoCollection.aggregate(pipeline2, FavoritasPorPersona)
		
		output2.results().forEach[
			println('''El usuario «nombre» tiene las siguientes recetas favoritas: «value»''')
		]
	}
	
}

public class FavoritasPorPersona {
	@Id
	public String nombre;

	public List<String> value;
}