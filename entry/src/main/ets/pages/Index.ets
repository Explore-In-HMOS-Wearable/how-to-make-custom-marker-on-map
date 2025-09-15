import { map, mapCommon, MapComponent } from '@kit.MapKit'

@Entry
@Component
struct Index {
  private mapController?: map.MapComponentController;
  private mapEventManager?: map.MapEventManager;
  private markerOptions: mapCommon.MarkerOptions[] = [
    {
      position: {
        latitude: 41.021111, longitude: 29.004167
      },
      icon: $r("app.media.flower"),
    },
    {
      position: {
        latitude: 41.02556492071563, longitude: 28.974127488867722
      },
      icon: $r('app.media.paperplane'),
    },
    {
      position: {
        latitude: 41.00540315768449, longitude: 28.97681694006958
      },
      icon: $r('app.media.moon_fill'),
    }
  ]

  build() {
    Stack() {
      MapComponent({
        mapOptions: {
          position: {
            target: { latitude: 41.02, longitude: 28.99 },
            zoom: 12
          }
        },
        mapCallback: (err, mapController) => {
          if (!err) {
            this.mapController = mapController;
            this.mapEventManager = this.mapController.getEventManager();
            let callback = async () => {
              // add markers

              for (let i = 0; i < this.markerOptions.length; i++) {
                await this.mapController?.addMarker(this.markerOptions[i])
              }
            }
            this.mapEventManager.on("mapLoad", callback);
          }
        }
      }).width('100%').height('100%')
    }
  }
}