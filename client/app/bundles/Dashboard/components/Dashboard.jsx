import React                from 'react';
import PropTypes            from 'prop-types';
import ActionCableProvider  from 'react-actioncable-provider'
import ActionCable          from 'actioncable'
import RecordsList          from './RecordsList.jsx';

const cable = ActionCable.createConsumer('ws://localhost:5000/cable');

export default class Dashboard extends React.Component {
  static propTypes = {
    user: PropTypes.object.isRequired,
    records: PropTypes.array.isRequired,
    s3_url: PropTypes.string.isRequired,
    s3_fields: PropTypes.object.isRequired
  };

  /**
   * @param props - Comes from your rails view.
   * @param _railsContext - Comes from React on Rails
   */
  constructor(props, _railsContext) {
    super(props);
    this.state = {
      user: props.user,
      records: props.records
    };
  }

  render() {
    return (
      <div>
        <h3>
          Welcome to your dashboard, {this.state.user.email}!
        </h3>
        <hr />
        <div className='upload-drop-zone'>
           Drag and drop OR Click to Upload
           a Picture of a License Plate
        </div>

        <input type='file' name='record[s3_url]' id='s3-upload-image-input' className='hidden'/>
        <ActionCableProvider cable={cable}>
          <RecordsList records={this.props.records} user={this.props.user}/>
        </ActionCableProvider>
      </div>
    );
  }

  componentDidMount() {
    this.setupFileUpload()
  }

  setupFileUpload() {
    var imageInput   = $('.upload-drop-zone')
    var fileInput    = $('#s3-upload-image-input')
    var progressBar  = $("<div class='bar'></div>")
    var barContainer = $("<div class='progress'></div>").append(progressBar)
    fileInput.after(barContainer.css('display','none'))

    imageInput.click((e) => {
      fileInput.click()
    })

    fileInput.fileupload({
      fileInput:          fileInput,
      url:                this.props.s3_url,
      type:               'POST',
      autoUpload:         true,
      formData:           this.props.s3_fields,
      acceptFileTypes:    /(\.|\/)(gif|jpe?g|png)$/i,
      paramName:          'file',
      dataType:           'XML',
      uploadTemplateId:   null,
      downloadTemplateId: null,
      replaceFileInput:   false,
      progressall: (e, data) => {
        var progress = parseInt(data.loaded / data.total * 100, 10)
        progressBar.css('width', progress + '%')
      },
      start: (e) => {
        barContainer.fadeIn('fast')
        progressBar.
          css('background', 'green').
          css('display', 'block').
          css('width', '0%').
          text("Loading...")
      },
      done: (e, data) => {
        barContainer.fadeOut('slow')
        // extract key and generate URL from response
        var key = $(data.jqXHR.responseXML).find("Key").text()
        this.doCreateRecord(data)
      },
      fail: (e, data) => {
        progressBar.css("background", "red").text("Failed")
      }
    })
  }

  doCreateRecord(data) {
    $.ajax({
      dataType: 'JSON',
      method: 'POST',
      url: '/records',
      data: {
        record:{
          s3_url: $(data.jqXHR.responseXML).find('Location').text()
        }
      },
      fail: (error) => {
        console.log('failed to create record: ', error) //todo error reporting
      }
    })
  }
}
