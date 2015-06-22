package dds.grupo9.queComemos.filtros

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Receta

class FiltroPorCaloriasMaximas extends Filtro {
	
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
	
}