
$htmlContent = @"
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
   </head>
   <body>
      <table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" style="margin:0; padding:2em 0; background-color:#f2f2f2; height:100%!important; width:100%!important">
         <tbody>
            <tr>
               <td align="center" valign="top" style="border-collapse:collapse; padding:10px">
                  <table border="0" cellpadding="10" cellspacing="0" width="740" style="background-color:#ffffff">
                     <tbody>
                        <tr>
                           <td style="padding:0px"><img alt="WatchGuard Logo" src="data:image/jpeg;base64,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" style="width:100%"></td>
                        </tr>
                        <tr>
                           <td style="font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px; font-weight:normal; color:#747b7f; padding:20px">
                              <p>Dear administrator,</p>
                              <p>WatchGuard EPDR has detected activity by a threat of type <strong style="color:#c72a15">&quot;potentially unwanted program&quot;</strong> named <strong style="color:#c72a15">&quot;PUP/TencentQQLive&quot;</strong> on computer <strong style="color:#c72a15">&quot;AHT19ITNB0060&quot;</strong>, on 8/1/2024 9:10:50 AM UTC.</p>
                              <p>Please contact our Technical Support team if you have any questions.</p>
                              <h2 style="margin-top:2em; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px; font-weight:normal; background-color:#e0e0e0; color:#000; padding:2px 5px">Threat details</h2>
                              <table border="0" cellpadding="8px" cellspacing="0" height="100%" width="100%">
                                 <tbody>
                                    <tr>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; font-size:15px!important; width:30%">Computer:</th>
                                       <td style="font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px!important">AHT19ITNB0060</td>
                                    </tr>
                                    <tr>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; font-size:15px!important; width:30%">Group:</th>
                                       <td style="font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px!important">All\AAPICO\AA</td>
                                    </tr>
                                    <tr>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; font-size:15px!important; width:30%">Name:</th>
                                       <td style="font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px!important">PUP/TencentQQLive</td>
                                    </tr>
                                    <tr>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; font-size:15px!important; width:30%">Path:</th>
                                       <td style="font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px!important">PROGRAM_FILESX86|\WXWork\4.1.26.6019\zlib1.dll</td>
                                    </tr>
                                    <tr>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; font-size:15px!important; width:30%">Hash:</th>
                                       <td style="font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px!important">64FCA55D5E9FBAF449D85790DCA4D81F</td>
                                    </tr>
                                    <tr>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; font-size:15px!important; width:30%">Infection source computer:</th>
                                       <td style="font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px!important"></td>
                                    </tr>
                                    <tr>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; font-size:15px!important; width:30%">Infection source IP address:</th>
                                       <td style="font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px!important"></td>
                                    </tr>
                                    <tr>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; font-size:15px!important; width:30%">Infection source user:</th>
                                       <td style="font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px!important"></td>
                                    </tr>
                                 </tbody>
                              </table>
                              <h2 style="margin-top:2em; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px; font-weight:normal; background-color:#e0e0e0; color:#000; padding:2px 5px">Threat life cycle</h2>
                              <table border="0" cellpadding="8px" cellspacing="0" height="100%" width="100%">
                                 <tbody>
                                    <tr>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; color:#000; border-bottom:1px solid #ddd; font-size:15px!important"><strong>Date</strong></th>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; color:#000; border-bottom:1px solid #ddd; font-size:15px!important"><strong>Action</strong></th>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; color:#000; border-bottom:1px solid #ddd; font-size:15px!important"><strong>Path/URL/Registry/Key</strong></th>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; color:#000; border-bottom:1px solid #ddd; font-size:15px!important"><strong>File/Hash/Registry Value</strong></th>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; color:#000; border-bottom:1px solid #ddd; font-size:15px!important"><strong>Trusted</strong></th>
                                    </tr>
                                    <tr>
                                       <td style="word-wrap:break-word; max-width:200px; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; color:#747b7f; font-size:15px!important">8/1/2024 9:10:41 AM UTC</td>
                                       <td style="word-wrap:break-word; max-width:200px; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; color:#747b7f; font-size:15px!important">Is loaded by</td>
                                       <td style="word-wrap:break-word; max-width:200px; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; color:#747b7f; font-size:15px!important">PROGRAM_FILESX86|\WXWork\WXWork.exe</td>
                                       <td style="word-wrap:break-word; max-width:200px; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; color:#747b7f; font-size:15px!important">1BFC5CF8B5A6F6223E2151EAC8841F9A</td>
                                       <td style="word-wrap:break-word; max-width:200px; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; color:#747b7f; font-size:15px!important">Yes</td>
                                    </tr>
                                 </tbody>
                              </table>
                              <h2 style="margin-top:2em; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px; font-weight:normal; background-color:#e0e0e0; color:#000; padding:2px 5px">Occurrences on the network</h2>
                              <table border="0" cellpadding="8px" cellspacing="0" height="100%" width="100%">
                                 <tbody>
                                    <tr>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; color:#000; border-bottom:1px solid #ddd; font-size:15px!important"><strong>Computer</strong></th>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; color:#000; border-bottom:1px solid #ddd; font-size:15px!important"><strong>First seen</strong></th>
                                       <th style="font-weight:normal; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; text-align:left; color:#000; border-bottom:1px solid #ddd; font-size:15px!important"><strong>File path</strong></th>
                                    </tr>
                                    <tr>
                                       <td style="word-wrap:break-word; max-width:200px; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; color:#747b7f; font-size:15px!important">AHT19ITNB0060</td>
                                       <td style="word-wrap:break-word; max-width:200px; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; color:#747b7f; font-size:15px!important">7/11/2024 6:49:32 AM UTC</td>
                                       <td style="word-wrap:break-word; max-width:200px; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; color:#747b7f; font-size:15px!important">PROGRAM_FILESX86|\WXWork\4.1.26.6019\zlib1.dll</td>
                                    </tr>
                                 </tbody>
                              </table>
                              <p style="margin-top:2em">This is the second alert regarding the same threat detected on the same computer today. To avoid generating too much email traffic, you won't receive any more email alerts pertaining to this item today.</p>
                              <div style="margin-top:2em; padding-top:1em; border-top:2px dotted #eeeeee"><span style="color:#747b7f; font-family:Campton,Century Gothic,Helvetica,Arial,sans-serif; font-size:15px!important">Regards,<br>WatchGuard </span></div>
                           </td>
                        </tr>
                     </tbody>
                  </table>
               </td>
            </tr>
         </tbody>
      </table>
   </body>
</html>
"@

