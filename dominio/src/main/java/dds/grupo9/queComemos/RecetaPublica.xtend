package dds.grupo9.queComemos

import dds.grupo9.queComemos.modificacionRecetas.Modificacion
import dds.grupo9.queComemos.excepciones.NoLoTieneException
import org.eclipse.xtend.lib.annotations.Accessors
import com.fasterxml.jackson.annotation.JsonIgnore

class RecetaPublica extends PrivacidadReceta {
	
	@JsonIgnore @Accessors Persona creador = new Persona
		
	override puedeVermeOModificarme(Persona persona){
		
		true
	}
	
	override cambiosDeReceta (Persona persona, Modificacion modificacion,Receta receta ){
	
	    var recetaCopia = receta.copiaReceta(persona)
	    persona.agregarReceta(recetaCopia)
	    modificacion.ejecutar(recetaCopia)
	}
	
	override getDueño() {
		creador.nombre = "D10S"
		creador
		//throw new NoLoTieneException("Una receta pública no tiene dueño")
	}
	
	override getNombreDueño() {
		"D10S (Receta Publica)"
	}
	
}