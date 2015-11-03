package dds.grupo9.queComemos.mongoDB

import org.mongojack.MapReduce
import org.mongojack.DBQuery
import org.mongojack.Id
import java.util.List
import org.junit.Test

class MongoAdapter extends HomeUsuariosEjemplo{
	
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
			}
		'''

		val command = MapReduce.build(map, reduce, 
			MapReduce.OutputType.REPLACE, "recetasFavoritas", 
			FavoritasPorPersona, String)

		command.query = DBQuery.in("nombre", "Santi", "Juani", "Pedrito")

		val output = homeUsuario.mongoCollection.mapReduce(command)

		output.results().forEach [
			// Assert.assertEquals(500, value, 0)
			println('''La persona «nombre» tiene en las siguientes recetas favoritas: «recetasFavoritas»''')
		]
	}
}

public class FavoritasPorPersona {
	@Id
	public String nombre;

	public List<String> recetasFavoritas;
}