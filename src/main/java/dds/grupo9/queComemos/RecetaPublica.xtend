package dds.grupo9.queComemos

class RecetaPublica implements PrivacidadReceta {
	
	override puedeVermeOModificarme(Persona persona){
		
		true
	}
	
	override cambiosDeReceta (Persona persona, Modificacion modificacion,Receta receta ){
	
	    var recetaCopia = receta.copiaReceta(persona)
	    persona.agregarReceta(recetaCopia)
  	    modificacion.ejecutar(recetaCopia)
	}
}