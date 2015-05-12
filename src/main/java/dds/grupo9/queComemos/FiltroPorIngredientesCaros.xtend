package dds.grupo9.queComemos

import java.util.Collection

class FiltroPorIngredientesCaros extends Filtro {
	
		
	override filtrar(Collection <Receta> recetas){
		var Collection<Receta> lista = newHashSet()		
		lista.addAll(recetas.filter[!it.tieneIngredientesCaros()]) 
		lista
	}
	
}