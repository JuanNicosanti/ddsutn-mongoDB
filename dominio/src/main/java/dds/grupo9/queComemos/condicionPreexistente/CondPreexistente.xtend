package dds.grupo9.queComemos.condicionPreexistente

import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Persona
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Inheritance
import javax.persistence.InheritanceType

@Entity
@Observable
@Accessors
@Inheritance(strategy=InheritanceType.JOINED)
abstract class CondPreexistente {
	@Id
	@GeneratedValue
	private Long id

	def boolean subsanaCondicion(Collection<String> gustos, String rutina, float peso)

	def boolean recetaNoRecomendada(Receta receta)

	def boolean verificaDatosSegunCondicion(Persona persona)

	def boolean esVeganismo()

}
