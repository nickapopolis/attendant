import React            from 'react';
import PropTypes        from 'prop-types';
import RecordLineItem   from './RecordLineItem.jsx';
import ActionCable      from 'actioncable'

export default class RecordsList extends React.Component {
  static propTypes = {
    user: PropTypes.object.isRequired,
    records: PropTypes.array.isRequired
  };

  static contextTypes = {
    cable: PropTypes.object.isRequired
  };

  constructor(props, _railsContext) {
    super(props);
    this.state = {
      records: props.records
    };
  }

  componentDidMount() {
    this.setupCable()
  }

  componentWillUnmount(){
    this.breakDownCable()
  }

  setupCable() {
    this.subscription = this.context.cable.subscriptions.create('AttendantInfoChannel', { received: function(response){
      if(response.status == 200 && response.type == 'add'){
        this.addRecord(response.record);
      } else if (response.status == 400 && response.type == 'error'){
        alert('server had an error' + response.message);
      } else {
        throw 'Something went terribly wrong'
      }
    }.bind(this)});
  }

  breakDownCable() {
    this.subscription && this.context.cable.subscriptions.remove(this.subscription)
  }

  addRecord(record) {
    this.props.records.push(record);
    this.forceUpdate(); //normally we dont need this, should have re-rendered on its own o.o
  }

  render() {
    return (
      <div className='records-container'>
      <h3>
        My Plates
      </h3>
      <div className='records-header'>
        Load: <a href=''>10</a> | Sort by: <a href=''>Newest</a>
      </div>
      {
        this.props.records.map((record) =>
          <RecordLineItem record={record} key={record.id}/>
        )
      }
      </div>
    );
  }
}
