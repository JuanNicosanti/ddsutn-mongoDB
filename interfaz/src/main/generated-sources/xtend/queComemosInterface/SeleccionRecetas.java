package queComemosInterface;

import dds.grupo9.queComemos.Persona;
import dds.grupo9.queComemos.Receta;
import dds.grupo9.queComemos.applicationModels.SeleccionRecetasAppModel;
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas;
import java.awt.Color;
import org.apache.commons.collections15.Transformer;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.arena.bindings.NotNullObservable;
import org.uqbar.arena.layout.HorizontalLayout;
import org.uqbar.arena.widgets.Button;
import org.uqbar.arena.widgets.Label;
import org.uqbar.arena.widgets.Panel;
import org.uqbar.arena.widgets.tables.Column;
import org.uqbar.arena.widgets.tables.Table;
import org.uqbar.arena.widgets.tables.labelprovider.BackgroundProvider;
import org.uqbar.arena.windows.Dialog;
import org.uqbar.arena.windows.SimpleWindow;
import org.uqbar.arena.windows.WindowOwner;
import org.uqbar.lacar.ui.model.Action;
import org.uqbar.lacar.ui.model.ControlBuilder;
import queComemosInterface.DetalleReceta;

@SuppressWarnings("all")
public class SeleccionRecetas extends SimpleWindow<SeleccionRecetasAppModel> {
  public SeleccionRecetas(final WindowOwner owner, final Persona persona, final RecetasMasConsultadas monitor) {
    super(owner, new SeleccionRecetasAppModel(persona, monitor));
  }
  
  public void createMainTemplate(final Panel mainPanel) {
    this.setTitle("Recetas");
    this.setTaskDescription("Elija la receta que desea ver en detalle");
    super.createMainTemplate(mainPanel);
  }
  
  public void createFormPanel(final Panel mainPanel) {
    this.setTitle("Bienvenido a ¿Qué comemos?");
    Label _label = new Label(mainPanel);
    _label.<Object, ControlBuilder>bindValueToProperty("mensajeCorrespondiente");
    Table<Receta> _table = new Table<Receta>(mainPanel, Receta.class);
    final Procedure1<Table<Receta>> _function = new Procedure1<Table<Receta>>() {
      public void apply(final Table<Receta> it) {
        it.bindItemsToProperty("seleccionDeRecetas");
        it.<Object, ControlBuilder>bindValueToProperty("recetaSeleccionada");
      }
    };
    final Table<Receta> table = ObjectExtensions.<Table<Receta>>operator_doubleArrow(_table, _function);
    this.describeResultsGrid(table);
  }
  
  public void addActions(final Panel mainPanel) {
    Panel _panel = new Panel(mainPanel);
    HorizontalLayout _horizontalLayout = new HorizontalLayout();
    final Panel actionsPanel = _panel.setLayout(_horizontalLayout);
    final NotNullObservable elementSelected = new NotNullObservable("recetaSeleccionada");
    Button _button = new Button(actionsPanel);
    final Procedure1<Button> _function = new Procedure1<Button>() {
      public void apply(final Button it) {
        it.setCaption("Ver");
        final Action _function = new Action() {
          public void execute() {
            SeleccionRecetas.this.verReceta();
          }
        };
        it.onClick(_function);
        it.<Object, ControlBuilder>bindEnabled(elementSelected);
      }
    };
    ObjectExtensions.<Button>operator_doubleArrow(_button, _function);
  }
  
  public Column<Receta> describeResultsGrid(final Table<Receta> table) {
    Column<Receta> _xblockexpression = null;
    {
      Column<Receta> _column = new Column<Receta>(table);
      final Procedure1<Column<Receta>> _function = new Procedure1<Column<Receta>>() {
        public void apply(final Column<Receta> it) {
          it.setTitle("Nombre");
          it.setFixedSize(150);
          it.bindContentsToProperty("nombre");
          BackgroundProvider<Receta, Color> _bindBackground = it.bindBackground("nombreDuenio");
          final Transformer<String, Color> _function = new Transformer<String, Color>() {
            public Color transform(final String nombre) {
              Color _xifexpression = null;
              boolean _equals = nombre.equals("D10S (Receta Publica)");
              if (_equals) {
                _xifexpression = Color.BLUE;
              } else {
                Color _xifexpression_1 = null;
                SeleccionRecetasAppModel _modelObject = SeleccionRecetas.this.getModelObject();
                Persona _persona = _modelObject.getPersona();
                String _nombre = _persona.getNombre();
                boolean _equals_1 = nombre.equals(_nombre);
                if (_equals_1) {
                  _xifexpression_1 = Color.ORANGE;
                } else {
                  _xifexpression_1 = Color.GREEN;
                }
                _xifexpression = _xifexpression_1;
              }
              return _xifexpression;
            }
          };
          _bindBackground.setTransformer(_function);
        }
      };
      ObjectExtensions.<Column<Receta>>operator_doubleArrow(_column, _function);
      Column<Receta> _column_1 = new Column<Receta>(table);
      final Procedure1<Column<Receta>> _function_1 = new Procedure1<Column<Receta>>() {
        public void apply(final Column<Receta> it) {
          it.setTitle("Calorías");
          it.setFixedSize(150);
          it.bindContentsToProperty("calorias");
        }
      };
      ObjectExtensions.<Column<Receta>>operator_doubleArrow(_column_1, _function_1);
      Column<Receta> _column_2 = new Column<Receta>(table);
      final Procedure1<Column<Receta>> _function_2 = new Procedure1<Column<Receta>>() {
        public void apply(final Column<Receta> it) {
          it.setTitle("Dificultad");
          it.setFixedSize(150);
          it.bindContentsToProperty("dificultad");
        }
      };
      ObjectExtensions.<Column<Receta>>operator_doubleArrow(_column_2, _function_2);
      Column<Receta> _column_3 = new Column<Receta>(table);
      final Procedure1<Column<Receta>> _function_3 = new Procedure1<Column<Receta>>() {
        public void apply(final Column<Receta> it) {
          it.setTitle("Temporada");
          it.setFixedSize(150);
          it.bindContentsToProperty("temporadasCorrespondientes");
        }
      };
      _xblockexpression = ObjectExtensions.<Column<Receta>>operator_doubleArrow(_column_3, _function_3);
    }
    return _xblockexpression;
  }
  
  public void verReceta() {
    SeleccionRecetasAppModel _modelObject = this.getModelObject();
    Receta _recetaSeleccionada = _modelObject.getRecetaSeleccionada();
    SeleccionRecetasAppModel _modelObject_1 = this.getModelObject();
    Persona _persona = _modelObject_1.getPersona();
    DetalleReceta _detalleReceta = new DetalleReceta(this, _recetaSeleccionada, _persona);
    this.openDialog(_detalleReceta);
  }
  
  public void openDialog(final Dialog<?> dialog) {
    dialog.open();
  }
}
