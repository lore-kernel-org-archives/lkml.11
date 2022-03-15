Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F187EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 17:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245158AbiCORng (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239523AbiCORnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A58B58E4F;
        Tue, 15 Mar 2022 10:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD2BF615DB;
        Tue, 15 Mar 2022 17:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E43C340E8;
        Tue, 15 Mar 2022 17:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647366142;
        bh=fthfjXVt7Bp2FFoEC8d2OpN/NXHxJduJSdvt+y0+wXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEzzIzE+NrrLwhy5BBYLT0Hg1DhsFdqRLwndEFnoLsA/MKLw1Oyo0IT0QWruQnA9g
         7r2gkSXCGSr6J6lc5EareWuiUIPHDKPSwLfDwUCB4vSG1weAwCt4ZjDGiPe0AhsqW5
         UU7DZQTEEAyDAh4YTHMPRvOTsu1ayD14lTk5BJaU=
Date:   Tue, 15 Mar 2022 18:42:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v3] usb: dwc3: Don't switch OTG -> peripheral if extcon
 is present
Message-ID: <YjDP9vLpSL6VTRKr@kroah.com>
References: <20220228171252.1827788-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228171252.1827788-1-andrew.smirnov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 09:12:52AM -0800, Andrey Smirnov wrote:
> If the extcon device exists, get the mode from the extcon device. If
> the controller is DRD and the driver is unable to determine the mode,
> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
> 
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Thinh Nguyen <thinhn@synopsys.com>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Changes since [v2] of the patch:
> 
>    - Fixed "Minor formatting change", to reflect what was meant by
>      review comment
> 
> Changes since [v1] of the patch:
> 
>    - Reworded commit message
>    - Minor formatting change

Does not apply to my tree :(

