package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import java.util.ArrayList
import java.util.Collections
import dds.grupo9.queComemos.repoRecetas.RepoRecetas
import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors

@Observable
class RecetasMasConsultadas implements Monitor {
	
	@Accessors var ArrayList<EstadisticaReceta> listaEstadisticas = new ArrayList<EstadisticaReceta>()
	@Accessors var Collection<Receta> recetasOrdenadas = newHashSet()
	
	
	override void update(Persona persona, Collection<Receta> recetas){
		verificarExistencia(listaEstadisticas, recetas)
		aumentarConsultasDeRecetas(listaEstadisticas, recetas)	
	}
	
	def verificarExistencia(ArrayList<EstadisticaReceta> lista, Collection<Receta> recetas){
		for (receta:recetas){
			if (!(lista.exists[e | e.nombre == receta.nombre])){
				val recetaNueva = new EstadisticaReceta(receta.nombre)
				lista.add(recetaNueva)
			} 
		}
	}
	
	def aumentarConsultasDeRecetas(ArrayList<EstadisticaReceta> lista, Collection<Receta> recetas){
		for(receta:recetas){
			lista.filter[e | e.nombre == receta.nombre].forEach[e | e.incrementarContador]
		}
	}
	
	def recetasMasConsultadas(int cant){
		mostrarRecetasMasConsultadas(listaEstadisticas, cant)
	}
	
	def mostrarRecetasMasConsultadas(ArrayList<EstadisticaReceta> lista, int cant){
		var Collection<String> recetasConsultadas = newHashSet() 
		Collections.sort(lista, new OrdenarEstadisticasPorConsultas())
		recetasConsultadas.addAll(lista.map[it.nombre].take(cant))
		return recetasConsultadas
	}
	
	def recetasMasConsultadasRepo(RepoRecetas repositorio, int cant) {
		var Collection<Receta> recetasFinal = newHashSet()
		Collections.sort(listaEstadisticas, new OrdenarEstadisticasPorConsultas())
		listaEstadisticas.forEach[recetasOrdenadas.add(repositorio.buscarRecetaPorNombre(it.nombre))]
		recetasFinal.addAll(recetasOrdenadas.take(cant))
		return recetasFinal
	}
	
	def obtenerConsultas(){
		var Iterable<Integer> listaConsultas =newHashSet()
		listaConsultas=listaEstadisticas.map[l|l.consultas].take(10)
		
	}
}