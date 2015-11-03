package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column

@Observable
@Entity
@Accessors
class Ingrediente {
	@Id
	@GeneratedValue
	private Long id
	
	@Column
	@Accessors String nombre /* Para Entrega 2 */
	@Column
	@Accessors int cantidad
	
	new (){}
	
	new (String nombreIng){
		nombre = nombreIng
	}
	
	new (String nombreIng, int cantidadIng){
		nombre = nombreIng
		cantidad = cantidadIng
	}
	
	
	def boolean soyYo(String nombreIngrediente){ /*Devuelve true si el nombre del ingrediente es igual al pasado por parametro */
		nombre == nombreIngrediente
	}
   
    def boolean tieneMasDeLoPermitidoDe(int cantidadMax, Ingrediente ingrediente){
		soyYo(ingrediente.nombre) && cantidad > cantidadMax
    }
    
    def esCaro(){
    	soyYo("lechon") || soyYo("lomo") || soyYo("salmon") || soyYo("alcaparras")
    }
}