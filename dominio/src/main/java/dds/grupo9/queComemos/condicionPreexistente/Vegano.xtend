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

@Accessors
@Entity
@Observable
class Vegano extends CondPreexistente {
	
	@ManyToMany
	var Collection<Ingrediente> ingredientesCarnicos = newHashSet()
	
	new(){
		ingredientesCarnicos.add(new Ingrediente("chori"))
		ingredientesCarnicos.add(new Ingrediente("pollo"))
		ingredientesCarnicos.add(new Ingrediente("chivito"))
		ingredientesCarnicos.add(new Ingrediente("carne"))
		ingredientesCarnicos.add(new Ingrediente("lomo"))
		ingredientesCarnicos.add(new Ingrediente("pescado"))
		ingredientesCarnicos.add(new Ingrediente("marisco"))
		ingredientesCarnicos.add(new Ingrediente("mondongo"))
		ingredientesCarnicos.add(new Ingrediente("lechon"))
		ingredientesCarnicos.add(new Ingrediente("salmon"))
		ingredientesCarnicos.add(new Ingrediente("berberechos"))	
		ingredientesCarnicos.add(new Ingrediente("mejillones"))
		ingredientesCarnicos.add(new Ingrediente("langostinos"))
		ingredientesCarnicos.add(new Ingrediente("bife angosto"))
		ingredientesCarnicos.add(new Ingrediente("jamon"))
	}
	@Column
	@Accessors String nombre = "Vegano"
	
	override toString(){
		"Vegano"
	}
	
	def agregarAlimentoConCarne(String preferencia){
		ingredientesCarnicos.add(new Ingrediente(preferencia))
	}
	
	override boolean subsanaCondicion(Collection<String> gustos, String rutina, float peso){ /*Verifica si logra subsanar el veganismo, se logra si le gustan las frutas */
		gustos.contains("fruta")
	} 
	
    override boolean recetaNoRecomendada(Receta receta){
    	ingredientesCarnicos.exists[ing | receta.tieneIngrediente(ing.nombre)]
    }
    
    override boolean verificaDatosSegunCondicion(Persona persona){ /* Verifica que el usuario no tenga como preferencia: “pollo�?, “carne�?, “chivito�?, “chori�? */
    	persona.prefiereNoComer(ingredientesCarnicos)
    } 
   
	override boolean esVeganismo(){true}
}