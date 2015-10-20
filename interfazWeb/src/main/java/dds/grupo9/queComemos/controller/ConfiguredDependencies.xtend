package dds.grupo9.queComemos.controller

import dds.grupo9.queComemos.repoUsuarios.RepoUsuarioEjemplo
import dds.grupo9.queComemos.repoRecetas.RepoRecetasEjemplo
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import dds.grupo9.queComemos.monitoreoDeConsultas.ConsultasPorHora

class ConfiguredDependencies {
	public static val repoUsuarios = new RepoUsuarioEjemplo
	public static val repoRecetas = new RepoRecetasEjemplo
	public static val recetasMasConsultadas = new RecetasMasConsultadas
	public static val consultasPorHora = new ConsultasPorHora
}