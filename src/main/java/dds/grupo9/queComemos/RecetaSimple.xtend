package dds.grupo9.queComemos


class RecetaSimple extends Receta {
	
	new(Persona persona){
		super(persona)
	}
	
	
	
	new(RepoRecetas repositorio) {
		super(repositorio)
	}
	
	
	override agregarSubreceta(Receta c){
		throw new NoEsValidoException("Las recetas simples no pueden tener subrecetas")
   	}
   	
   	override RecetaSimple copiaReceta(Persona persona){
		var recetaCopia = new RecetaSimple(persona)
		recetaCopia.agregarTodosLosIngredientes(ingredientes)
		super.copiarAtributosComunes(recetaCopia, persona)
		return recetaCopia
	}
}

