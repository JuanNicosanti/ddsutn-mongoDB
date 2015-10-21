package queComemosInterface;

import dds.grupo9.queComemos.Ingrediente;
import dds.grupo9.queComemos.Persona;
import dds.grupo9.queComemos.Receta;
import dds.grupo9.queComemos.applicationModels.DetalleRecetaAppModel;
import dds.grupo9.queComemos.condicionPreexistente.CondPreexistente;
import java.util.Collection;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.uqbar.arena.layout.ColumnLayout;
import org.uqbar.arena.layout.HorizontalLayout;
import org.uqbar.arena.widgets.Button;
import org.uqbar.arena.widgets.CheckBox;
import org.uqbar.arena.widgets.Control;
import org.uqbar.arena.widgets.Label;
import org.uqbar.arena.widgets.List;
import org.uqbar.arena.widgets.Panel;
import org.uqbar.arena.widgets.tables.Column;
import org.uqbar.arena.widgets.tables.Table;
import org.uqbar.arena.windows.Dialog;
import org.uqbar.arena.windows.WindowOwner;
import org.uqbar.lacar.ui.model.Action;
import org.uqbar.lacar.ui.model.ControlBuilder;
import org.uqbar.lacar.ui.model.bindings.Binding;

@SuppressWarnings("all")
public class DetalleReceta extends Dialog<DetalleRecetaAppModel> {
  public DetalleReceta(final WindowOwner parent, final Receta recetaModelo, final Persona logueado) {
    super(parent, new DetalleRecetaAppModel(logueado, recetaModelo));
  }
  
  public void createContents(final Panel mainPanel) {
    this.setTitle("Detalle Receta");
    this.construirEncabezado(mainPanel);
    super.createMainTemplate(mainPanel);
  }
  
  protected void createFormPanel(final Panel mainPanel) {
    final Panel secondaryPanel = new Panel(mainPanel);
    ColumnLayout _columnLayout = new ColumnLayout(2);
    secondaryPanel.setLayout(_columnLayout);
    this.contruirMitadIzquierda(secondaryPanel);
    this.construirMitadDerecha(secondaryPanel);
    this.construirPie(mainPanel);
  }
  
  public Button construirPie(final Panel mainPanel) {
    Button _xblockexpression = null;
    {
      Label _label = new Label(mainPanel);
      _label.setText("Proceso de preparación");
      Label _label_1 = new Label(mainPanel);
      _label_1.<Object, ControlBuilder>bindValueToProperty("recetaSeleccionada.explicacion");
      final Panel secondaryPanel4 = new Panel(mainPanel);
      ColumnLayout _columnLayout = new ColumnLayout(5);
      secondaryPanel4.setLayout(_columnLayout);
      final Panel subPanel1 = new Panel(secondaryPanel4);
      final Panel subPanel2 = new Panel(secondaryPanel4);
      final Panel subPanel3 = new Panel(secondaryPanel4);
      Button _button = new Button(subPanel3);
      final Procedure1<Button> _function = new Procedure1<Button>() {
        public void apply(final Button it) {
          it.setCaption("Volver");
          final Action _function = new Action() {
            public void execute() {
              DetalleReceta.this.close();
            }
          };
          it.onClick(_function);
        }
      };
      _xblockexpression = ObjectExtensions.<Button>operator_doubleArrow(_button, _function);
    }
    return _xblockexpression;
  }
  
  public Control construirMitadDerecha(final Panel secondaryPanel) {
    Control _xblockexpression = null;
    {
      final Panel panelDerecho = new Panel(secondaryPanel);
      Label _label = new Label(panelDerecho);
      _label.setText("Temporada");
      Label _label_1 = new Label(panelDerecho);
      _label_1.<Object, ControlBuilder>bindValueToProperty("recetaSeleccionada.temporadasCorrespondientes");
      Label _label_2 = new Label(panelDerecho);
      _label_2.setText("Condimentos");
      List<Object> _list = new List<Object>(panelDerecho);
      final Procedure1<List<Object>> _function = new Procedure1<List<Object>>() {
        public void apply(final List<Object> it) {
          it.bindItemsToProperty("recetaSeleccionada.condimentos");
          it.setWidth(200);
          it.setHeight(100);
        }
      };
      ObjectExtensions.<List<Object>>operator_doubleArrow(_list, _function);
      Label _label_3 = new Label(panelDerecho);
      _label_3.setText("Condiciones preexistentes");
      Control _xifexpression = null;
      DetalleRecetaAppModel _modelObject = this.getModelObject();
      Receta _recetaSeleccionada = _modelObject.getRecetaSeleccionada();
      Collection<CondPreexistente> _condiciones = _recetaSeleccionada.getCondiciones();
      int _length = ((Object[])Conversions.unwrapArray(_condiciones, Object.class)).length;
      boolean _notEquals = (_length != 0);
      if (_notEquals) {
        List<Object> _list_1 = new List<Object>(panelDerecho);
        final Procedure1<List<Object>> _function_1 = new Procedure1<List<Object>>() {
          public void apply(final List<Object> it) {
            it.bindItemsToProperty("recetaSeleccionada.condiciones");
            it.setWidth(200);
            it.setHeight(100);
          }
        };
        _xifexpression = ObjectExtensions.<List<Object>>operator_doubleArrow(_list_1, _function_1);
      } else {
        Label _label_4 = new Label(panelDerecho);
        _xifexpression = _label_4.setText(
          "No hay condiciones\r\nno recomendadadas \r\npara esta receta");
      }
      _xblockexpression = _xifexpression;
    }
    return _xblockexpression;
  }
  
  public Label contruirMitadIzquierda(final Panel secondaryPanel) {
    Label _xblockexpression = null;
    {
      final Panel panelIzquierdo = new Panel(secondaryPanel);
      Label _label = new Label(panelIzquierdo);
      _label.setText("Dificultad");
      Label _label_1 = new Label(panelIzquierdo);
      _label_1.<Object, ControlBuilder>bindValueToProperty("recetaSeleccionada.dificultad");
      Label _label_2 = new Label(panelIzquierdo);
      _label_2.setText("Ingredientes");
      Table<Ingrediente> _table = new Table<Ingrediente>(panelIzquierdo, Ingrediente.class);
      final Procedure1<Table<Ingrediente>> _function = new Procedure1<Table<Ingrediente>>() {
        public void apply(final Table<Ingrediente> it) {
          it.bindItemsToProperty("recetaSeleccionada.ingredientes");
        }
      };
      final Table<Ingrediente> table = ObjectExtensions.<Table<Ingrediente>>operator_doubleArrow(_table, _function);
      this.describeResultsGrid(table);
      final Panel secondaryPanel3 = new Panel(panelIzquierdo);
      ColumnLayout _columnLayout = new ColumnLayout(2);
      secondaryPanel3.setLayout(_columnLayout);
      final Panel subPanelIzquierdo = new Panel(secondaryPanel3);
      final Panel subPanelDerecho = new Panel(secondaryPanel3);
      CheckBox _checkBox = new CheckBox(subPanelIzquierdo);
      _checkBox.<Object, ControlBuilder>bindValueToProperty("esFavorita");
      Label _label_3 = new Label(subPanelDerecho);
      _xblockexpression = _label_3.setText("Favorita");
    }
    return _xblockexpression;
  }
  
  public Column<Ingrediente> describeResultsGrid(final Table<Ingrediente> table) {
    Column<Ingrediente> _xblockexpression = null;
    {
      Column<Ingrediente> _column = new Column<Ingrediente>(table);
      final Procedure1<Column<Ingrediente>> _function = new Procedure1<Column<Ingrediente>>() {
        public void apply(final Column<Ingrediente> it) {
          it.setTitle("Cantidad");
          it.setFixedSize(150);
          it.bindContentsToProperty("cantidad");
        }
      };
      ObjectExtensions.<Column<Ingrediente>>operator_doubleArrow(_column, _function);
      Column<Ingrediente> _column_1 = new Column<Ingrediente>(table);
      final Procedure1<Column<Ingrediente>> _function_1 = new Procedure1<Column<Ingrediente>>() {
        public void apply(final Column<Ingrediente> it) {
          it.setTitle("Ingrediente");
          it.setFixedSize(150);
          it.bindContentsToProperty("nombre");
        }
      };
      _xblockexpression = ObjectExtensions.<Column<Ingrediente>>operator_doubleArrow(_column_1, _function_1);
    }
    return _xblockexpression;
  }
  
  public Binding<Object, Control, ControlBuilder> construirEncabezado(final Panel mainPanel) {
    Binding<Object, Control, ControlBuilder> _xblockexpression = null;
    {
      Label _label = new Label(mainPanel);
      _label.<Object, ControlBuilder>bindValueToProperty("recetaSeleccionada.nombre");
      final Panel secondaryPanel = new Panel(mainPanel);
      HorizontalLayout _horizontalLayout = new HorizontalLayout();
      secondaryPanel.setLayout(_horizontalLayout);
      Label _label_1 = new Label(secondaryPanel);
      _label_1.<Object, ControlBuilder>bindValueToProperty("recetaSeleccionada.calorias");
      Label _label_2 = new Label(secondaryPanel);
      _label_2.setText("calorias ");
      Label _label_3 = new Label(secondaryPanel);
      _label_3.setText("Creada por: ");
      Label _label_4 = new Label(secondaryPanel);
      _xblockexpression = _label_4.<Object, ControlBuilder>bindValueToProperty("autor");
    }
    return _xblockexpression;
  }
}
