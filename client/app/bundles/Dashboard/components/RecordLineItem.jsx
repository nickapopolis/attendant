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
        <img className='record-image' src={this.props.record.s3_url}/>
        <div className='record-details'>
          <div className='col-xs-4'>
            <div className='record-plate'>
              <label>Plate</label> {this.props.record.plate}
            </div>
            <div className='record-confidence'>
              <label>Confidence</label> {this.props.record.confidence}%
            </div>
          </div>
          <div className='col-xs-4'>
            <div className='record-confidence'>
              <label>Created at</label> {this.props.record.analyzed_at}
            </div>
            <div className='record-confidence'>
              <label>Location</label> {this.props.record.location}
            </div>
          </div>
          <div className='col-xs-4'>
            <div className='record-confidence'>
              <label>Last seen Time</label> {this.props.record.last_seen_time}
            </div>
            <div className='record-confidence'>
              <label>Last seen Location</label> {this.props.record.last_seen_location}
            </div>
          </div>
        </div>
      </div>
    );
  }
}
