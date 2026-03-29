import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { cameraPicker, camera } from '@kit.CameraKit'
import { common } from '@kit.AbilityKit'
import { Toast } from '../utils/Toast'
interface PanelItem {
  icon: Resource
  label: string
}

@Component
export default struct ChatMorePanel {
  context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext
  onImageSelected: (uri: string) => void = () => {}

  private panelItems: PanelItem[] = [
    { icon: $r('app.media.ic_camera'), label: '相册' },
    { icon: $r('app.media.ic_shoot'), label: '拍摄' },
    { icon: $r('app.media.ic_file'), label: '文件' },
    { icon: $r('app.media.ic_location'), label: '位置' },
    { icon: $r('app.media.ic_voice_input'), label: '语音通话' },
    { icon: $r('app.media.ic_voice_call'), label: '视频通话' },
    { icon: $r('app.media.ic_red_pkg'), label: '红包' },
    { icon: $r('app.media.ic_translation'), label: '转账' },
  ]

  // 打开相册（支持多选）
  async openAlbum() {
    try {
      let photoPicker = new photoAccessHelper.PhotoViewPicker()
      let result = await photoPicker.select({
        MIMEType: photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE,
        maxSelectNumber: 9
      })
      if (result.photoUris && result.photoUris.length > 0) {
        for (let uri of result.photoUris) {
          this.onImageSelected(uri)
        }
      }
    } catch (err) {
      console.error('openAlbum failed:', JSON.stringify(err))
    }
  }

  // 打开相机拍照
  async openCamera() {
    try {
      let pickerProfile: cameraPicker.PickerProfile = {
        cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK
      }
      let result = await cameraPicker.pick(
        this.context,
        [cameraPicker.PickerMediaType.PHOTO],
        pickerProfile
      )
      if (result.resultCode === 0 && result.resultUri) {
        this.onImageSelected(result.resultUri)
      }
    } catch (err) {
      console.error('openCamera failed:', JSON.stringify(err))
    }
  }

  build() {
    Grid() {
      ForEach(this.panelItems, (item: PanelItem, index: number) => {
        GridItem() {
          Column({ space: 8 }) {
            Column() {
              Image(item.icon)
                .width(30)
                .height(30)
                .fillColor('#555555')
            }
            .width(60)
            .height(60)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            Text(item.label)
              .fontSize(12)
              .fontColor('#888888')
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          .onClick(async () => {
            if (index === 0) {
              await this.openAlbum()
            } else if (index === 1) {
              await this.openCamera()
            } else {
              Toast.show('功能正在开发中...')
            }
          })
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr')
    .columnsGap(0)
    .rowsGap(16)
    .padding({ left: 20, right: 20, top: 20, bottom: 30 })
    .width('100%')
    .height(200)
    .backgroundColor('#F5F5F5')
    .border({ width: { top: 0.5 }, color: '#DDDDDD' })
  }
}