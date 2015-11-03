package dds.grupo9.queComemos.monitoreoDeConsultas

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import org.uqbar.commons.utils.Observable
import javax.persistence.Column
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Accessors
@Observable
class EstadisticaReceta {
	@Id
	@GeneratedValue
	private Long id
	
	@Column
	@Accessors String nombre
	@Column
	@Accessors int consultas
	
	new(String nom){
		this.nombre = nom
		consultas = 0		
	}
	
	def incrementarContador(){
		consultas = consultas + 1
	}
		
}