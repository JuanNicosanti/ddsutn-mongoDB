package dds.grupo9.queComemos.controller

import org.uqbar.commons.model.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import dds.grupo9.queComemos.xtrest.JSONPropertyUtils
import dds.grupo9.queComemos.repoUsuarios.RepoUsuarioEjemplo
import dds.grupo9.queComemos.repoRecetas.RepoRecetasEjemplo
import dds.grupo9.queComemos.applicationModels.LogueoAppModel
import dds.grupo9.queComemos.applicationModels.SeleccionRecetasAppModel
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.controller.PedidoLogin
import org.uqbar.xtrest.api.annotation.Post

import static dds.grupo9.queComemos.controller.ConfiguredDependencies.*
import javax.servlet.http.HttpServletRequest
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.applicationModels.DetalleRecetaAppModel
import dds.grupo9.queComemos.RecetaSimple
import java.util.Collection
import dds.grupo9.queComemos.Ingrediente
import org.uqbar.xtrest.api.annotation.Delete

@Controller
class RecetarioController {

	extension JSONUtils = new JSONUtils
//	extension JSONPropertyUtils = new JSONPropertyUtils

	@Post("/login")
	def Result login(@Body String body) {
		
		var PedidoLogin pedido = body.fromJson(PedidoLogin)
		var LogueoAppModel logueo = new LogueoAppModel();
		logueo.persona.nombre = pedido.nombre
		logueo.contrasegna = pedido.contrasegna
		var Persona p = logueo.personaBuscada()
		response.contentType = ContentType.APPLICATION_JSON
		ok(new RespuestaLogin(p).toJson)
	}	

	@Get("/recetas")
	def Result recetas() {
		var Persona persona = obtenerUsuario(request)
		var Collection<Receta> recetas = repoRecetas.getRecetas
		response.contentType = ContentType.APPLICATION_JSON
		ok(new ListadoRecetas(persona, recetas).toJson)
	}
	
	def obtenerUsuario(HttpServletRequest request) {
		var Persona personaBuscada = new Persona
		personaBuscada.nombre = getCookie(request, "usuario")
		repoUsuarios.get(personaBuscada)
	}
	
	def obtenerReceta(HttpServletRequest request) {
		repoRecetas.buscarRecetaPorNombre(getCookie(request, "receta"))
	}
	
	def getCookie(HttpServletRequest request, String string) {
		request.cookies.findFirst[it.name == string].value	
	}
	
	@Get("/recetaActual")
	def Result recetaActual() {
		println("Receta Actual:")
		var Receta receta = obtenerReceta(request)
		println(receta.nombre)
		var Persona persona = obtenerUsuario(request)
		println(persona.nombre)
		ok(new DetalleReceta(persona, receta).toJson)
	}
	
	@Get("/usuario")
	def Result usuario() {
		var Persona persona = obtenerUsuario(request)
		var UsuarioLogueado usuario = new UsuarioLogueado(persona)
		println(persona)
		ok(usuario.toJson)	
	}
	
	@Get("/ingredientes")
	def Result ingredientes(){
		var ingredientes = new ListadoIngredientes(repoRecetas.getRecetas)
		ok(ingredientes.toJson)
	}
	
	@Get("/consultas")
	def Result consultas() {
		var Persona persona = obtenerUsuario(request)
		var ConsultaReceta consulta = new ConsultaReceta(persona, repoRecetas)
//		println(persona)
		ok(consulta.toJson)	
	}
	
	@Get("/consultas2")
	def Result traerRecetasMasConsultadas(){
		var recetasConsultadas = new RecetasMuyConsultadas(repoUsuarios.getMonitor)
		println(recetasConsultadas.recetasADevolver.map[it.nombre])
		println(recetasConsultadas.consultas)
		ok(recetasConsultadas.toJson)
	}
	
	@Post("/filtradas")
	def Result filtrar(@Body String body){
		println("filtros")
		println(body)
		var FiltrosReceta filtros = body.fromJson(FiltrosReceta)
		var persona = obtenerUsuario(request)
		var ConsultaReceta recetas = new ConsultaReceta(persona,repoRecetas)
		recetas.filtrarRecetas(filtros)
		var recetasFiltradas = recetas.recetas
		consultasPorHora.update(persona, recetasFiltradas)
		recetasMasConsultadas.update(persona, recetasFiltradas)
		response.contentType = ContentType.APPLICATION_JSON
		println("filtradas")
		println(recetasFiltradas)
		ok(recetasFiltradas.toJson)
	}
	
	@Get("/recetasMasConsultadas")
	def Result getRecetasMasConsultadas() {
		ok(recetasMasConsultadas.toJson)	
	}
	
	@Get("/consultasPorHora")
	def Result getConsultasPorHora() {
		ok(consultasPorHora.toJson)	
	}
	
	@Post("/nuevoCond")
	def Result nuevoCond(@Body String body){
		var NuevoCondimento condimento = body.fromJson(NuevoCondimento)
		var receta =repoRecetas.buscarRecetaPorNombre(condimento.receta)
		receta.agregarCondimento(condimento.nombre)
		println(receta.condimentos)
		response.contentType = ContentType.APPLICATION_JSON
		ok(receta.toJson)
	}
	
	@Post("/nuevoIng")	
	def Result nuevoIng(@Body String body){
		var NuevoIngrediente ingrediente = body.fromJson(NuevoIngrediente)
		var receta = obtenerReceta(request)
		println(receta)
		receta.agregarIngrediente(new Ingrediente(ingrediente.nombre,ingrediente.cantidad))
		response.contentType = ContentType.APPLICATION_JSON
		ok(receta.toJson)
	}
		
	@Delete("/eliminarCond")
	def Result eliminarCond(@Body String body){
		println("Cond a eliminar")
		println(body)
		var NuevoCondimento condimento = body.fromJson(NuevoCondimento)
		var receta = repoRecetas.buscarRecetaPorNombre(condimento.receta)
		receta.eliminarCondimento(condimento.nombre)
		response.contentType = ContentType.APPLICATION_JSON
		ok(receta.toJson)
		
	}
	
		
	def static void main(String[] args) {
		XTRest.start(RecetarioController,8085)
	}

}
