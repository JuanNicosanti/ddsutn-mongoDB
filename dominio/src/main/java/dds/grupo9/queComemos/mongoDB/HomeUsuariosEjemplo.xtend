package dds.grupo9.queComemos.mongoDB

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.repoRecetas.RepoRecetasEjemplo
import org.uqbar.commons.utils.Observable
import dds.grupo9.queComemos.consultas.ConsultaPorCondicionesPreexistentes
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.consultas.ConsultaPorDisgusto
import dds.grupo9.queComemos.manejoResultadosConsultas.Busqueda
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import org.junit.Before
import org.junit.After
import dds.grupo9.queComemos.mongoDB.Collection
import dds.grupo9.queComemos.mongoDB.SistemDB
import java.util.List
import dds.grupo9.queComemos.repoUsuarios.BuilderPersona

@Observable
class HomeUsuariosEjemplo extends HomeUsuarios {
	@Accessors BuilderPersona builder
	@Accessors Persona persona1
	@Accessors Persona persona2
	@Accessors Persona persona3
	@Accessors Persona persona4
	@Accessors Persona persona5
	@Accessors RepoRecetasEjemplo repositorioRecetas
	@Accessors PersonaMongo p3
	
	public Collection<PersonaMongo> homeUsuario
	List<PersonaMongo> personas
	
	@Before
	def void setup(){			
		//crear y configurar personas
		builder = new BuilderPersona
		this.repositorioRecetas = new RepoRecetasEjemplo
		builder.asignarAltura(1.70f)
       	builder.asignarPeso(70f)
      	builder.asignarRutina("Crossfit")
       	builder.asignarFechaNacimiento(19901010)
      	builder.asignarSexo("Masculino")
      	builder.repoRecetas = repositorioRecetas
		persona1 = builder.build
		persona2 = builder.build
		persona3 = builder.build
		persona4 = builder.build
		persona5 = builder.build
		persona1.nombre = "Juani"
		persona2.nombre = "Juampi"
		persona3.nombre = "Santi"
		persona4.nombre = "Dante"
		persona5.nombre = "Igna"
		persona1.contrasegna = "tagliafico"
		persona2.contrasegna = "unaContrasegna"
		persona3.contrasegna = "unaContrasegna"
		persona4.contrasegna = "unaContrasegna"
		persona5.contrasegna = "unaContrasegna"
		
		homeUsuario = SistemDB.instance().collection(PersonaMongo)
		
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.head)
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.last)
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.findFirst[it.nombre=="Chori de cancha"])
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.findFirst[it.nombre=="Fideos con crema"])
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.findFirst[it.nombre=="Asadito dominguero"])
		
		persona2.marcarRecetaComoFavorita(persona2.repoRecetas.getRecetas.head)
		persona2.marcarRecetaComoFavorita(persona2.repoRecetas.getRecetas.last)
		
		persona3.marcarRecetaComoFavorita(persona3.repoRecetas.getRecetas.head)
		persona3.marcarRecetaComoFavorita(persona3.repoRecetas.getRecetas.last)
		
		this.add(persona1)
		this.add(persona2)
		this.add(persona3)
		this.add(persona4)
		this.add(persona5)
		
		val PersonaMongo p1 = new PersonaMongo(persona1)
		val PersonaMongo p2 = new PersonaMongo(persona2)
		p3 = new PersonaMongo(persona3)
		val PersonaMongo p4 = new PersonaMongo(persona4)
		val PersonaMongo p5 = new PersonaMongo(persona5)
		
		personas = #[
			p1,p2,p3,p4,p5
		]
		homeUsuario.insert(personas)
	}
	
	@After
	def void cleanDB(){
		homeUsuario.mongoCollection.drop
	}

}
