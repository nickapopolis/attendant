import PropTypes from 'prop-types';
import React from 'react';

export default class RecordLineItem extends React.Component {
  static propTypes = {
    record: PropTypes.object.isRequired
  };

  constructor(props, _railsContext) {
    super(props);
    this.state = {
      record: props.record
    };
  }

  render() {
    return (
      <div className='record-line-item'>
        {this.state.record.s3_url}
      </div>
    );
  }
}
