package queComemosInterface;

import dds.grupo9.queComemos.Persona;
import dds.grupo9.queComemos.applicationModels.LogueoAppModel;
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.arena.widgets.Button;
import org.uqbar.arena.widgets.Control;
import org.uqbar.arena.widgets.Label;
import org.uqbar.arena.widgets.Panel;
import org.uqbar.arena.widgets.TextBox;
import org.uqbar.arena.windows.SimpleWindow;
import org.uqbar.arena.windows.WindowOwner;
import org.uqbar.lacar.ui.model.Action;
import org.uqbar.lacar.ui.model.ControlBuilder;
import org.uqbar.lacar.ui.model.bindings.Binding;
import queComemosInterface.SeleccionRecetas;

@SuppressWarnings("all")
public class LogueoWindow extends SimpleWindow<LogueoAppModel> {
  public LogueoWindow(final WindowOwner parent) {
    super(parent, new LogueoAppModel());
  }
  
  public void createContents(final Panel mainPanel) {
    this.setTitle("Login");
    this.setTaskDescription("Ingrese su usuario y contraseña");
    super.createMainTemplate(mainPanel);
  }
  
  public void createFormPanel(final Panel mainPanel) {
    this.crearPanelTop(mainPanel);
    this.crearPanelMid(mainPanel);
  }
  
  public void addActions(final Panel actionsPanel) {
    Button _button = new Button(actionsPanel);
    final Procedure1<Button> _function = new Procedure1<Button>() {
      public void apply(final Button it) {
        it.setCaption("Log In");
        final Action _function = new Action() {
          public void execute() {
            LogueoAppModel _modelObject = LogueoWindow.this.getModelObject();
            Persona personaBuscada = _modelObject.personaBuscada();
            LogueoAppModel _modelObject_1 = LogueoWindow.this.getModelObject();
            RecetasMasConsultadas monitor = _modelObject_1.monitor();
            final SeleccionRecetas seleccionRecetas = new SeleccionRecetas(LogueoWindow.this, personaBuscada, monitor);
            LogueoWindow.this.close();
            seleccionRecetas.open();
          }
        };
        it.onClick(_function);
      }
    };
    ObjectExtensions.<Button>operator_doubleArrow(_button, _function);
  }
  
  public Panel crearPanelTop(final Panel panel) {
    Panel _xblockexpression = null;
    {
      Panel nombrePanel = new Panel(panel);
      this.setTitle("Log In");
      Label _label = new Label(nombrePanel);
      _label.setText("Ingrese nombre de usuario: ");
      TextBox _textBox = new TextBox(nombrePanel);
      _textBox.<Object, ControlBuilder>bindValueToProperty("persona.nombre");
      _xblockexpression = nombrePanel.setWidth(100);
    }
    return _xblockexpression;
  }
  
  public Binding<Object, Control, ControlBuilder> crearPanelMid(final Panel panel) {
    Binding<Object, Control, ControlBuilder> _xblockexpression = null;
    {
      Panel contraseñaUsuarioPanel = new Panel(panel);
      Label _label = new Label(contraseñaUsuarioPanel);
      _label.setText("Ingrese contraseña: ");
      TextBox _textBox = new TextBox(contraseñaUsuarioPanel);
      _xblockexpression = _textBox.<Object, ControlBuilder>bindValueToProperty("contrasegna");
    }
    return _xblockexpression;
  }
}
