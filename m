Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB80FC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Feb 2022 19:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbiBFTug (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Feb 2022 14:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiBFTue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 14:50:34 -0500
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A596AC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 11:50:33 -0800 (PST)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 93013611B0;
        Sun,  6 Feb 2022 19:50:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 8CD6C1D;
        Sun,  6 Feb 2022 19:50:13 +0000 (UTC)
Message-ID: <d9ce0f60350b867e65bb0a05f961c42d6c20d4db.camel@perches.com>
Subject: Re: [PATCH] staging: octeon-usb: Fix 'should not end with '(''
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'joelcchangg@gmail.com'" <joelcchangg@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.com" <gregkh@linuxfoundation.com>
Date:   Sun, 06 Feb 2022 11:50:30 -0800
In-Reply-To: <8536ca17c2945cb77c506d99eff5ccc42e71f2f3.camel@perches.com>
References: <20220206074615.3527-1-joelcchangg@gmail.com>
         <c0b504dd1f254f19b6ff60948684303b@AcuMS.aculab.com>
         <8536ca17c2945cb77c506d99eff5ccc42e71f2f3.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8CD6C1D
X-Stat-Signature: opnfayb4ossgottt4rcdkdm717cqr87t
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/XFceJYsvyMkGaDDxP5UWNelFbS+zOkY8=
X-HE-Tag: 1644177013-779463
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-02-06 at 09:17 -0800, Joe Perches wrote:
> On Sun, 2022-02-06 at 14:16 +0000, David Laight wrote:
> > From: joelcchangg@gmail.com
> > > Sent: 06 February 2022 07:46
[]
> This _might_ be better with the return type on a separate line
> 
> Something like:
> 
> static struct cvmx_usb_transaction *
> cvmx_usb_submit_transaction(struct octeon_hcd *usb, struct cvmx_usb_pipe *pipe,
> 			    enum cvmx_usb_transfer type,
> 			    u64 buffer, int buffer_length,
> 			    u64 control_header, int iso_start_frame,
> 			    int iso_number_packets,
> 			    struct cvmx_usb_iso_packet *iso_packets,
> 			    struct urb *urb)

As this is a static function only used by this compilation unit,
it's maybe even better removing the unnecessary cvmx_usb_ prefix too.

Maybe a bunch of unnecessary prefix removals...



