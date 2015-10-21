package dds.grupo9.queComemos.consultas

import java.util.Collection
import dds.grupo9.queComemos.Receta
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Entity
@Accessors
@Observable
class ConsultaPorDisgusto extends Consulta{
	
	
	override filtrar(Collection <Receta> recetas){
		recetas.filter[persona.noContieneIngredientesQueLeDisgusten(it)]
	}
	
	override toString(){
		return "por disgutos";
	}
}