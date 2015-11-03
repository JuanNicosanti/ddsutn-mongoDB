package dds.grupo9.queComemos

import dds.grupo9.queComemos.modificacionRecetas.Modificacion
import com.fasterxml.jackson.annotation.JsonIgnore

class RecetaPrivada extends PrivacidadReceta{
	
	@JsonIgnore static Persona creador /* Creador de la receta */
	
	new(Persona persona){
		creador = persona
	}
	
	override puedeVermeOModificarme(Persona persona){
		persona.comparteGrupoCon(creador) || persona == creador
	}
	
	override cambiosDeReceta(Persona persona, Modificacion modificacion, Receta receta){
		modificacion.ejecutar(receta)
	}
	
	override getDueño() {
		creador
	}
	
	override getNombreDueño() {
		this.getDueño.nombre
	}
	
}