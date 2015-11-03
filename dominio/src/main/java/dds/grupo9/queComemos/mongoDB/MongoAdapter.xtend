package dds.grupo9.queComemos.mongoDB

import org.mongojack.MapReduce
import org.mongojack.DBQuery
import org.mongojack.Id
import java.util.List
import org.junit.Test
import org.apache.log4j.PropertyConfigurator
import org.junit.Assert
import dds.grupo9.queComemos.Persona

class MongoAdapter extends HomeUsuariosEjemplo{
	/*
	@Test
	def void findByName() {
		var personas = homeUsuario.getMongoCollection().find(DBQuery.is("nombre", "Juani"))
		Assert.assertEquals(personas.size(), 1)
		val persona = personas.get(0)
		println(personas)
		println(persona)
//		var persona = personas.get(0)
//		Assert.assertEquals("Masculino", persona.sexo)
	}
	*/
	@Test
	def void mapReduce() {
		val map = '''
			function() { 
				for (i in this.recetasFavoritas) {
					emit(this.nombre, this.recetasFavoritas[i]);
				}
			}
		'''

		val reduce = '''
			function(key, values) {
				var nombres;
				for(var i in values) {
					nombres.concat(values[i]);
				}
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
}

public class FavoritasPorPersona {
	@Id
	public String nombre;

	public List<String> value;
}