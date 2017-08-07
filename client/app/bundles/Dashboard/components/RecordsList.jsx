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
      records: props.records
    };
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
