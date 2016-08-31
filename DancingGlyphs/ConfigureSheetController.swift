/*
 *  Copyright 2016 Erik Doernenburg
 *
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may
 *  not use these files except in compliance with the License. You may obtain
 *  a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 *  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 *  License for the specific language governing permissions and limitations
 *  under the License.
 */

import ScreenSaver

class ConfigureSheetController : NSObject
{
    static var sharedInstance = ConfigureSheetController()
    
    @IBOutlet var window: NSWindow!
    @IBOutlet var versionField: NSTextField!
    @IBOutlet var schemePopup: NSPopUpButton!
    @IBOutlet var glyphPopup: NSPopUpButton!
    @IBOutlet var sizePopup: NSPopUpButton!
    @IBOutlet var movementPopup: NSPopUpButton!
    
    override init()
    {
        super.init()

        let myBundle = NSBundle(forClass: ConfigureSheetController.self)
        myBundle.loadNibNamed("ConfigureSheet", owner: self, topLevelObjects: nil)

        let bundleVersion = (myBundle.infoDictionary!["CFBundleShortVersionString"] ?? "n/a") as! String
        let sourceVersion = (myBundle.infoDictionary!["DGSourceVersion"] ?? "n/a") as! String
        versionField.stringValue = String(format: "Version %@ (%@)", bundleVersion, sourceVersion)
    }
    

    @IBAction func openProjectPage(sender: AnyObject)
    {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "http://github.com/thoughtworks/dancing-glyphs")!);
    }

    @IBAction func closeConfigureSheet(sender: NSButton)
    {
        if sender.tag == 1 {
            saveConfiguration()
        }
        window.sheetParent!.endSheet(window, returnCode: (sender.tag == 1) ? NSModalResponseOK : NSModalResponseCancel)
    }


    func loadConfiguration()
    {
        let config = Configuration()
        schemePopup.selectItemWithTag(config.scheme)
        glyphPopup.selectItemWithTag(config.glyph)
        sizePopup.selectItemWithTag(config.size)
        movementPopup.selectItemWithTag(config.movement)
    }

    private func saveConfiguration()
    {
        let config = Configuration()
        config.scheme = schemePopup.selectedTag()
        config.glyph = glyphPopup.selectedTag()
        config.size = sizePopup.selectedTag()
        config.movement = movementPopup.selectedTag()
    }

}
