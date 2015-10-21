package dds.grupo9.queComemos.consultas

import java.util.Collection
import dds.grupo9.queComemos.Receta
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Inheritance
import javax.persistence.InheritanceType

@Entity
@Accessors
@Observable
@Inheritance(strategy=InheritanceType.JOINED)
abstract class ConsultaDecorada {
	@Id
	@GeneratedValue
	private Long id
	def Collection<Receta> resultado()
	def Collection<Consulta> coleccionDeConsultas()	
	
	
}