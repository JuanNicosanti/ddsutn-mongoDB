package dds.grupo9.queComemos.condicionPreexistente

import java.util.Collection
import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Persona
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import org.uqbar.commons.utils.Observable
import javax.persistence.ManyToMany
import javax.persistence.Column
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Observable
@Accessors
class Hipertenso extends CondPreexistente {

	@ManyToMany
	var Collection<Ingrediente> prescripcionesMedicas = newHashSet()	
	var Collection<String> prescripcionesMedicasCondimentos = newHashSet()
	
	new(){
    	prescripcionesMedicas.add(new Ingrediente("sal",0))
    	prescripcionesMedicasCondimentos.add("sal")
    	prescripcionesMedicas.add(new Ingrediente("caldo",0))
	}
	@Column
	@Accessors String nombre = "Hipertenso"
	
	override toString(){
		"Hipertenso"
	}
	
	def getPrescripcionesMedicas(){
		this.prescripcionesMedicas
	}
	
	override boolean subsanaCondicion(Collection<String> gustos, String rutina, float peso){
		rutina == "INTENSIVO"
	} /*Verifica si logra subsanar su condición, para los hipertensos esto se logra si tiene una rutina activa intensiva con ejercicio adicional */

    override boolean recetaNoRecomendada(Receta receta){
    	prescripcionesMedicas.exists[ing | receta.tieneIngrediente(ing.nombre)] ||
    	prescripcionesMedicasCondimentos.exists[cond | receta.tieneCondimento(cond)]
    }
       
    override boolean verificaDatosSegunCondicion(Persona persona){/* Verifica que usuarios hipertensos indiquen al menos una preferencia */
    	persona.tienePreferencias
    }
    
    override boolean esVeganismo(){false}   
}