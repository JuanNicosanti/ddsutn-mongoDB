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


@Accessors
@Observable

abstract class ConsultaDecorada {

	def Collection<Receta> resultado()
	def Collection<Consulta> coleccionDeConsultas()	
	
	
}