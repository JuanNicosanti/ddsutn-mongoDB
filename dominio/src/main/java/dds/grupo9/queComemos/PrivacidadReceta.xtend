package dds.grupo9.queComemos

import dds.grupo9.queComemos.modificacionRecetas.Modificacion
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Inheritance
import javax.persistence.InheritanceType

@Entity
@Accessors
@Observable
@Inheritance(strategy=InheritanceType.JOINED)
abstract class PrivacidadReceta {
	@Id
	@GeneratedValue
	private Long id
	def boolean puedeVermeOModificarme(Persona persona)
	
	def void cambiosDeReceta(Persona persona, Modificacion modificacion,Receta receta)
	
 	def Persona getDueño()
 	
 	def String getNombreDueño()
	
	
}