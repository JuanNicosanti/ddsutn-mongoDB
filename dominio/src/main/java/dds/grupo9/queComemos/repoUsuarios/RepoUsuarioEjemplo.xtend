package dds.grupo9.queComemos.repoUsuarios

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.repoRecetas.RepoRecetasEjemplo
import org.uqbar.commons.utils.Observable
import dds.grupo9.queComemos.consultas.ConsultaPorCondicionesPreexistentes
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.consultas.ConsultaPorDisgusto
import dds.grupo9.queComemos.manejoResultadosConsultas.Busqueda
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas

@Observable
class RepoUsuarioEjemplo extends RepoUsuarios {
	
	@Accessors BuilderPersona builder
	@Accessors Persona persona1
	@Accessors Persona persona2
	@Accessors Persona persona3
	@Accessors Persona persona4
	@Accessors Persona persona5
	@Accessors RepoRecetasEjemplo repositorioRecetas
	
	@Accessors RecetasMasConsultadas monitor = new RecetasMasConsultadas()
	
	new(){
		var filtroPCP = new ConsultaPorCondicionesPreexistentes
		var filtroPD = new ConsultaPorDisgusto()
		var busqueda1 = new Busqueda()
		var busqueda2 = new Busqueda()
			
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
		
		busqueda1.agregarMonitor(monitor)
		busqueda2.agregarMonitor(monitor)
		
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.head)
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.last)
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.findFirst[it.nombre=="Chori de cancha"])
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.findFirst[it.nombre=="Fideos con crema"])
		persona1.marcarRecetaComoFavorita(persona1.repoRecetas.getRecetas.findFirst[it.nombre=="Asadito dominguero"])
		repositorioRecetas.construirRecetaPrivada(persona1)
		
		persona2.marcarRecetaComoFavorita(persona2.repoRecetas.getRecetas.head)
		persona2.marcarRecetaComoFavorita(persona2.repoRecetas.getRecetas.last)
		persona2.agregarDisgusto("pescado")
		busqueda1.fuenteDeDatos = filtroPD
		busqueda1.persona = persona2 
		filtroPD.decorado = persona2
		filtroPD.persona = persona2
		busqueda1.resultadoSinProcesar()
		
		persona3.marcarRecetaComoFavorita(persona3.repoRecetas.getRecetas.head)
		persona3.marcarRecetaComoFavorita(persona3.repoRecetas.getRecetas.last)
		repositorioRecetas.construirRecetaPrivada(persona3)
		persona3.agregarCondPreexistente(new Hipertenso())
		
		//persona4.marcarRecetaComoFavorita(persona4.repoRecetas.getRecetas.head)
		//persona4.marcarRecetaComoFavorita(persona4.repoRecetas.getRecetas.last)
		persona4.agregarCondPreexistente(new Hipertenso())
		busqueda2.fuenteDeDatos = filtroPCP
		busqueda2.persona = persona4
		filtroPCP.decorado = persona4
		filtroPCP.persona = persona4
		busqueda2.resultadoSinProcesar()
		
		
//		persona5.marcarRecetaComoFavorita(persona5.repoRecetas.getRecetas.head)
//		persona5.marcarRecetaComoFavorita(persona5.repoRecetas.getRecetas.last)
		
		this.add(persona1)
		this.add(persona2)
		this.add(persona3)
		this.add(persona4)
		this.add(persona5)
	}

}