package dds.grupo9.queComemos.consultas

import java.util.Collection
import dds.grupo9.queComemos.Receta
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Entity
@Accessors
@Observable
class ConsultaPorIngredientesCaros extends Consulta {
	
		
	override filtrar(Collection <Receta> recetas){
		recetas.filter[!it.tieneIngredientesCaros()]
	}
	
	override toString(){
		return "por ingredientes caros";
	}
	
}