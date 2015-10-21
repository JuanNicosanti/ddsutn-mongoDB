package dds.grupo9.queComemos.consultas

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Receta
import javax.persistence.Entity
import org.uqbar.commons.utils.Observable

@Entity
@Accessors
@Observable
class ConsultaPorCaloriasMaximas extends Consulta {
	
	@Accessors int maxSobrepeso
	
	new (int max){
		maxSobrepeso = max
	}
		
	override filtrar (Collection <Receta> recetas){
		if(persona.tieneSobrepeso(maxSobrepeso)){
			recetas.filter[it.calorias < 500]
		}
		else recetas
	}
	
	override toString(){
		return "por calorias máximas";
	}
	
}