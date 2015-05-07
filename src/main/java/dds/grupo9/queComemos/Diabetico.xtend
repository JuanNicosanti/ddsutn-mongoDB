package dds.grupo9.queComemos

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors

class Diabetico implements CondPreexistente {
	@Accessors int cantidadAzucarPermitida

	new(){
		cantidadAzucarPermitida = 100
	}
	override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){/* Verifica si logra subsanar su condición, para los diabeticos se logra si tiene una rutina activa o no pesa mas de 70 kgs */
		rutina == "ACTIVA" || rutina == "INTENSIVO" || peso < 70
	}
      
    override recetaNoRecomendada(Receta receta){	
    	receta.tieneMasDeUnaCantidadDe(cantidadAzucarPermitida, new Ingrediente(Preferencia.AZUCAR, 0))        
    }

    override boolean verificaDatosSegunCondicion(Persona persona){ /* Verifica que usuarios diabéticos indiquen el sexo  y al menos una preferencia */
      	persona.indicaSexo && persona.tienePreferencias
    } 
    	
}