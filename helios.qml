import QtQuick 2.5
import QtQuick.Controls 1.4

Rectangle {
    id: root
    width: 480
    height: 480

    property string errorSVG: "data:image/svg+xml,<svg height='128' width='480'><text x='8' y='32' fill='red' font-size='18'>404: Image for given resolution is not availble</text><text x='8' y='64' fill='red'>%1</text></svg>"
    property string welcomeSVG: "data:image/svg+xml,<svg height='128' width='480'><text x='8' y='32' fill='black' font-size='18'>Helios Widget</text><text x='8' y='64' fill='black'>Please right click and choose image</text></svg>"

    Item {
        id: settings
        property string heliosImg: welcomeSVG
        property int resolution: 512
    }

    Image {
        id: img
        cache: false
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        onStatusChanged: {
            if ( status == 3 ) {
                source = errorSVG.arg( settings.heliosImg.arg( settings.resolution ) )
            }
        }
    }

    Timer {
        id: timer
        interval: 1800000 // 30 minutes
        running: true
        repeat: true
        onTriggered: reloadImage()
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: menu.popup()
    }

    function setImg( src ) {
        settings.heliosImg = src
        reloadImage()
    }

    function changeResolution( res ) {
        settings.resolution = res
        reloadImage()
    }

    function reloadImage() {
        timer.stop()
        img.source = ""
        img.source = settings.heliosImg.arg( settings.resolution )
        timer.restart()
    }

    // setting menu icon via iconSource property do not work
    function makeStringImg( name, b64 ) {
        return "<img src='data:image/png;base64," + b64 + "'/>" + name
    }

    Menu {
        id: menu
        Menu {
            title: "Resolutions"
            MenuItem {
                text: "512"
                onTriggered: changeResolution( 512 )
            }
            MenuItem {
                text: "1024"
                onTriggered: changeResolution( 1024 )
            }
            MenuItem {
                text: "2048"
                onTriggered: changeResolution( 2048 )
            }
            MenuItem {
                text: "4096"
                onTriggered: changeResolution( 4096 )
            }
        }
        MenuSeparator {}
        MenuItem {
            text: makeStringImg( "SOHO LASCO C2", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIETIWJgSYGgAAAeFJREFUKM8tkr1qFFEAhb9z753ZybruEqMQMRKEKAqChZWN2FgK4hOJz2LpQ4jYqJ2dAUEhQoiJibuJO7Nz5x6LbH04nF+9kWaQIUMPHQyQoUCAAkCEGmrIOOwGXVkDFgQADIYBBjzgAVawlIzCsrgWNwLRVDgBULBxwZdSxj209hJCBwszDtydhg2rsiPgtUJvWJt0xiscxiA47nHP43tpu9EVOwRl1JkIGTqvQxYIN2vducrtTXXL0h70z57GURND8dgeQyetazDZZEjNjGtb2tkrk3tbq1vPP7x9f9geTiYTQ3N+3tsLGEEFlQgQ/hz79wG/vpM9mr14tb+YjWIiBkOaTqewk8JNMUOVJRNfSiFqKGqG+Wh7+vHdZ1vO2UNWqitWL59MRqddnVVDLcXHaNG7O1dYeO/RRXv9wbcv++Pp1VjX87P5/R3Nf3Zf5zqDBV6i1MCGVIkC+5/6ITQFln9OM2w3PNxMP84YwQlkMNZrKYKgWKeUExhJm9DBZmA6OCKJc/gLHaQVBOjgQm5DqKSYhyw6czJwIdWQIMEEakhRWkIr+uJYbCxd3oEiBtyiBAESVJBiKYYCAgOQJGOQ8QAB9xDRJSdNd3cnMf7Leb1o23ZHR5KCLOT1iyVoAPgPVOH5e0bvV90AAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTc6NTA6MjIrMDE6MDBQVCAFAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE3OjUwOjIyKzAxOjAwIQmYuQAAAABJRU5ErkJggg=="  )
            onTriggered: setImg( "http://sohowww.nascom.nasa.gov/data/realtime/c2/%1/latest.jpg" )
        }
        MenuItem {
            text: makeStringImg( "SOHO LASCO C3", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIETIhnrk9FQAAAclJREFUKM8t0EFuFFcURuHz33erqttuMDGWomSQrAFmbBk2wxKiTCJFiYlN6O6qV+/+DMz8O5Mj3n/CJiLuTloW74NsZMoGAy7Lrsf/vHaaApvW4u0bHQ9EaMrIpik9JZmWAOYpfn7QYWY4kOL+Trc3tOZMpixkidZ+6JBHGfRwz5Sp062W2TbLgmShMV4CbBRgXBomW3v7JnV7tEKZzOllRmIMth0biRbad5cdoSotc9KCkCNojXny8ViGb+c4n92CbWOUQgYbV4VaY5rIF32I+1e/vfv1UFv99Y8uV/Ud4TJjsO/aerB11o3e2bq3PU/Lh4d+/+cfd+enGsXdyZmAbKpsp/tOFftO3+O6rl+ePn5u+dw1H/TTa/7+V5eVFlZQBSQRtCbJl5Uvz3G98vX/fVl8M8fjE5nUhfMFm5Aikm2jy73rvOLhJk0Tp1uNwdNX5ombAxFaN9ewnbquBq0dFUuwy3P+mFvFutEDrDk9QlLW1kNillVUqoUjsAFAVYxhU0Kt1b6HwTJaxUFqtAAhAFqjBVW4JNW+u4+kqCq8KEwTJmRBhSLCJaLk8iiPgcjffzlGaAwjiPZt8+Pz1qKEbOMydpVfAHwHUi4ipF9y1x4AAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTc6NTA6MzQrMDE6MDD/LhWhAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE3OjUwOjMzKzAxOjAwS9STkwAAAABJRU5ErkJggg==" )
            onTriggered: setImg( "http://sohowww.nascom.nasa.gov/data/realtime/c3/%1/latest.jpg" )
        }
        MenuItem {
            text: makeStringImg( "SOHO EIT 171", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIETAbaoOGJQAAAiNJREFUKM9dkklPU2EUhp/z3duWwi2FggVBmYQYisOChSYEo4kr2bnxPxj057g3JsY1bt3oDhNpTRqGMIjFaphK6Tzc+x0XGGJ5d+e85zmrB/6PGISrEdMxdRRqwRHvvgYxcUKqDaoZqCCgAnoJCCKolfgj595LGbvjF2uysaUa0D6l+FkrK5eM/LtX6F+S28vsZjXwpdvT4wLN38SGZWBcDz9p/f0F4yCgLuahzC6z9oXKNo0ypXOCgiRTBC0OsyQfSChJPYNgRD14MfL6bagvqr1RiOD00TNEOK6lCo06ZkTiEffpK5gAXGWgb2FpdGHq6NepG+sPaj6m252ZCqZvudVqsLlDV9ieFWj4Ep/V830DpVaXOT1usroa5PbwEvJ4sWtxno1d9QPabbuVERFrhUgccIRmuz55VklwmJeQRzganr8bnZuwewehgbiO3cBEVI1EuimuaTnrANIaDKWeOJMjQf6IeiH4nq5v5+3xiTM27ud21IZ7poediXE//UGb+y6Ctn6IBnb3J6UClW2cGOsZdWmspGlFZCDVGkpo4Y8tfcXgIIC1B3UGZyiVqDcID2Pa6ueEQSJDlE/s6JzNvKOyCsYBkAatb1o1JvVMTJRKiaApOHijEr0myeuU05p7g/goIiIoGNSqSSzJ5HO7mRfj4fUSjWgxq+WPtNc71biq502kH+OiDYJ1gIunF/Ilk0lVBWq1WrVaxYDttFk7Vn8BPh4CJxnGH6AAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTc6NDg6MjgrMDE6MDAmfeB/AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE3OjQ4OjI3KzAxOjAwoWgoKgAAAABJRU5ErkJggg==" )
            onTriggered: setImg( "http://sohowww.nascom.nasa.gov/data/realtime/eit_171/%1/latest.jpg" )
        }
        MenuItem {
            text: makeStringImg( "SOHO EIT 195", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIETALdzSWQQAAAhxJREFUKM9lkk1PE2EUhc9535nSD/otjbGkkBTighBMNCJxY2LiRrcudOMfcO2PcuWfMCSoIRoSEAQhRRo+SimdTmemM/e6KH6gz/Lc56zuAf6CxL8QuB7a3wcCCphbzM9xRLJApqD+r9q1AkGFGpSf8N4L21i2lzXxI6brRA0Qav9Ph1d22tSfo9jE7iZE1boMDpSnYIFuHuGOoqUkVGEJaBrZxzo1z61PSDyVAWIfNkczC+kj/srCAllE3AYAoymUnzlvXj/IwpqucohSk6UZk2QkCeHUgSWdmsfKK4tpAnBQxe3F0sPG3Lfm+sYR9QLZDB4tmq7nHJzEuYxzeiYdL553THVJOofqIIGVeHVv6+37MJ22k3Nyt5E5OI1FZWIC69ujCQdwKLHmK+gAFjkUFuKYZxeeDANMFfBypREnThhF95sVP/EqJdPalHKNg2P0NtQixaSuT1cygG4fJv6Ae53zz7vejaoro2SnHV22bbXkzjbt/gfx99VhiG5Lf3Tdcz9wA3gd/RIahOi1w6AXaMVAZPmOdU1ytiUELEfQPg5NON3gzp4iho3AENERUAT70AjZevJ9Tb015fjTJsBgF15Om0smcuhfKCOYPGwZYlidYdTi8TuhQAlLUkETYbCtqUlTdNnpqXOTmSqThDjR8CP6qzq2ofh/n2AKmgMM4SuGV9sb2wBYq9VERESGwXDoD2mgcn3euFLH/AQNogpFW3lsqAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxNi0wMS0wOFQxNzo0ODoxMiswMTowMAyCuNIAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTYtMDEtMDhUMTc6NDg6MTErMDE6MDBMNxrzAAAAAElFTkSuQmCC" )
            onTriggered: setImg( "http://sohowww.nascom.nasa.gov/data/realtime/eit_195/%1/latest.jpg" )
        }
        MenuItem {
            text: makeStringImg( "SOHO EIT 284", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIETEbc5i3ZAAAAjtJREFUKM9tkktPE2EYhZ/3m17oZXAoDsVCiBRQECIQ4kqNMUY3Jm5c+Lf8FSb+BZdGQ4jReAmikiBCqQxQSy8ztMPMvC7USKJndRbnOasHzkQEEf6NgJzpf9eqAI4t5RKZNFHMfoOOTxTrWfj3cZIwZMvCtIwOgxCcYBcYL/PpK1t76jVodkgStX5xqlTH5MaydAPqR3QDagfsegzmWZhmfgrLopiXto8FFPOyeEmuTsu7L2zusDInD+9IeEoUE8VcHKPiypWqZtIcHZMql+TRPe7flMdPODpm2JHFmXiqQs2TlTlR1bERKQ2yPJd17ND7QWp5ltvXaLZxitxakflq/ODuaKE4YqU/ovHEhdR2PdZES07eLWkuG6ZyWc47rH1AlcsXZaHK1MzS4Ni8V/+0sRUdNLVxTNDDWG0jgFhtXyqu9EK2v5MymslKEmxuvFndqsVe0+x6Sasrra7EsRqjrzcw9UPWPpDLkkkRnhKe4p9QmZi8d2u8PJQkidlv0AuZHLf6IR0fA9psq+tgFwj67OzrwIAZtjvP17wXb6XmacqiMIDrJPsNmh0soHROquMYI1s1/BM5jXR9M9j4qvVDCfr0Q5ZnKeb06TNW32MBxkiri53HsaXdxfshB02JIsmkyQ0wMUouqy/f8mqdRksFxDLYBRkZ4vqSLl4Sr8Hnb2TT9EPKwyi6+o69QxotVT0jnzFUXJms0Gyzd0gU0+sDWshJxydOfvsnruuqKmhw0gt8HwT0P4b/cfkn/y4GxINE7mwAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTc6NDk6MjcrMDE6MDA/9/uoAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE3OjQ5OjI3KzAxOjAwTqpDFAAAAABJRU5ErkJggg==" )
            onTriggered: setImg( "http://sohowww.nascom.nasa.gov/data/realtime/eit_284/%1/latest.jpg" )
        }
        MenuItem {
            text: makeStringImg( "SOHO EIT 304", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIETEhtZRu1gAAAdlJREFUKM9tkjFPFFEYRc99MzvMsssaERYSJDGagImKCaGyN/EXWFpb+3uM8WdQWNgopTYSlJCQmIC44q6zzswyM+99FoAS8JY353zN/SIuRFyOu9JcZrpoXjTQYBnkdqaFq4KDh9LTVCstgmc0YWh8wDaDDS840Sndkx5H7nmqBaOoEHgjBLsrbUg78AscGEQtcVN6ZDzrKNQMPUF4ozJmYlXgg61JnyEDQbTo9MR4cd9Np25QWFnTdsxMUQVcIImQtJSwluptZQ3EC4GNDvfW9XNIOeFrjRNz8+o7c1KRk7Q1Og4rMbfRNuYCVI39+Bbv7WgwsDSmm9C5Hh8NyDKGmR0chumU3hR3YoColuaCbk3C77ElicYli31W15PRdz/bd72eSyOrGrNaWzW7HhdgHGiMpWWZqMWXI95vllVps9dCdeJbMd2FtN3RqAaIC2wfFSId26QiazDDV2rHHGxZDN0Wy6o/ju2TgYg8lEg5S7WqE7wHRy3G3hQUOSLP8cheFraLnQ1Xw57puOJBSzdaOCOGxGkmZhqGxiuzd2anE0eSgjQR+8ZhoI7VBLqi5ciMN95eB7bP6f8+KBHMIiDHinPor6F+v29mZpbneVmWkfD/zp39z4WCPzEG7DPmeEvkAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE2LTAxLTA4VDE3OjQ5OjMzKzAxOjAwBxLfJQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxNi0wMS0wOFQxNzo0OTozMyswMTowMHZPZ5kAAAAASUVORK5CYII=" )
            onTriggered: setImg( "http://sohowww.nascom.nasa.gov/data/realtime/eit_304/%1/latest.jpg" )
        }
        MenuItem {
            text: makeStringImg( "SOHO SDO/HMI Continuum", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAAAAAA6mKC9AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfgAQgSATQFSQKXAAAA8klEQVQY0wXBS07CUBQG4HP+22f6gBJGxomNAxHdBlOX4MCdMXENxkXoyIgJxJg4s0BpoLS99xy/j4kgNC0ntN38EYSYINliFoG0/XxpIAy5eBy3oiDEu+UvjGZP0QHEytTG8/fO0MNVbYTEGWeGPP7A5F6O4osWrbX+cTZFmfpJ4HueVZz5nJaYoIlCe7Y2M2EfaAE+wWd2q2K6z8LcMCoN0n7w5662J2bdYt2N+w5pUB/ClmVYY7fq98Y467zRyHlvlaGf24SMKnvce/Vzb9B93+WDJVWOm2UFJqJkcRMRa/v12kA4D5wOl9fU1ZuKIPQPxux0ROs8bmkAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTg6MDE6NTIrMDE6MDDjdDtVAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE4OjAxOjUyKzAxOjAwkimD6QAAAABJRU5ErkJggg==" )
            onTriggered: setImg( "http://sohowww.nascom.nasa.gov/data/realtime/hmi_igr/%1/latest.jpg" )
        }
        MenuItem {
            text: makeStringImg( "SOHO SDO/HMI Magnetogram", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH4AEIETE1r066qwAAAitJREFUKM9Nkj1PVGEQhZ957wfLstyVAAmwoA1GrDQRqIyJgdaosaHxJ0Bj/BlY6B8wsdBGA8YGsxi1BQsrl0DB14IRCLDsyu69933H4i7EZJKZyZyckzMzAgC+J6lV4MbV4vTEwGgpAjZ2a+XV32vbp/8D5LIZ6svPz44/vjfcEYWIZEStWuvD151nr37sH/3NYJKliZv9yy+nugcKWktSq+AulJEorO2fT82VVysHvicCDPXlK28fdvd0NutpGBgATQFQlNiSKwS143hsZnH/qGGAF3OT3YOFZj0NA0EdagEQxMf4HUHQrKfRYNf83DggY9d6fr55FARGVXEJ6hADgvFxFgEMOEHjlFtPP5rpiaEw6kwSi1rUIgYRxCAeYlAFwKSOjig3PVnyr48UQdVZjF4uB0CzVlDbLnCjpW6jCMYY3wMBgwiqkEXmRC5GBtTf2D3FOVQxgiqqkCEyvAcKgjiUjWrdLK9U47PY9/02Iw4RcOAudLLjmuZpq7xSNb82jxe+bUkUxikiBvHbBi6dQJykEgWL37fXtk4EKPV3Vd49KVwJm/Uk9E2bOFsuEidprss7O2mNzSzsHTaM75nqQWN6bql+muT68iI4FeuwVq11gs31hmfHzanZz3uHDd8Tz6kaYfdP4/Wn9eFi5+hIMSwEXs73coEXmOQ8eb+0+eD5l7Xtk/bzRVEUhqE6ex67Ziu9e7t0/85gbz5V1fWdWnmlWtk6/v+9/wGOAQzVe46iaQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxNi0wMS0wOFQxNzo0OTo1MyswMTowMMF91qIAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTYtMDEtMDhUMTc6NDk6NTMrMDE6MDCwIG4eAAAAAElFTkSuQmCC" )
            onTriggered: setImg( "http://sohowww.nascom.nasa.gov/data/realtime/hmi_mag/%1/latest.jpg" )
        }
        MenuSeparator {}
        MenuItem {
            text: makeStringImg( "AID AIA 94", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH4AEIEgQ4cYi6+QAAAhFJREFUKM81kk1PU2EUhJ857+XWtlikQhUx0dCFYNSQsNIY3bjzD/ifFRe6MGpUiASkYEHa3q/e9x4X1VlNJs9kNiMZSCQQIeLOQtI/LwMDoFnk4T9d49dZeaz2JpMJxZilQD2iPnAiSkAQXWoJB0cb6r9Q6JJdeGE0FXaGmVzET008RcliYUm4dJcbLzUdUZ04EUtRioOXhECyonLf/cKVEKxvbHlvV5Pf1EeEiAI0eAU51sdL4kzdbcWJ+4zgQ3/6prP3sD06j7GDl/IMlukMYU5dYSlNoL+l1hrZV0LrGa+fd2f5POnFIjIdu9o0xq17GmxbZ6ACX91QUZIkyn5gS5m9+341q8yz9GQ/akZs6G6yPQxHh/5n7POK8Q8vS5IeWiVUQbbBl4P467wmygMuhjt6tde6yCKBB/dt1njpnkZlnwgsa/BQRenLN4VUVVJNXnNSxONjhlvKo5fScNCZjurpBw8kSu+w88QOvlJmhEhzQjXn7JJ8xuXIfx4SG9t9fO1gv8y/ESTlCd07nB/j5nEMwjrYHJtQZNAwj346za/eiiuCJfIZo1N626przTNkGHgGEa1jbW7eVvHeqs+uQABUoQuVV2w+UrKqbIwa1CesoQ5tU77vxUdfvFAIDEkOtkJYoQb1REq4RjykOXbmKMCisH5rUFVVVZZpK1UUjdLuUlZm08spCBBOIgwCcv4Cz/cTthu1UZYAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTg6MDQ6NTYrMDE6MDDxEtQCAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE4OjA0OjU2KzAxOjAwgE9svgAAAABJRU5ErkJggg==" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_0094.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 131", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH4AEIEgQv8ls/PgAAAitJREFUKM9dkk9vE2cchJ95d73OBrdxIGt8IBGxAgni1N6AG0JqP0X7IbmjHOGSK0hg15HshIRYgXj/+V2/++sBaKTObaSZ0RyeiO+SiBzOYcb/FDmc/nMCcEKiNeJYh4/Z3VMU0TTmPdNT+2fyo9YaZvqx3Zr6fb18qcGAPDdQCOZX9H7h5sbevLHra+KI0IrIqTWyTK9eqaqYTi0EdROSrkkI3R9aHNvr11YURC7SxoYNBu7Fc7xnMqGuMVNr1jRUpbb6dnmhbsLRExuPCSHi3r3k77/i335nsbA0pSxoGtKU/X3KCu/V7dIGHRzQrJnNY0aj5OiJv7lpDw40HjOb8euWOadsh9GIquL8nF6PsmJnB8mpqsoPH1xdx0VhJyf4lbVBo1G0P+LjRz5/tq9fmYzxXnfvsrkZc35mi0VzfmbLnH4f7zFzDx/Gjx618zOrS+3t2ekpbctyyWoVkW64p08xUzYQmPfyvl0u14uFffmiw0MrS3W7nQcPwmTCp08xZWWXl+7ZMzs5oa4IgeUS4PqaTseOj2lb7e6yvc18DkS0QevAcKhv31gH8hxgo0tVk+ffH1qShIsLe/eOpolwUlEwn3N0pDhWnkvCjKKQE8Ohsoxej+NjFguknyw5p2ygP/9Qusl0Sgh0OqSp3bnD1ZW9fWtXV0iY6ZZWM5KE+wP1t+lvKe5YHPP+vc1mtwFQlmVN01RVlaYpZi6sXRRXq1VR17eE/0wD/wKV8Cr5/XHTVgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxNi0wMS0wOFQxODowNDo0NyswMTowMJvP3ygAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTYtMDEtMDhUMTg6MDQ6NDcrMDE6MDDqkmeUAAAAAElFTkSuQmCC" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_0131.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 171", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH4AEIEgQlEo7WIAAAAlBJREFUKM9N0ktvE1cYgOH3+86MPTP2xLng4DQlCQQakRQJqUVsoN2z7K6/of+RCqlFYsUtIKBKlDaJcRQ7vs54ZjxzTje98K6f5Sv8mwiACssNNtfwDEVJf8LVlKLkf/af9j2+XuPRXfn+NksRixLgtM/zD+7tX1yOsRbAINRrNAIObvDLE31wR43iG/FUilI2VuXhHnEg5wNJMpzDNENakdxal59/0GwhL485GzCcMZ6TFUxSKivfbIpnOO2T5piHe3K95R4faDOkNyRf4BxVRVEySmi3mKSkOd/tymDKxUj0WuyePPB+ehT4nm6sShwS1QnrbLWlGTBJmRfMMhDZWafmO91Y4cf7cbGwrQhER4kEPoFP3ZfH+7K/pXEorUhGM8K6GEWHiRyfzYaJVpjDk6qs3Cxjb5ODLXfUc5+HLs35o0tasNIkDjE1w52O64/tdG5VRUWCGt/uyM2OZgtJM9n9SnEurLls4V58wisqslICn+3rWq9xMayKkqevXXdghwm3Otob2pUmG6s6OqnSHJ3nHPfc/g2OPttuvzLKOMEzvD913Sv323v78cyVFYHPUY95gQK9EZ+6VJY4kqpitclShApZjrWu5pEV7uTCvjqmrDBGxVrOr+y9bVmLmaSoosp0joOddZabtJf49dA9e+eyBSbNSQqynD8vubctux2ZzqmsLDdot1hukC14+tY9O3RXM5z7Yr44ZLfD/ZusNGlFUvNp1Hlzwu8f3PmAefHPjtJut4uiSNM0ajSM4Hm63sKTLElSo3I5doMpX/Y3OYMZoH6wyfsAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTg6MDQ6MzcrMDE6MDCRCtYxAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE4OjA0OjM3KzAxOjAw4FdujQAAAABJRU5ErkJggg==" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_0171.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 193", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH4AEIEgQZPeGqpwAAApRJREFUKM9N0ktPE1EcBfD/f+6dR9vpg9KBtgjB8hZQUINEiS5cuDJh7ca9X0iXfga/gAtDIISFEJSHPKXYGdoybefZzr1zXUDQsz0nZ/UjAAAAiACAANAHYCggCQgF3FWIcJfbpRBQJvB6MvlieaxQSFu15s/jRjvgO7VwxwoBQEKIBdy+AuBcSrxbGVxcnopiaDVsRQbg/OKk3naY6fMve95VwImEPBaoSzCuwOrzwtKrucvTS/vqOgy5RIiiyYRI7U6XdyMmyR/Xmp0YAIF8eKK/WblXeTBaO6tWT+stL04lZEoRAVwn6M8neSyAseVpQ4qiapuR9y8LS29XByozTsPM5vWWE9Ust1TKTsxXBI8JAT2d0BJkdnHy4UhmY6tGi/dHdWPYt83yWKVdv5rsBUZOJjJJ5vIzz4oxj22zpqX0MAgkTZ3oAxoEzDFPQs+1Let0dx9RSqikv2RkjHJ1b1vREjFntdPzdF9Gz+XGihp5nOeDpVzj4ncUBlSREQUADFYqw7NPu55DFSU7WELBOGNxxNe//5ECNySyqukpY2Q4ncsqmgqILcs8315rXlYzhUIc9TRdT2bzgR8eNXu00XDbTbs8MXO8tQGIsQDz8jrqRYHTAcQf65s9302kkuML84e7J0cO0LM6q+7/yg0UGOOKQh27o2oKZ3HzquN5XVWREikNAJzaxe6BFQIQh6FvtUTHmlqY9P1AcEYpCUPWbLgIUBzql1WlWMyvrR193rS7gMTjcOhC3fRKkj/9aCqZkFv1a1UhhpEuDeXTKVWm8tf180/f6i4ggvjnsExhrKRxiRawN1FOcolKlG6fdw5MvxrcMBUCAA3DiKKo1+uirEZRDIiZpMp9z/a8/02jEDfe/wJsBUaucoc8WAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxNi0wMS0wOFQxODowNDoyNSswMTowMMo/x4YAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTYtMDEtMDhUMTg6MDQ6MjUrMDE6MDC7Yn86AAAAAElFTkSuQmCC" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_0193.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 211", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH4AEIEgQpGziaCwAAAplJREFUKM9V0k1v1EYcBvD/2B6P7fHa++pdQjYJEAhsEQVRitqq3DjxFTjy2Thx4wNwaoWEUFupJAhCCLubfYl31+/2esczwyFUKs/50aPn8FMBAAECBACgALqMmy62uBAMOAAAgIIQ/C8IAZIgAWAXt3/bHfx0e0CIPp7O352dLovkOJrMs/Bi9KKGAKCr1R92r9+9tr+zt8WliMJEVkJUYn6+DItsmPl/zN6XnKlI4VKga0bvl96Nn+/fdlrO/Ow8S/IsL7gQxCAgZRAnYiNCmb84/vPikvrs3uMHD+80vMbw03g8nk+jpakbWMMKArapbMsSSJqgH/T6BGlBnqpPHz1+8OR3u1VHnLda9clqeTQ87Xe9H+7c5JyDFF6naVHj7uDWo8GPs09zrbPt6dQq4qx/sOePZr+Wg7pu6UTv9rt1r84rkYWxadMkSsBU97tbGmPVcnjGGY+X0enhZwnQazUthxoOnf071TAu15s8LYhBDNO4fMnTQj9wG060jBRFsWq02rCiWDd7Le/KdhrEiqoqqrKa+OW6jJbhbLFSKsaJbWFDtxzLdimXAmPN0PHnv49CP3DadUwwdanl2mmQvh1+0FaLgJWs0WvPT8aY6Hm2XvgrxirHrWGsHv/1nq03Qsrt6/3TdTlKFtqX0bR/Mt452ONcsDRPomSzYYtFEIWJkNKmFiE6AFDTGE1mocjVtupYTJW8cpq1+fhcSqkoSrEugzgRQlBqggKuUzs6PHl5+NqvEvW8jOIoh7SqEfPK/i5RtTTOqG16rWbPa7u2bRHzzeHR839eTavwmyUA2NHbPVqvuTQssy3cuOpdKsRG1/WP09HHxWSY+RWIC3+o0+lUVRWlMTEMzgUgaFKH58xPV9+p/k/rVxtlXV7RPH5qAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE2LTAxLTA4VDE4OjA0OjQxKzAxOjAw+B/qEgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxNi0wMS0wOFQxODowNDo0MSswMTowMIlCUq4AAAAASUVORK5CYII=
" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_0211.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 304", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH4AEIEgQeo4U/BAAAAgtJREFUKM9tkrtqVFEYhb9/731mJjPJ5OLkhmJCQExIwNYUvoGdlbWthY9gYeGL2FhqJVhq5QWFqIhiJASTmOucOZc5l71/i5AQxdUsFixWsz44k4DwH9m/o5ybArBq5EZTWsKgYjfohnIc9GJBAAMBRuBe29yZMGNW8ISg/YTdwPMyPK3Dec0CCrPwcNze7tqTIf2CPFAZgqMlrBuZQ157VRCwkbAE99vm1qj52VcQJ1iLEfKCTltiz7KRDrzzqmCvIg9G5O5NW7Rty4S8RIM0IyYnKUvVWlstocH6qOzl+jXgrqMrPWM6XJ7WflOyFGmIs9qdMd0ZjCU9Uokwia4N5FmsboAcnWgSu2EsPz564wxGncW1o/3NUpE80TrI9JgsOKbAbaOxNdmh3/ql7Y4Yq8Ezc0Xnl216SPBhdFLSY1WvaSEpuALSQF3q4hI+kMYMC/Z3JXqbhYrFNTnYxl6ShkY7O0UBJoYviY5PEIQsQZVBTDZg6ztJnw+vdPNzyEvT7Jr3hQK2FiplxUsjM1jKgqCoofYkCXmGOIkG+vJb9aTU4vS4Q2EjYTViLjLDWhQqT1bgHGNtmTDyKddHmR6cHgcE+C28yZkVFjriSsasTI3QbVIrLxJ9nIQ9VQP6D6AW5oVryKIVY4jRtxWbqucgAdLr9bz3RVE0okhFKhHbbCZJqsngIs96NvoH9gIJSQIDUKgAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTg6MDQ6MzArMDE6MDBUrei/AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE4OjA0OjMwKzAxOjAwJfBQAwAAAABJRU5ErkJggg==
" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_0304.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 335", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH4AEIEgQz5lpjcQAAAkxJREFUKM81ksluW0cUBc/p7jeQfJRJWaYoxbKkeAic4QvyEUH+OKsgyS5ZKTFgWIgNSzTF4fHN3X1vFkKA2tSmVkWYBQgoSAtQowIKAtBHaIw+GhVQBwIgaVUJO0kWX5vJPLaVtCU1Sr/R9oFUJYHHrlnCZArLfJ6ef2+yIrYHFdUwSLsngdDJ4RaxVhJQ0l0pc1Ms0+WrUO1itYEEWkebKIDoaRyocXND7UBjkb+0z15nZy99uZX9PXWgMVCVGBB6k0/Vd1DYJ+faN9BgzemPP/z08+z8LAiQF7E56NAwLcYXryEh9IPNC7VpvrxmPgvbOzd5fjU7mT2sNstv397dvOtWnw2tmLQ4e86LK1/X9XqdTQvftHZ6DDe2tnhTSzKdjpvN9tMfvxrplS4/OV188+b+5m/pW18fQlXSpTbLfbl1/W5drb7Ud58VTMZjDU4GP3txef3dq/3qgSrzyxfr9x9i8Lqr0e+MRp/kWegHm+Xu6BjGEdKW1Z+//F6t7ovlGZI8f7p4dnmhodWhctpV0nfTr873t7cQQejQ7vb//LV3mUmyf387SNRsMkpP30pXA+LQ75tPH2w+Ej8geOlqWEuNGErtZGi2tGnb5B+bPpYrGFq6Y+n7rjwkR0+lrdT3AKGivgdh8iOTZG5SxC/vtH0AackxJKArY1Nly2smI2krGsvREzOeMx2RCOv3Uq9oDNQTZgFmMCnUIBnRJVDDZAKX0jppNtrtqR40Kj2kdScn8xhl8HAuIQbSW5d2XV3tPP8/GbSQHtKA+A/c+FdBW1B+vgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxNi0wMS0wOFQxODowNDo1MSswMTowMDS16owAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTYtMDEtMDhUMTg6MDQ6NTErMDE6MDBF6FIwAAAAAElFTkSuQmCC
" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_0335.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 1600", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH4AEIEgQ76IHrQwAAAaJJREFUKM9lUstOG0EQrH6MPQQchMUFiVuCBP//JVwQB74AZF7Jend2ZrpysAkOqWN3VUtdVcABRPA/vgztcEECgLssl+KuACK+auSQnbNcXNhqJe5CYp45DHx8jO02/hHs2N9P7ecPW62wWIiZMNA6e8d2y4eH/vzcdzT7uK03N3a2tqNs7rpI6q5qSEnccXwsLy+slSIfP1xd+eXlImc3Q0rqbu6qKiRExBMEstnE/umc9fp6cXLiyZWgu7rLcpl2MgBmqsKnR7ZOBZASUxISpVRVcdeU3JMDBKACBnOWfCQAHICIRPSpRF6YKsz0+ORbSv5am5pEINjmORjcC+YZtWK1Sm4CEOA4jtMoANx1jHBTwKZCAC6CaYpxhBlrDXeZpmbWRQWQaaqtdnN9e4tSKALbpTj85tmae1uAHuyNrfZSem3x673d3s7zjL2tIpgKhwHrtZihd/TO1qJ3tsZh4N1df32NfXB/qzEM3GzoDjMAJFFmPD3F/f0n+7NLh8hZchYRjBOnkYe9BCDn5+ckSymq6m4RFLFS6nb7/qXFO/wBoF3v2i/x1g8AAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTg6MDQ6NTkrMDE6MDAHWqTrAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE4OjA0OjU5KzAxOjAwdgccVwAAAABJRU5ErkJggg==" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_1600.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 1700", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAAB3RJTUUH4AEIEgUD2ZhinAAAAhBJREFUKM9VksluE0EQhmvpZTzj2MQ4RCgJIiccIeWUU448AM/AlZcCwYtwTAQREjkhBeEDclicOPGS8fT0UhzGMqFv9ddXrVbXB3DvIAAh3k8IEf9P+H5PAATAEvWsLZRKKXmRdWt96YpOIl1jXuzvD7a321kGILPl8tv46sNwOHGuAVYDTfG023l1dPS4/wi0QiIRkZQwxj/X1+/Pzi5ubhqMEVFEHhj7+vh4d2eHMmusUcZoo0mxMBWtYtDbPB+N7rxHRG7e9/JgcPRswHlLG6ON1doqrYmZEBNI22ac4vmv34RISSRX6nDvCWeZsZaZldbKaFsUWdFutTtZnnMre767t2FMEiEA6FjbKQpBjN4TK1ZKGaO0BgBERCQB7BZFr9UCANWkklKoXVYUiEjMrY02Kx28RyIVQ4yBCEVkNTBzblFVm3qLiAEgxbiczxFJUiLmGAMB3Dl3Uy0BgAjxzvuL8ZhSqqplisHX3lfOV1XwvpzPaucwxK+XP+e1J0QGRAC4nE4Pt7YyY0OKICnFFGMMtXNVJT5cX129PT1deA+I3CxuUdc/JpOD3sPCmJBS8CF4H4PnkCaTyZuTk+HtLSGKCAOAABDiuCy/jEZGJCeiGENdT6fTz8Pv7z59bOh/aqytagxra93LcwC4XS5ndb12Z4X1+/2UknNOKcXMIALMi7Ksy7L5cQAQWcsKfwHtzhg81FYooQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxNi0wMS0wOFQxODowNTowNCswMTowMMGvoHEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTYtMDEtMDhUMTg6MDU6MDMrMDE6MDB1VSZDAAAAAElFTkSuQmCC" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_1700.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 211, 193, 171", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIEgUITkq7FAAAApdJREFUKM9FytlOE1EYAOD/P2fOrO1MoRtUpaAVNGpE1KDBmHir8Rl8Si81JibEG8WIglGb1pbalbZ0OvtZvDHxu/4o/INAKChigzKBKshLsAAYgEJERAL/HwAAASS2UlfL5p0n14zy1qBndJs8iGDuj+bTXwBTRKmUAFAUkFhE21Cwe6dw6+Uzmt+6GAFamlcmZJ7ZajXnXQ8SKfiUEFBKYR70GuC9Haf04tHZaer3RlEEgpimraNBFzOSLHJgu9+anwCagII+XFvd3zcrD3aa31nvx3QWCt0CxiSlPDmPnIpHqS+DpL69zdLxMgzp0werz1/tVW4/lqNpqaLPgux3H6t1Y/fhilKZ1ETZE64nG/eLd2v+7+OhVrtZcWqPh2O/ccPpnsXbfqC7BUODWsktXd7iWTjr/HEL+sxfMNuoApJ0EXa6P5cjv9cWJx9a0YUssKS8eXWlfn3Y6s4n54kI/xz3VJSZK876qkYbkOXr5X5zksWxsiggiVDfurWzu3cpnM48W1brGwJFFutBkv467hC+kA7LrALLNy65xYK0DA04bR8evT8cds5X1so0mNm255VqyxDaS6FNxjzqj9f2DppvTwwSRIKMWlGaeIWLFgNy9Po8DSX3NrYPaHrUnytFzczIUSzW7fkgizR61uUJGLFmLy/SyVm2WJKYaBHVKQt/vvvS9gVlSGWHp91h8WBzEOR5FhAd0pAsBpFEdDar1Ml5Ne/0zdcvrUFMFA2B+6CWk0ybDhr7dWatL3qBZajier5a93KOY5D42+Hnjz86MQhQEjWCCiEH1BHEcp2I1czYqpYsbjBDN/u99njeCRRXmtJRmIyg47hSCqRUACTLEIADmAhMgQQAgAQoujmbc1Ew8Yqn/wXkxFBil2DSrwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxNi0wMS0wOFQxODowNTowOCswMTowMAYPygUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTYtMDEtMDhUMTg6MDU6MDgrMDE6MDB3UnK5AAAAAElFTkSuQmCC" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/f_211_193_171_%1.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 304, 211, 171", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIEgUMSSd/DQAAAm9JREFUKM81yllvE1cYBuD3O8uc2WzHTLBjo6QEgoFWCFqpaqNKFdf8an4AS8WisBMScOJ9GY9nOwsXlOf64fgfAZzAEDr4Ai6GDQAJOCICsZ8NAgDAflR3wxf3bvrqEJeqPtc2g12OzfIDMAcRnAEcBxj5AgdwD9qN3x7u8sNwBUUibBGY5mFC8cBkBmYOBjhH1PDQJ/weXUn+Dr5VeTp2ObgJuC8tcb1mtowLNIvXz4CPgOHsz8T95Tc7t8NPcjVcsLkmD1wacF2VeRi1ap4yV7KDgZZT2mTc/dtuPvrjuHMc2bnY9YpFbb8wb89L7rcrp401/lXjN2x0lGT3U/dlJNDvXImOvVHaP4rMebEabJXXYh52+82d5FDp7XQ5VE0vXaxDqdIuCVT58ux9VkfjuXlzcuqBbLuMG3ej9rW3L14SR1Zu2XAS+9e5H6EnBKYXcj4bzS4vGXaaiasKk8v93tXBfnc4+xrzTMtf0+F5nlE9cZhYjrvSu3ktrmQ/7HFX21Rbo9POcL1Ym/Hy1kFvYWZKB77cG01n+umpwEyn+eTO3j/lx5NKbeyWrce5qFrlzudAssfPZ7qyXX0QDnhZXdDKcaaUjVmdhOWiEoUovtZUKlZEelPmU12mJEqRF95nvq3fvaRTzSE5bJ1VI5Fc9y5jbTIQXEXVupAWQdxhrLFptbYnr9iLCxSOe4UVayc3uhAje/RLKHvlOuOB85NYdFs2jlaq2Lz+D0/OXGEAS55kzoJFHBGVYUR5n/kB64akJZSqL07d5Exk2jknhfEFI64i5yyBw5LVuYMGApCAswABBQdFzbC2pq1ov+V9B1kyRwMUJxdZAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE2LTAxLTA4VDE4OjA1OjEyKzAxOjAwbtWV1QAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxNi0wMS0wOFQxODowNToxMiswMTowMB+ILWkAAAAASUVORK5CYII=" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/f_304_211_171_%1.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 094, 335, 193", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIEgUP0C4utwAAAmNJREFUKM9dkltLVFEYhr/vW2vvPbOd0Rnn4IyWMxfa2EEiNISgIAiCoqt+QP80CIKuslAiFZ1SR23Ox31ce62vi0Sk5+6F97l7EBHhGgQwzPAftw4AAOJmMzNhqZx/Xcm/sGWFSLhWBoASHdzWEJEQ0bB25OZK4SVJ44VXbCxtdBT/QJwiwyzqJDpCJABGRGAGx2ksF96OvJ9+0AIIBRKRC2gbMyIc22Ju6J0wAyIJQZV0bmepuDWcHPjeIWGAmGaQWkttBrZVTjQlxlucuxcpZcATML/97s2HB3ceDbkj7JIKPZ1cWaKerz41YFRkSSdnaGGpsGXZ1elsX5bL9xu5ldN+p7a+0TxoTTpT2543LPOlYqXyKgpUr3eWyeZ8fypdFwCIJ5PPe2fAnaj3u3n4hXmsjVVarK9X6xfnzfGgqwLdbu8rHaREXjgFoQBdu3Z0eTLwQqHSCMgaG42Hz7efdIcDd2GuVq2FPiYqpDgazfYEi/RKdUeHnE0ta60SFbOOA0e3Lme97ulqbWOqxmBMvZjqD/vj2XfBJs7mGmvlx8dXX40xOvLC6EhNzLA/jCO/3zlud45Ae2vlzePL3SBsCgQVaeG6q5NpmxMR+ueEIEgyj5S6iKMpazKx6I9ld/KJeSqISMWt7vi8mHlmYj9OFKIF4Cf6DyCm7Lot3Vx6pTv+GKpfhALxOhOW1ub68ns/GnZG35DIEo4UWSILORnNdsP4BJCADWZchxmIUJs4UllJluFAiJIgW5AdxpcqGQlhAGwLOWUhknQBGIAQ0OgZM9zk/C91KWVmLhNrnXfw7oL1F1NRUz3VgfurAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE2LTAxLTA4VDE4OjA1OjE1KzAxOjAwq3KrWwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxNi0wMS0wOFQxODowNToxNSswMTowMNovE+cAAAAASUVORK5CYII=" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/f_094_335_193_%1.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID AIA 171 & HMIB", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIEgUTxC9y+AAAAhtJREFUKM890stS20AUBNC+89CMbIGJzctOUlmwARb8/6ekKgmERSB+gGVbtjSamXuzwJVed1dvDgEAQAQiCCAMUvAeisCMvgcLAEAgAgDmfxtAYTGd0vWVtlZlFkDqOr28oGnAfBxoIigNAoYVHh7sbFoSFdZaraxke3pqZzNh5l0DACIgYwDAe9zdOmFfb45X2kApUgqlF+e7H7/C31cwQ1cnVBT4+tV66/ZN5syAMAtnDj2qIQ6t5GRmM643HAJ0VeHmhu7vR+2h8DbEpBSxtVKdeMmRmTMbCJ2eqv0+1huYsxHd3enQV4U3Xd8cOj0cEkCDavjlOrdBlm/KGrStdq4Dkup6vL5IHwaQ/PxKzIpj/jzl2TS9LLHZcghh+ZZSIu+VVtA5YXRmd9vQda3Wnkiczbff4uD8odltNOnxxSizM4Zj7BYL1lrjfAJry7PJVc6MvE/Z/Fn5pjn0h+Zyktcbsa6cjHVdb+ZzUZlpXefLK7VcpHa3BVEbCJRX83q7S99/psWSIVFReH9nEWhrQApFkSQHrSUmay28l5jQJwPSRovR4XCon56EGVop5Ix1nS8v1aAsugBCJkLfg4g+jaT07Mvw+zmu1wCgP5CkhPd1urjI4zH1AQCVJaoBO5/b0D8+9qsVRMAMIiIASoEIzslkQs4p55TRMJbnc14sJUYA4AwA5LwRPgqPMTOLtdAaH6hTBPOR3Uf+Adp3QERkQVrUAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE2LTAxLTA4VDE4OjA1OjE5KzAxOjAwbNLBLwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxNi0wMS0wOFQxODowNToxOSswMTowMB2PeZMAAAAASUVORK5CYII=" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/f_HMImag_171_%1.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID HMI Magnetogram", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAAAAAA6mKC9AAAABGdBTUEAALGPC/xhBQAAAAJiS0dEAP+Hj8y/AAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIEgUXw0K24QAAANxJREFUGNMFwUFOwkAUgOF/3ryOlBpiVxaDoKKXcO9Wj6sewDNoYjShC3QhrTGkgTKd5/c5AJ0uStrVVwQcUN0uc8G6z5dv8HD9cBnAuVBdNQ2e6v4kYgZYMVttvd5d9GAYZozDu0xvtE8CeYzJpeWZzo/lyOtgCYl+KOZaSq9qB3QUM/NSCj2Zs+FHJ/ss5IK0piENeqpdPJizVurdKEUXwr6TiO1rXX9MdgjJZCwuvq69NYvci2EiZpunP8+2OS/MHOA2jzUemlVWqCN1b881OG9YVs1Kfuv1APwDqhZlXB0HT7UAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTg6MDU6MjMrMDE6MDBGLZmCAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE4OjA1OjIzKzAxOjAwN3AhPgAAAABJRU5ErkJggg==" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_HMIB.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID HMI Magnetogram - Colorized", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIEgUbyvT6ygAAAnhJREFUKM9V0j9vW3UUxvHnnPO71/Z1XP9J4tRSUspQgqCu1BAQvItIjKitmJkYGZgqKl5AXwAtYuhQWHgHiKVtOjTOQFoJyYYmaZ3Grn3/xPf3O4chS9mf7zN9CAAAFtagANY3LvavbXbXVgG8Oh4Pnv01Gh0CEOEQFAABYGZVXV5p37i1s7V9LaklIAAEQ5qlT3f3frn323h8ej6j8/SDzcvfff9Nu92azXJVJUDt/IsajWRyOr1z++7zg79ZWMxseaX9w4/fNi9UiuwtkXPCTGAGExlQ5HmS1D/7YuvPPx5lac4Avrq50+5cWBRpHLlIVEiFUXEQEscUR1GeFZ1268atLwHwpfe6V7c+/Hf6qpnMmUIZGGRMNi4CyyQW70ThNM2m1z/5aH2jx/3+pktcWpTZorHwURnYBw5KTF7AJfLYZURwfBbX4o/7V1y3uwYJjcqZ92u5V2FUnQ/KEWta1h3jTKnC5j07Jxd7q2ykDdSrtp6HYDCYEfvLzdEcb4ZF1orLqZ2mXk8WWakKY3d8NDYgC9mC0HHVWLwP8mLS0wVWIxE3r2soQghmxP746DXv7x3M0tkbzSNQ1Xk1zstKUdaaketUsQhRnRowjh0m2cn+4ICHw6PdJ/vvt3pNYRB5JSZ1EmLmoPK2WJqeVRbed5srL3ZfjoYvGcCD+78vZvNaksxyBFMQmACgDBzULPjlxlI2SX++/xCAiHCa5vuD559+fr3TaYWyJFM1gpGZCaPVWppO53du3/1ndMjC7+Bbbt/8emd7u58kNSIQAUCaFk8eD+799OvJO/jEzESkLEsAG5d6V/tXer1VgA4PXw/2DkbD//H+D2k2SUwoLZu2AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE2LTAxLTA4VDE4OjA1OjI3KzAxOjAwsmK9kQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxNi0wMS0wOFQxODowNToyNyswMTowMMM/BS0AAAAASUVORK5CYII=" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_HMIBC.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID HMI Intensitygram", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAAAAAA6mKC9AAAABGdBTUEAALGPC/xhBQAAAAJiS0dEAP+Hj8y/AAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIEgUmkpy22wAAAOdJREFUGNMFwTtPwzAUBtDv+tqNnYfUB0GIlaEVYmFDqD+dsROMHag6wYTaEB5JyMOxY84hAEC2yqgu6wCAAMSbda6pL46HBiBgsb1dxgzffr/uSkjE2/s8jQR8YiJ6ahh3D1fzVOtIKSl0/cHp480iMXqmhKAwuTe5utSzmVJMAj4y+YVMtRDMzARmVjoTICYgBIBAQJB1N3rvBQXvJ++6Rnyd+95aZ+042qErPtnKa80UJm+Htjo9vzN+kzljcuPQVsX+xTJcIU1wtvv7Oe13FQiAWW9yg/58PLQAiQCEdJmhKRsA+AcNOGXLzu5qkgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxNi0wMS0wOFQxODowNTozOCswMTowMIiAzeYAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTYtMDEtMDhUMTg6MDU6MzgrMDE6MDD53XVaAAAAAElFTkSuQmCC" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_HMII.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID HMI Intensitygram - Colorized", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIEgUfzZk+0wAAAgdJREFUKM9Vkj1rVGEQhZ/zzr13d5PVxGzAwiQmaUQFIZURRcTGQkhtp/4LG2t7QazVfyAoWJlG3NgYkBBETNRYiGQXk6zu7v14x2I16MMwhwOnmeEIAExUDjCVarnFwjjA1k/WOnQL/zegQ9MIunOGm6d0suXUARjwuaPH77m36f3KRzGNZKahp1e0dNppEmtEAwgVYQg91je1suo7fTchoBF4dS0snfPhEaxJyEQAoPKYU/Wo9Vh/p4sv/FflBtw9G24sM5wknZDGRD0hS8iMNCjBEs+dmXF8Xy+/u7VSPbykiVnXUWkMaplnDbKG0oYHkxxFuQdn3vXkA8lyi7lpylQhdZLE0zrpGEndFSiHDvIq1DzWfG6aCy3CYhNqVAITZliCZShBGZYRUmQY0aDmC83RdfIkcf4g3GE0Iw7/D5Bs9WAgCqeCGFUVHgoUkBMLvMKdiCoYaLvnSbvDzi6zxylzQloRBkjEcrRV9ClKH2JDtnd53cH6kSnT5VkKwwwU5aVioTJXMSAv6HvZ82SPB2s8++YGtDtcn9DMMXJHQjFSVpQlwxj7lAdeO2B9Q7falI6ZyCPPv3J1TCeahIiXxFw+cPWxHskebze0surd3E2Yg4kfBY8+uu9r3jWZE/qEA9Tlyyfdf6Pba7Gb87d8Zu5uonCIms7i+SkWmwBbPdodOv/X+zeG7QLB7ybaDQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxNi0wMS0wOFQxODowNTozMSswMTowMB0YiDUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTYtMDEtMDhUMTg6MDU6MzErMDE6MDBsRTCJAAAAAElFTkSuQmCC" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_HMIIC.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID HMI Intensitygram - Flattened", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIEgUj4vZCVAAAAiZJREFUKM9Nkk1rU1EQht85c+6NN8mtUo21NEbEKBTtRo0LcWe69GunK/9BCy78GZX6DwRBl626EBvcqAhWXaV0k0aaNJAoFmluEpt7zhkXN6mdzczAM+98MAQAgGYyVgBcPHusXJou5kNAas1u5Wt748efwwAdJIWp7NLClds3ZrwwhbENu/uvPrYePf3W7EQJRom7PndybbmczqXdXmysAwQAQJqhQq/36+/8YuVz9admIgCFqczmi7vpMDXoGd9jwEH+18TGHcl4va6ZfbDS7EQKwJPFUjqXHvSN7xHEQhJUgTRIe74/6NlMLlhavAaALp2b/P7sDislIpAYEIAAgtLiHEgICgBBjMPlh6uqXJrxwiA2FmIgFoCAQAxiECE5DJFx4oepcimvi/kQArEWSkBqJA+BCFESu9E6cMV8qIgUiJTHYzSh3Xi2xAikAAWIru3sQSycAxNEBEIAiMckjwpEIFLbidTal1bci1lriABCI+GDJsk0wor2u3FlvaWqW79ff2jyhD+0GPfFiBaXqAxjyxP6zafGRn2XAJw5FW6+vBdkvUHPeJoJFiJQGgIQDWMTpFU/imfvrzQ6kdKsttvd+YV3g8gExwOCs05ZIWuddZbEBpN+vzucX1hrdCLNxE6Embbb0fO39cJk5kLhqJ/1OMWc8thns29WK9u3Hr+v1ndHz8fMIqJZDWMDYK544ubV6fOnJwSoNfcq663q1u7h9/4HCjYW0oMyzXgAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTg6MDU6MzUrMDE6MDDpV6wmAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE4OjA1OjM1KzAxOjAwmAoUmgAAAABJRU5ErkJggg==" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_HMIIF.jpg" )
        }
        MenuItem {
            text: makeStringImg( "AID HMI Dopplergram", "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAAAAAA6mKC9AAAABGdBTUEAALGPC/xhBQAAAAJiS0dEAP+Hj8y/AAAACXBIWXMAAAsSAAALEgHS3X78AAAAB3RJTUUH4AEIEgUr7C3KZgAAANZJREFUGNMtx01KQlEcxuHf+5577kUtpA+xIImmFUS5mpbWBqI9tIOgWQgVBBpGg5yUBmmef5Oe2SOA1B/s5Pl4vAIEbJ0cdlutFpPbF0jQO+/XVc65czScTUlsHHdSbuq6qavts8cPez8XLNk2e5eN2501AklKjuFp1f4fstHmhbNChGQRlg+skCScLEWAlxYQZV0CYv3qRTEBUSJK8Hnv74VFRJQSpehu5HhbJUtBlDXTmx8zf1pmI0rx+9UzCRazptvOVVo+XI9AJiL1BrvV12TyC/wB6ztRy3PTSKYAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTYtMDEtMDhUMTg6MDU6NDQrMDE6MDBF5a6LAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE2LTAxLTA4VDE4OjA1OjQzKzAxOjAw8R8ouQAAAABJRU5ErkJggg==" )
            onTriggered: setImg( "http://sdo.gsfc.nasa.gov/assets/img/latest/latest_%1_HMID.jpg" )
        }
    }
    Component.onCompleted: reloadImage()

}
