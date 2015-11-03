package dds.grupo9.queComemos.consultas

import java.util.Collection
import dds.grupo9.queComemos.Receta
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable


@Accessors
@Observable
class ConsultaPorCondicionesPreexistentes extends Consulta {
	
	
	override filtrar(Collection<Receta> recetas){
		recetas.filter[!persona.recetaNoRecomendada(it)]
	}
	
	override toString(){
		return "por condiciones preexistentes";
	}
	
}