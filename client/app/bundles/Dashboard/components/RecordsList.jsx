import PropTypes from 'prop-types';
import React from 'react';
import RecordLineItem from './RecordLineItem.jsx';

export default class RecordsList extends React.Component {
  static propTypes = {
    records: PropTypes.array.isRequired
  };

  constructor(props, _railsContext) {
    super(props);
    this.state = {
      records: this.props.records
    };
  }

  render() {
    return (
      <div className='records-container'>
      {this.state.records.map((record) =>
        <RecordLineItem record={record} key={record.id}/>
      )}
      </div>
    );
  }
}
